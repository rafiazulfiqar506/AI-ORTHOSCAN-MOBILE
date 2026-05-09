import 'package:flutter/material.dart';
import 'results_screen.dart';

class UploadScanScreen extends StatefulWidget {
  const UploadScanScreen({super.key});

  @override
  State<UploadScanScreen> createState() => _UploadScanScreenState();
}

class _UploadScanScreenState extends State<UploadScanScreen> {
  String selectedPatient = 'Ahmed Khan';
  String selectedScanType = 'X-Ray';
  String selectedBodyPart = 'Knee';
  bool fileSelected = false;

  final List<String> patients = ['Ahmed Khan', 'Sara Raza', 'M. Hassan'];
  final List<String> scanTypes = ['X-Ray', 'MRI', 'CT Scan'];
  final List<String> bodyParts = ['Knee', 'Shoulder', 'Spine', 'Hip', 'Wrist', 'Ankle'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF071E2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FFFF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Upload New Scan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionCard(
              'Select Patient',
              Column(
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF00FFFF)),
                      hintText: 'Search patient name...',
                      hintStyle: TextStyle(color: const Color(0xFF00FFFF).withOpacity(0.5)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: const Color(0xFF00FFFF).withOpacity(0.35)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF00FFFF)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: patients.map((p) => ChoiceChip(
                      label: Text(p),
                      selected: selectedPatient == p,
                      onSelected: (_) => setState(() => selectedPatient = p),
                      selectedColor: const Color(0xFF00FFFF),
                      labelStyle: TextStyle(
                        color: selectedPatient == p ? const Color(0xFF050F1A) : Colors.white,
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _sectionCard(
              'Scan Type',
              Row(
                children: scanTypes.map((type) => Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedScanType = type),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedScanType == type
                            ? const Color(0xFF00FFFF).withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedScanType == type
                              ? const Color(0xFF00FFFF)
                              : const Color(0xFF00FFFF).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.document_scanner,
                              color: selectedScanType == type
                                  ? const Color(0xFF00FFFF)
                                  : Colors.grey),
                          const SizedBox(height: 4),
                          Text(type,
                              style: TextStyle(
                                color: selectedScanType == type
                                    ? const Color(0xFF00FFFF)
                                    : Colors.grey,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 12),
            _sectionCard(
              'Body Part',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: bodyParts.map((part) => GestureDetector(
                  onTap: () => setState(() => selectedBodyPart = part),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedBodyPart == part
                          ? const Color(0xFF00FFFF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selectedBodyPart == part
                            ? const Color(0xFF00FFFF)
                            : const Color(0xFF00FFFF).withOpacity(0.3),
                      ),
                    ),
                    child: Text(part,
                        style: TextStyle(
                          color: selectedBodyPart == part
                              ? const Color(0xFF050F1A)
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => setState(() => fileSelected = true),
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF00FFFF),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  color: const Color(0xFF00FFFF).withOpacity(0.03),
                ),
                child: fileSelected
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 40),
                          const SizedBox(height: 8),
                          const Text('knee_xray_ahmed.jpg',
                              style: TextStyle(color: Colors.white)),
                          const Text('2.4 MB',
                              style: TextStyle(color: Color(0xFF00FFFF))),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cloud_upload,
                              color: Color(0xFF00FFFF), size: 48),
                          const SizedBox(height: 8),
                          const Text('Tap to select scan file',
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('Supported: DICOM, JPEG, PNG • Max 50MB',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 12)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ResultsScreen()),
                  );
                },
                icon: const Icon(Icons.rocket_launch, color: Color(0xFF050F1A)),
                label: const Text('Analyze Scan',
                    style: TextStyle(
                        color: Color(0xFF050F1A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}