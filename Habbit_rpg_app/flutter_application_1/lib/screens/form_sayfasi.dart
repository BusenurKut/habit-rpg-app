// lib/screens/form_sayfasi.dart
import 'package:flutter/material.dart';
import '../models/gorev_model.dart';

class GorevFormSayfasi extends StatefulWidget {
  final Gorev? eskiGorev;
  const GorevFormSayfasi({super.key, this.eskiGorev});

  @override
  State<GorevFormSayfasi> createState() => _GorevFormSayfasiState();
}

class _GorevFormSayfasiState extends State<GorevFormSayfasi> {
  final _formKey = GlobalKey<FormState>();
  final _baslikController = TextEditingController();
  String _secilenTip = 'Günlük Rutin';
  String _secilenZorluk = 'Kolay';

  @override
  void initState() {
    super.initState();
    if (widget.eskiGorev != null) {
      _baslikController.text = widget.eskiGorev!.baslik;
      _secilenTip = widget.eskiGorev!.tip;
      _secilenZorluk = widget.eskiGorev!.zorluk;
    }
  }

  @override
  void dispose() {
    _baslikController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.eskiGorev != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '🌸 Görevi Düzenle' : '🌸 Yeni Sihirli Rutin', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFB7B2), // Pastel Pembe
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _baslikController,
                style: const TextStyle(color: Color(0xFF6D597A)),
                decoration: InputDecoration(
                  labelText: 'Rutin / Alışkanlık Adı', 
                  labelStyle: const TextStyle(color: Color(0xFF6D597A)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFFB7B2), width: 2), borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFFE5EC)), borderRadius: BorderRadius.circular(16)),
                ),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Lütfen bu alanı boş bırakma tatlım 💕' : null,
              ),
              const SizedBox(height: 20),
              
              DropdownButtonFormField<String>(
                initialValue: _secilenTip,
                style: const TextStyle(color: Color(0xFF6D597A)),
                decoration: InputDecoration(
                  labelText: 'Rutin Tipi', 
                  labelStyle: const TextStyle(color: Color(0xFF6D597A)),
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFFE5EC)), borderRadius: BorderRadius.circular(16)),
                ),
                items: ['Günlük Rutin', 'Alışkanlık'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (val) => setState(() => _secilenTip = val!),
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: _secilenZorluk,
                style: const TextStyle(color: Color(0xFF6D597A)),
                decoration: InputDecoration(
                  labelText: 'Zorluk (Yıldız Ödülü)', 
                  labelStyle: const TextStyle(color: Color(0xFF6D597A)),
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFFE5EC)), borderRadius: BorderRadius.circular(16)),
                ),
                items: ['Kolay', 'Orta', 'Zor'].map((z) => DropdownMenuItem(value: z, child: Text(z))).toList(),
                onChanged: (val) => setState(() => _secilenZorluk = val!),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB7B2), 
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      Gorev(
                        id: isEdit ? widget.eskiGorev!.id : DateTime.now().toString(),
                        baslik: _baslikController.text,
                        tip: _secilenTip,
                        zorluk: _secilenZorluk,
                        tamamlandiMi: isEdit ? widget.eskiGorev!.tamamlandiMi : false,
                      ),
                    );
                  }
                },
                child: Text(isEdit ? 'Değişiklikleri Kaydet ✨' : 'Günlüğüme Ekle ✨', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}