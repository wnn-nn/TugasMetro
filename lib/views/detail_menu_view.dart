// File: lib/views/detail_menu_view.dart
import 'package:flutter/material.dart';

import '../models/menu_model.dart';
import '../viewmodels/menu_viewmodel.dart';

class DetailMenuView extends StatefulWidget {
  final MenuModel menu;

  const DetailMenuView({super.key, required this.menu});

  @override
  State<DetailMenuView> createState() => _DetailMenuViewState();
}

class _DetailMenuViewState extends State<DetailMenuView> {
  final MenuViewModel viewModel = MenuViewModel();
  String catatanPesanan = '';
  late FocusNode _catatanFocusNode;
  bool _isFocused = false;

  // Helper untuk format angka rupiah (contoh: 25000 -> 25.000)
  String formatRupiah(int nominal) {
    return nominal.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  @override
  void initState() {
    super.initState();
    viewModel.menus;
    _catatanFocusNode = FocusNode();

    // Listener untuk mendeteksi perubahan fokus pada TextField catatan
    _catatanFocusNode.addListener(() {
      setState(() {
        _isFocused = _catatanFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _catatanFocusNode.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Scaffold(
          // AppBar warna cokelat dengan judul 'Detail Menu' dan aksi tombol favorit
          appBar: AppBar(
            title: const Text(
              'Detail Menu',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.brown,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: viewModel.isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: viewModel.toggleFavorite,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar menu di bagian atas
                Image.network(
                  widget.menu.gambar,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: const Color(0xFFF4ECE4),
                      child: const Center(
                        child: Icon(
                          Icons.local_cafe,
                          size: 80,
                          color: Colors.brown,
                        ),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama Menu dan Harga Satuan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.menu.nama,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Rp ${formatRupiah(widget.menu.harga)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Box Rating, Waktu Penyajian, dan Kalori
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4ECE4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Rating bintang
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.menu.rating}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            // Waktu penyajian
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.access_time_filled,
                                  color: Colors.brown,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.menu.waktu} Menit',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            // Kalori
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.local_fire_department,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.menu.kalori} Kal',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Kontrol Atur Porsi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Atur Porsi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: viewModel.kurangiPorsi,
                              ),
                              Text(
                                '${viewModel.jumlahPorsi}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: viewModel.tambahPorsi,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Deskripsi Menu
                      const Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.menu.deskripsi,
                        style: const TextStyle(
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // TextField Catatan untuk Barista
                      TextField(
                        focusNode: _catatanFocusNode,
                        onChanged: (value) {
                          setState(() {
                            catatanPesanan = value;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.edit_note),
                          labelText: 'Catatan untuk Barista (Opsional)',
                          // Saat fokus, hintText dihilangkan sesuai permintaan
                          hintText: _isFocused
                              ? null
                              : 'Catatan untuk Barista (Opsional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Pratinjau Catatan Pesanan
                      Text(
                        catatanPesanan.isEmpty
                            ? 'Catatan: Tidak ada catatan khusus.'
                            : 'Catatan: "$catatanPesanan"',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tombol Pesan Sekarang
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Pesanan ${widget.menu.nama} (${viewModel.jumlahPorsi}x) berhasil dibuat!',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text(
                            'Pesan Sekarang (Rp ${viewModel.hitungTotalHarga(widget.menu.harga)})',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
