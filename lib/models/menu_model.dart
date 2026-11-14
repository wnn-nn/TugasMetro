class MenuModel {
  final String nama;
  final int harga;
  final String deskripsi;

  const MenuModel({
    required this.nama,
    required this.harga,
    required this.deskripsi,
  });

  static List<MenuModel> ambilDataMenu() {
    return const [
      MenuModel(
        nama: 'Kopi Susu Gula Aren',
        harga: 25000,
        deskripsi: 'Espresso robusta dengan susu segar dan gula aren asli.',
      ),
      MenuModel(
        nama: 'Matcha Latte',
        harga: 28000,
        deskripsi: 'Teh hijau Jepang premium yang dikocok dengan susu creamy.',
      ),
      MenuModel(
        nama: 'Croissant Butter',
        harga: 22000,
        deskripsi: 'Pastry renyah berlapis dengan aroma mentega Prancis.',
      ),
      MenuModel(nama: 'Coca Cola', harga: 24000, deskripsi: 'Coca Cola Manis.'),
    ];
  }
}