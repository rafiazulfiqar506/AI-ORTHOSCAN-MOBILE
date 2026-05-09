import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI OrthoScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FFFF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF050F1A),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}