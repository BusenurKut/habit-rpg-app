// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/ana_sayfa.dart';

void main() {
  runApp(const HabitRPGApp());
}

class HabitRPGApp extends StatelessWidget {
  const HabitRPGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CozyLife RPG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD8BBFF),
        scaffoldBackgroundColor: const Color(0xFFFFF5F5), // Çok soft pembe/krem arka plan
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFD8BBFF),
          secondary: Color(0xFFFFB7B2),
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const KarakterVeGorevlerSayfasi(),
    );
  }
}