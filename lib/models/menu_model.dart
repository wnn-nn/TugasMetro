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
    this.gambar = 'https://picsum.photos/600/400',
  });

  static List<MenuModel> ambilDataMenu() {
    return const [
      MenuModel(
        nama: 'Kopi Susu Gula Aren',
        harga: 25000,
        deskripsi:
            'Perpaduan sempurna antara biji kopi espresso pilihan dari dataran tinggi dengan susu segar full cream dan manis legitnya gula aren organik asli. Cocok menemani waktu santai maupun saat fokus ngoding seharian.',
        rating: 4.9,
        waktu: 10,
        kalori: 150,
        gambar: 'https://picsum.photos/600/400',
      ),
      MenuModel(
        nama: 'Matcha Latte',
        harga: 28000,
        deskripsi:
            'Kombinasi autentik bubuk matcha murni dari Kyoto Jepang dengan kelembutan susu segar pilihan serta sentuhan manis yang pas dan seimbang. Sangat tepat untuk menyegarkan pikiran di tengah padatnya aktivitas harian.',
        rating: 4.8,
        waktu: 10,
        kalori: 180,
        gambar: 'https://picsum.photos/600/401',
      ),
      MenuModel(
        nama: 'Croissant Butter',
        harga: 22000,
        deskripsi:
            'Pastry klasik khas Prancis yang dipanggang renyah berlapis dengan keharuman mentega premium serta tekstur lembut di bagian dalamnya. Sangat nikmat dinikmati selagi hangat untuk menemani secangkir minuman favorit.',
        rating: 4.7,
        waktu: 8,
        kalori: 220,
        gambar: 'https://picsum.photos/600/402',
      ),
      MenuModel(
        nama: 'Caramel Macchiato',
        harga: 30000,
        deskripsi:
            'Sajian espresso pekat berpadu harmonis dengan susu segar berbusa halus, sirup vanilla lembut, serta siraman saus karamel manis legit di atasnya. Menghadirkan kenikmatan aroma kopi karamel yang memanjakan lidah.',
        rating: 4.9,
        waktu: 12,
        kalori: 210,
        gambar: 'https://picsum.photos/600/403',
      ),
    ];
  }
}
