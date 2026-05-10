/// api_service.dart
///
/// Single Dart service that wires the Flutter mobile app to the shared
/// Node.js + Express backend (port 5000).  Every endpoint maps 1-to-1 to
/// the routes defined in backend/src/routes/.
///
/// Usage:
///   final api = ApiService(baseUrl: 'http://10.0.2.2:5000');  // Android emulator
///   await api.login(email: 'doc@hospital.com', password: 'secret');
///   final queue = await api.getDoctorQueue();

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String baseUrl;
  String? _token;

  ApiService({required this.baseUrl});

  // ─── token management ──────────────────────────────────────────────────────

  void setToken(String token) => _token = token;
  void clearToken() => _token = null;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  // ─── helpers ───────────────────────────────────────────────────────────────

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<Map<String, dynamic>> _checkResponse(http.Response res) {
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode >= 200 && res.statusCode < 300) return Future.value(body);
    throw ApiException(
      statusCode: res.statusCode,
      message: body['message'] ?? 'Unknown error',
    );
  }

  // ─── AUTH  /api/auth ───────────────────────────────────────────────────────

  /// POST /api/auth/register
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String role = 'patient',
    String? phone,
  }) async {
    final res = await http.post(
      _uri('/api/auth/register'),
      headers: _headers,
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'role': role,
        if (phone != null) 'phone': phone,
      }),
    );
    final data = await _checkResponse(res);
    _token = data['token'];
    return data;
  }

  /// POST /api/auth/login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      _uri('/api/auth/login'),
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = await _checkResponse(res);
    _token = data['token'];
    return data;
  }

  /// GET /api/auth/me
  Future<Map<String, dynamic>> getMe() async {
    final res = await http.get(_uri('/api/auth/me'), headers: _headers);
    return _checkResponse(res);
  }

  // ─── SCANS  /api/scans ─────────────────────────────────────────────────────

  /// POST /api/scans/predict — uploads a scan image and gets AI diagnosis.
  /// [source] = 'mobile' so the backend records where the scan came from.
  Future<Map<String, dynamic>> uploadScan({
    required File imageFile,
    required String bodyPart,
    int painLevel = 0,
    int durationDays = 0,
    bool recentInjury = false,
    String notes = '',
  }) async {
    final request = http.MultipartRequest(
      'POST',
      _uri('/api/scans/predict'),
    );
    request.headers['Authorization'] = 'Bearer $_token';

    // Detect mime type from extension
    final ext = imageFile.path.split('.').last.toLowerCase();
    final mimeMap = {
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'bmp': 'image/bmp',
      'tiff': 'image/tiff',
      'tif': 'image/tiff',
      'dcm': 'application/dicom',
    };
    final mime = mimeMap[ext] ?? 'application/octet-stream';
    final parts = mime.split('/');

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType(parts[0], parts[1]),
    ));

    request.fields['bodyPart'] = bodyPart;
    request.fields['painLevel'] = painLevel.toString();
    request.fields['durationDays'] = durationDays.toString();
    request.fields['recentInjury'] = recentInjury.toString();
    request.fields['notes'] = notes;
    request.fields['source'] = 'mobile'; // tag origin for backend analytics

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);
    return _checkResponse(res);
  }

  // ─── REPORTS  /api/reports ─────────────────────────────────────────────────

  /// GET /api/reports  — scoped automatically by role on the backend
  Future<Map<String, dynamic>> listReports({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    final params = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (status != null) 'status': status,
    };
    final res = await http.get(
      _uri('/api/reports').replace(queryParameters: params),
      headers: _headers,
    );
    return _checkResponse(res);
  }

  /// GET /api/reports/:id
  Future<Map<String, dynamic>> getReport(String reportId) async {
    final res = await http.get(_uri('/api/reports/$reportId'), headers: _headers);
    return _checkResponse(res);
  }

  // ─── DOCTOR  /api/doctor ───────────────────────────────────────────────────

  /// GET /api/doctor/dashboard
  Future<Map<String, dynamic>> getDoctorDashboard() async {
    final res = await http.get(_uri('/api/doctor/dashboard'), headers: _headers);
    return _checkResponse(res);
  }

  /// GET /api/doctor/queue?status=awaiting_review|reviewed&page=1&limit=20
  Future<Map<String, dynamic>> getDoctorQueue({
    String status = 'awaiting_review',
    int page = 1,
    int limit = 20,
  }) async {
    final params = {
      'status': status,
      'page': page.toString(),
      'limit': limit.toString(),
    };
    final res = await http.get(
      _uri('/api/doctor/queue').replace(queryParameters: params),
      headers: _headers,
    );
    return _checkResponse(res);
  }

  /// PATCH /api/doctor/queue/:reportId/review
  Future<Map<String, dynamic>> submitReview({
    required String reportId,
    required bool agreed,
    required String finalDiagnosis,
    String notes = '',
  }) async {
    final res = await http.patch(
      _uri('/api/doctor/queue/$reportId/review'),
      headers: _headers,
      body: jsonEncode({
        'agreed': agreed,
        'finalDiagnosis': finalDiagnosis,
        'notes': notes,
      }),
    );
    return _checkResponse(res);
  }

  /// GET /api/doctor/schedule
  Future<Map<String, dynamic>> getDoctorSchedule() async {
    final res = await http.get(_uri('/api/doctor/schedule'), headers: _headers);
    return _checkResponse(res);
  }

  /// PATCH /api/doctor/schedule/:slotId
  Future<Map<String, dynamic>> updateScheduleSlot({
    required String slotId,
    required String status,
    String statusNote = '',
    DateTime? scheduledAt,
  }) async {
    final res = await http.patch(
      _uri('/api/doctor/schedule/$slotId'),
      headers: _headers,
      body: jsonEncode({
        'status': status,
        if (statusNote.isNotEmpty) 'statusNote': statusNote,
        if (scheduledAt != null) 'scheduledAt': scheduledAt.toIso8601String(),
      }),
    );
    return _checkResponse(res);
  }

  // ─── ANNOTATIONS  /api/annotations ────────────────────────────────────────

  /// GET /api/annotations/:reportId
  Future<Map<String, dynamic>> getAnnotations(String reportId) async {
    final res = await http.get(_uri('/api/annotations/$reportId'), headers: _headers);
    return _checkResponse(res);
  }

  /// POST /api/annotations/:reportId
  Future<Map<String, dynamic>> addAnnotation({
    required String reportId,
    required String type, // circle | arrow | rectangle
    required Map<String, dynamic> coordinates, // { x, y, width, height }
    String label = '',
    String color = '#FF0000',
  }) async {
    final res = await http.post(
      _uri('/api/annotations/$reportId'),
      headers: _headers,
      body: jsonEncode({
        'type': type,
        'label': label,
        'color': color,
        'coordinates': coordinates,
      }),
    );
    return _checkResponse(res);
  }

  /// DELETE /api/annotations/:reportId/:annotationId
  Future<Map<String, dynamic>> deleteAnnotation({
    required String reportId,
    required String annotationId,
  }) async {
    final res = await http.delete(
      _uri('/api/annotations/$reportId/$annotationId'),
      headers: _headers,
    );
    return _checkResponse(res);
  }

  // ─── APPOINTMENTS  /api/appointments ──────────────────────────────────────

  /// GET /api/appointments/doctors — list bookable doctors
  Future<Map<String, dynamic>> listDoctors() async {
    final res = await http.get(_uri('/api/appointments/doctors'), headers: _headers);
    return _checkResponse(res);
  }

  /// POST /api/appointments  (patient only)
  Future<Map<String, dynamic>> createAppointment({
    required String doctorId,
    required DateTime scheduledAt,
    int durationMinutes = 30,
    String reason = '',
    String? reportId,
  }) async {
    final res = await http.post(
      _uri('/api/appointments'),
      headers: _headers,
      body: jsonEncode({
        'doctorId': doctorId,
        'scheduledAt': scheduledAt.toIso8601String(),
        'durationMinutes': durationMinutes,
        'reason': reason,
        if (reportId != null) 'reportId': reportId,
      }),
    );
    return _checkResponse(res);
  }

  /// GET /api/appointments
  Future<Map<String, dynamic>> listAppointments() async {
    final res = await http.get(_uri('/api/appointments'), headers: _headers);
    return _checkResponse(res);
  }
}

// ─── exception ─────────────────────────────────────────────────────────────

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
