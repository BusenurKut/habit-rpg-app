// lib/models/gorev_model.dart

class Gorev {
  String id;
  String baslik;
  String tip; 
  String zorluk; 
  bool tamamlandiMi;

  Gorev({
    required this.id,
    required this.baslik,
    required this.tip,
    required this.zorluk,
    this.tamamlandiMi = false,
  });
}