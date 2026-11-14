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

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.menu.nama),
            actions: [
              // UI Event: Tombol favorit ditekan
              IconButton(
                onPressed: viewModel.toggleFavorite,
                icon: Icon(
                  viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: viewModel.isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.menu.nama,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Harga Satuan: Rp ${widget.menu.harga}',
                  style: const TextStyle(fontSize: 16, color: Colors.brown),
                ),
                const SizedBox(height: 12),
                Text(widget.menu.deskripsi),
                const Divider(height: 30),

                // Bagian Counter Porsi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jumlah Pesanan:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        // UI Event: Kurangi porsi
                        IconButton(
                          onPressed: viewModel.kurangiPorsi,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        // Menampilkan state terbaru dari ViewModel
                        Text(
                          '${viewModel.jumlahPorsi}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // UI Event: Tambah porsi
                        IconButton(
                          onPressed: viewModel.tambahPorsi,
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),

                // Tombol Pesan Sekarang + Navigasi Pop
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Pesan Sekarang - Rp ${viewModel.hitungTotalHarga(widget.menu.harga)}',
                    ),
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