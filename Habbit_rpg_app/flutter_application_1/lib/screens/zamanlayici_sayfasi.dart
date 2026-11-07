// lib/screens/zamanlayici_sayfasi.dart
import 'dart:async';
import 'package:flutter/material.dart';

class ZamanlayiciSayfasi extends StatefulWidget {
  const ZamanlayiciSayfasi({super.key});

  @override
  State<ZamanlayiciSayfasi> createState() => _ZamanlayiciSayfasiState();
}

class _ZamanlayiciSayfasiState extends State<ZamanlayiciSayfasi> {
  int _kalanSaniye = 25 * 60; // 25 Dakika standart odaklanma
  Timer? _timer;
  bool _calisiyorMu = false;

  void _zamaniBaslatDurdur() {
    if (_calisiyorMu) {
      _timer?.cancel();
      setState(() => _calisiyorMu = false);
    } else {
      setState(() => _calisiyorMu = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_kalanSaniye > 0) {
            _kalanSaniye--;
          } else {
            _timer?.cancel();
            _calisiyorMu = false;
            _kalanSaniye = 25 * 60;
            // Odaklanma bitince ödül verilebilir
          }
        });
      });
    }
  }

  void _sifirla() {
    _timer?.cancel();
    setState(() {
      _calisiyorMu = false;
      _kalanSaniye = 25 * 60;
    });
  }

  String _sureFormat() {
    int dakika = _kalanSaniye ~/ 60;
    int saniye = _kalanSaniye % 60;
    return '${dakika.toString().padLeft(2, '0')}:${saniye.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⏱️ Sihirli Zamanlayıcı', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFFD8BBFF),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌸 Odaklanma Zamanı 🌸', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF6D597A))),
            const SizedBox(height: 10),
            Text('Rutinlerini yaparken derin bir nefes al ve başla.', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE5EC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFB7B2), width: 4)
              ),
              child: Text(_sureFormat(), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF6D597A))),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB7B2), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                  onPressed: _zamaniBaslatDurdur,
                  child: Text(_calisiyorMu ? 'Durdur ⏸️' : 'Başlat ▶️', style: const TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                  onPressed: _sifirla,
                  child: const Text('Sıfırla 🔄', style: TextStyle(color: Color(0xFF6D597A), fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}