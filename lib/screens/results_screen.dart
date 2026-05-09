import 'package:flutter/material.dart';
import 'annotation_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

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
        title: const Text('AI Analysis Results',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Color(0xFF00FFFF)),
            onPressed: () {},
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
                border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.25)),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ahmed Khan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text('X-Ray • Knee Joint • Today 2:30 PM',
                            style: TextStyle(color: Color(0xFF00FFFF), fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Analysis Complete ✓',
                        style: TextStyle(color: Colors.green, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: Colors.grey, size: 48),
                        SizedBox(height: 8),
                        Text('Original Scan',
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.blur_on, color: Colors.orange, size: 48),
                        SizedBox(height: 8),
                        Text('AI Heatmap',
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('AI Findings',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FFFF).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('3 detected',
                      style: TextStyle(color: Color(0xFF00FFFF), fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _findingCard('Fracture Detected', 'Lateral tibial plateau region',
                94, Colors.red),
            _findingCard('Joint Space Narrowing', 'Medial compartment',
                78, Colors.orange),
            _findingCard('Minor Bone Density Change', 'Distal femur region',
                61, Colors.yellow),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                    left: BorderSide(color: Color(0xFF00FFFF), width: 4)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🤖 AI Recommendation',
                      style: TextStyle(
                          color: Color(0xFF00FFFF),
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                      'High probability fracture detected. Recommend immediate orthopedic consultation and CT scan confirmation.',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF00FFFF)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AnnotationScreen()),
                      );
                    },
                    icon: const Icon(Icons.edit, color: Color(0xFF00FFFF)),
                    label: const Text('Annotate',
                        style: TextStyle(color: Color(0xFF00FFFF))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FFFF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.picture_as_pdf,
                        color: Color(0xFF050F1A)),
                    label: const Text('Generate Report',
                        style: TextStyle(
                            color: Color(0xFF050F1A),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _findingCard(String title, String subtitle, int confidence, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Text(subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Confidence: $confidence%',
                  style: TextStyle(color: color, fontSize: 12)),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: confidence / 100,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}