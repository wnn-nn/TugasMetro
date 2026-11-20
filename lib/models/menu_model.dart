class MenuModel {
  final String nama;
  final int harga;
  final String deskripsi;
  final double rating;
  final int waktu;
  final int kalori;
  final String gambar;

  const MenuModel({
    required this.nama,
    required this.harga,
    required this.deskripsi,
    this.rating = 0.0,
    this.waktu = 0,
    this.kalori = 0,
    this.gambar = '',
  });

  /// Membuat objek [MenuModel] dari satu item JSON di key `recipes`
  /// (https://dummyjson.com/recipes). Semua field diberi nilai default
  /// dengan `??` agar aplikasi tidak error saat ada data null.
  factory MenuModel.fromJson(Map<String, dynamic> json) {
    // Harga tiruan: caloriesPerServing x 100 (default 250 x 100).
    final num caloriesPerServing = json['caloriesPerServing'] ?? 250;

    // Deskripsi: list bahan digabung menjadi satu teks.
    final List<dynamic> bahan = json['ingredients'] ?? [];

    // Waktu total = waktu persiapan + waktu memasak.
    final num prep = json['prepTimeMinutes'] ?? 0;
    final num cook = json['cookTimeMinutes'] ?? 0;

    return MenuModel(
      nama: json['name'] ?? 'Tanpa Nama',
      gambar: json['image'] ?? '',
      harga: (caloriesPerServing * 100).toInt(),
      deskripsi: bahan.isEmpty ? 'Menu spesial' : bahan.join(', '),
      rating: ((json['rating'] ?? 0) as num).toDouble(),
      waktu: (prep + cook).toInt(),
      kalori: caloriesPerServing.toInt(),
    );
  }
}

/// Alias sesuai penamaan di modul tugas (MenuKafe)
typedef MenuKafe = MenuModel;
