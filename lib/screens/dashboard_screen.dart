import 'package:flutter/material.dart';
import 'upload_scan_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF071E2E),
        title: const Text('AI OrthoScan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF00FFFF)),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Color(0xFF00FFFF),
              child: Text('R', style: TextStyle(color: Color(0xFF050F1A))),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFF00FFFF).withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Morning, Dr. Rafia 👋',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('3 scans awaiting your review',
                            style: TextStyle(
                                color: Color(0xFF00FFFF), fontSize: 13)),
                      ],
                    ),
                  ),
                  const Icon(Icons.medical_services,
                      color: Color(0xFF00FFFF), size: 40),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _statCard('12', 'Today\'s Scans', Icons.document_scanner,
                    const Color(0xFF00FFFF)),
                const SizedBox(width: 8),
                _statCard('3', 'Pending', Icons.pending,
                    const Color(0xFFFF8C00)),
                const SizedBox(width: 8),
                _statCard('98%', 'Accuracy', Icons.check_circle,
                    const Color(0xFF00FF88)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Scans',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All',
                      style: TextStyle(color: Color(0xFF00FFFF))),
                ),
              ],
            ),
            _scanItem('Ahmed Khan', 'X-Ray • Knee', '2 mins ago', 'Analyzed',
                Colors.green, 'AK', Colors.blue),
            _scanItem('Sara Raza', 'MRI • Shoulder', '15 mins ago', 'Pending',
                Colors.orange, 'SR', Colors.purple),
            _scanItem('M. Hassan', 'X-Ray • Spine', '1 hr ago', 'Review',
                Colors.red, 'MH', Colors.red),
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
                    MaterialPageRoute(
                        builder: (_) => const UploadScanScreen()),
                  );
                },
                icon: const Icon(Icons.upload, color: Color(0xFF050F1A)),
                label: const Text('Upload New Scan',
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

  Widget _statCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(label,
                style: TextStyle(color: color, fontSize: 11),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _scanItem(String name, String type, String time, String status,
      Color statusColor, String initials, Color avatarColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFF00FFFF).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: avatarColor,
            child: Text(initials,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(type,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time,
                  style:
                      const TextStyle(color: Colors.grey, fontSize: 11)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status,
                    style: TextStyle(color: statusColor, fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}