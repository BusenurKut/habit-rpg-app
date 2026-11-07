// lib/screens/ana_sayfa.dart
import 'package:flutter/material.dart';
import '../models/gorev_model.dart';
import 'form_sayfasi.dart';
import 'magaza_sayfasi.dart'; 
import 'zamanlayici_sayfasi.dart';

class KarakterVeGorevlerSayfasi extends StatefulWidget {
  const KarakterVeGorevlerSayfasi({super.key});

  @override
  State<KarakterVeGorevlerSayfasi> createState() => _KarakterVeGorevlerSayfasiState();
}

class _KarakterVeGorevlerSayfasiState extends State<KarakterVeGorevlerSayfasi> {
  int _enerji = 70; 
  int _yildizTozu = 25; 
  int _isikPuani = 40; 
  int _sihirDerecesi = 1; 

  int _toplamTamamlananRutin = 0;

  final List<Gorev> _gorevler = [
    Gorev(id: '1', baslik: 'Cilt Bakımını Yap 🌸', tip: 'Günlük Rutin', zorluk: 'Kolay'),
    Gorev(id: '2', baslik: '2 Litre Su İç 💧', tip: 'Alışkanlık', zorluk: 'Kolay'),
    Gorev(id: '3', baslik: 'Yarım Saat Kitap Oku & Matcha İç ☕', tip: 'Günlük Rutin', zorluk: 'Orta'),
    Gorev(id: '4', baslik: 'Yazılım Geliştr ', tip: 'Günlük Rutin', zorluk: 'Zor'),
    Gorev(id: '5', baslik: 'Hobilerini Geliştir', tip: 'Alışkanlık', zorluk: 'Zor'),
    Gorev(id: '6', baslik: 'Arkadaşlarına Vakit Ayır', tip: 'Günlük Rutin', zorluk: 'Orta'),
    Gorev(id: '7', baslik: 'Yeni Tarifler Deneyin', tip: 'Alışkanlık', zorluk: 'Orta'),
  ];

  void _rutinEtkisi(Gorev gorev, bool pozitif) {
    int carpan = gorev.zorluk == 'Kolay' ? 5 : (gorev.zorluk == 'Orta' ? 10 : 20);
    setState(() {
      if (pozitif) {
        _yildizTozu += carpan;
        _isikPuani += carpan;
        _toplamTamamlananRutin++; 
        if (_isikPuani >= 100) {
          _sihirDerecesi += 1;
          _isikPuani = _isikPuani - 100;
          _enerji = 100; 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('🦄 İnanılmazsın! Sihir Derecen Artı: Seviye $_sihirDerecesi 🌟 ✨'), 
              backgroundColor: const Color(0xFFB5E2FA),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        _enerji -= carpan;
        if (_enerji <= 0) {
          _enerji = 60; 
          _yildizTozu = (_yildizTozu - 8 > 0) ? _yildizTozu - 8 : 0;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('☁️ Enerjin tükendi, biraz dinlendin ve yıldız tozu kaybettin 🛌'), 
              backgroundColor: Color(0xFFFFC6FF),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✨ CozyLife', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFFD8BBFF), 
        centerTitle: false,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MagazaSayfasi(
                    mevcutYildizTozu: _yildizTozu,
                    satinAlmaTetikle: (harcanan, iksirMi) {
                      setState(() {
                        // 🛠️ HATA DÜZELTMESİ: Gelen sayıyı int.parse ile kesin olarak int'e çevirdik
                        int harcananMiktar = int.parse(harcanan.toString());
                        _yildizTozu -= harcananMiktar;
                        if (iksirMi) {
                          _enerji = (_enerji + 30 > 100) ? 100 : _enerji + 30; 
                        }
                      });
                    },
                  ),
                ),
              );
            },
            child: const Text('🛍️ Mağaza', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ZamanlayiciSayfasi()));
            },
            child: const Text('⏱️ Sayaç', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFD8BBFF),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.85), borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('👑 Derece: $_sihirDerecesi Peri', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF6D597A))),
                      Text('⭐ $_yildizTozu Yıldız', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFFFB7B2))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(width: 65, child: Text('ENERJİ 💞', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF6D597A)))),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(value: _enerji / 100, backgroundColor: const Color(0xFFFFE5EC), color: const Color(0xFFFFC6FF), minHeight: 10),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('$_enerji/100', style: const TextStyle(fontSize: 11, color: Color(0xFF6D597A))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(width: 65, child: Text('IŞIK 🌟', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF6D597A)))),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(value: _isikPuani / 100, backgroundColor: const Color(0xFFFFE5EC), color: const Color(0xFFB5E2FA), minHeight: 10),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('$_isikPuani/100', style: const TextStyle(fontSize: 11, color: Color(0xFF6D597A))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFFFE5EC), borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('📊 Toplam Başarılan Sihirli Rutin:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF6D597A))),
                  Text('🌸 $_toplamTamamlananRutin', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6D597A))),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: _gorevler.isEmpty
                ? const Center(child: Text('Bütün sihirli rutinler tamamlandı! 🦄', style: TextStyle(color: Color(0xFF6D597A), fontSize: 16)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: _gorevler.length,
                    itemBuilder: (context, index) {
                      final gorev = _gorevler[index];
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xFFFFE5EC), width: 1.5)),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(
                            gorev.baslik,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              decoration: gorev.tamamlandiMi ? TextDecoration.lineThrough : null,
                              color: gorev.tamamlandiMi ? Colors.grey[400] : const Color(0xFF6D597A),
                            ),
                          ),
                          subtitle: Text('${gorev.tip} • Zorluk: ${gorev.zorluk}', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                          leading: gorev.tip == 'Alışkanlık'
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(30, 30)),
                                      onPressed: () => _rutinEtkisi(gorev, true),
                                      child: const Text('💗', style: TextStyle(fontSize: 20)),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(30, 30)),
                                      onPressed: () => _rutinEtkisi(gorev, false),
                                      child: const Text('💔', style: TextStyle(fontSize: 20)),
                                    ),
                                  ],
                                )
                              : Checkbox(
                                  value: gorev.tamamlandiMi,
                                  activeColor: const Color(0xFFD8BBFF),
                                  side: const BorderSide(color: Color(0xFFFFB7B2), width: 1.5),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      gorev.tamamlandiMi = value!;
                                      _rutinEtkisi(gorev, value);
                                    });
                                  },
                                ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(35, 35)),
                                onPressed: () async {
                                  final guncellenenGorev = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => GorevFormSayfasi(eskiGorev: gorev)),
                                  );
                                  if (guncellenenGorev != null) {
                                    setState(() {
                                      int idx = _gorevler.indexWhere((e) => e.id == gorev.id);
                                      _gorevler[idx] = guncellenenGorev;
                                    });
                                  }
                                },
                                child: const Text('📝', style: TextStyle(fontSize: 18)),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(35, 35)),
                                onPressed: () {
                                  setState(() {
                                    _gorevler.removeAt(index);
                                  });
                                },
                                child: const Text('🗑️', style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFB7B2),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () async {
          final yeniGorev = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GorevFormSayfasi()),
          );
          if (yeniGorev != null) {
            setState(() {
              _gorevler.add(yeniGorev);
            });
          }
        },
        child: const Text('⭐', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}