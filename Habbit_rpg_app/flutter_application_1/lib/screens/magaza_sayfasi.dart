// lib/screens/magaza_sayfasi.dart
import 'package:flutter/material.dart';

class MagazaSayfasi extends StatefulWidget {
  final int mevcutYildizTozu;
  final Function(int harcanan, bool iksirMi) satinAlmaTetikle;

  const MagazaSayfasi({
    super.key, 
    required this.mevcutYildizTozu, 
    required this.satinAlmaTetikle
  });

  @override
  State<MagazaSayfasi> createState() => _MagazaSayfasiState();
}

class _MagazaSayfasiState extends State<MagazaSayfasi> {
  late int _kalanYildiz;

  final List<Map<String, dynamic>> _urunler = [
    {'emoji': '🧪', 'ad': 'Sihirli Enerji İksiri', 'fiyat': 15, 'aciklama': '+30 Enerji verir'},
    {'emoji': '🐱', 'ad': 'Bulut Kedisi (Pet)', 'fiyat': 50, 'aciklama': 'Yol arkadaşı'},
    {'emoji': '👑', 'ad': 'Gökkuşağı Tacı', 'fiyat': 100, 'aciklama': 'Sadece en asil perilere'},
  ];

  @override
  void initState() {
    super.initState();
    _kalanYildiz = widget.mevcutYildizTozu;
  }

  void _satinAl(int index) {
    int fiyat = _urunler[index]['fiyat'];
    bool iksirMi = _urunler[index]['ad'] == 'Sihirli Enerji İksiri';

    if (_kalanYildiz >= fiyat) {
      setState(() {
        _kalanYildiz -= fiyat;
      });
      widget.satinAlmaTetikle(fiyat, iksirMi);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_urunler[index]['ad']} başarıyla satın alındı! ✨'),
          backgroundColor: const Color(0xFFB5E2FA),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yetersiz Yıldız Tozu! Biraz daha rutin tamamlamalısın 😿'),
          backgroundColor: Color(0xFFFFB7B2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛍️ Sihirli Mağaza', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFFFFB7B2),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFFFE5EC),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bakiyen: ⭐ $_kalanYildiz Yıldız Tozu', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF6D597A))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _urunler.length,
              itemBuilder: (context, index) {
                final urun = _urunler[index];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xFFFFE5EC))),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Text(urun['emoji'], style: const TextStyle(fontSize: 32)),
                    title: Text(urun['ad'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6D597A))),
                    subtitle: Text('${urun['aciklama']}\nFiyat: ⭐ ${urun['fiyat']}', style: TextStyle(color: Colors.grey[600])),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD8BBFF)),
                      onPressed: () => _satinAl(index),
                      child: const Text('Satın Al', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}