import 'package:flutter/material.dart';

class AnnotationScreen extends StatefulWidget {
  const AnnotationScreen({super.key});

  @override
  State<AnnotationScreen> createState() => _AnnotationScreenState();
}

class _AnnotationScreenState extends State<AnnotationScreen> {
  String selectedTool = 'Circle';
  String selectedLabel = 'Fracture';
  Color selectedColor = const Color(0xFF00FFFF);

  final List<String> tools = ['Circle', 'Arrow', 'Freehand', 'Rectangle', 'Eraser'];
  final List<String> labels = ['Fracture', 'Joint Disorder', 'Bone Density', 'Abnormal Region', 'Normal'];
  final List<Map<String, dynamic>> annotations = [
    {'label': 'Fracture', 'region': 'Region 1 - High confidence', 'color': Colors.red},
    {'label': 'Joint Disorder', 'region': 'Region 2 - Medium confidence', 'color': Colors.yellow},
  ];

  final List<Color> colors = [
    const Color(0xFF00FFFF),
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
  ];

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
        title: const Text('Annotate Scan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save',
                style: TextStyle(color: Color(0xFF00FFFF), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.image, color: Colors.grey, size: 80),
                  ),
                  Positioned(
                    top: 40,
                    left: 60,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                      child: const Center(
                        child: Text('1',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 60,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.yellow, width: 2),
                      ),
                      child: const Center(
                        child: Text('2',
                            style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tools.map((tool) => GestureDetector(
                  onTap: () => setState(() => selectedTool = tool),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedTool == tool
                          ? const Color(0xFF00FFFF).withOpacity(0.2)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selectedTool == tool
                            ? const Color(0xFF00FFFF)
                            : const Color(0xFF00FFFF).withOpacity(0.2),
                      ),
                    ),
                    child: Text(tool,
                        style: TextStyle(
                          color: selectedTool == tool
                              ? const Color(0xFF00FFFF)
                              : Colors.grey,
                        )),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Color: ',
                    style: TextStyle(color: Colors.white)),
                ...colors.map((color) => GestureDetector(
                  onTap: () => setState(() => selectedColor = color),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: selectedColor == color ? 32 : 24,
                    height: selectedColor == color ? 32 : 24,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: selectedColor == color
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add Diagnostic Label',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: labels.map((label) => GestureDetector(
                      onTap: () => setState(() => selectedLabel = label),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: selectedLabel == label
                              ? const Color(0xFF00FFFF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedLabel == label
                                ? const Color(0xFF00FFFF)
                                : const Color(0xFF00FFFF).withOpacity(0.3),
                          ),
                        ),
                        child: Text(label,
                            style: TextStyle(
                              color: selectedLabel == label
                                  ? const Color(0xFF050F1A)
                                  : Colors.white,
                              fontSize: 13,
                            )),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text('Saved Annotations (2)',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            const SizedBox(height: 8),
            ...annotations.map((ann) => Container(
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
                    backgroundColor: ann['color'],
                    radius: 8,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ann['label'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text(ann['region'],
                            style: const TextStyle(
                                color: Color(0xFF00FFFF), fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey, size: 18),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                    onPressed: () {},
                  ),
                ],
              ),
            )),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Annotation saved successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.save, color: Color(0xFF050F1A)),
                label: const Text('Save & Queue for Retraining',
                    style: TextStyle(
                        color: Color(0xFF050F1A),
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}