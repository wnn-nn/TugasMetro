import 'package:flutter/material.dart';

import '../models/menu_model.dart';
import '../viewmodels/menu_viewmodel.dart';
import 'detail_menu_view.dart';

class DaftarMenuView extends StatefulWidget {
  final MenuViewModel? viewModel;

  const DaftarMenuView({super.key, this.viewModel});

  @override
  State<DaftarMenuView> createState() => _DaftarMenuViewState();
}

class _DaftarMenuViewState extends State<DaftarMenuView> {
  late final MenuViewModel viewModel;
  late final bool _isExternalViewModel;

  String formatRupiah(int nominal) {
    return nominal.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  @override
  void initState() {
    super.initState();
    _isExternalViewModel = widget.viewModel != null;
    viewModel = widget.viewModel ?? MenuViewModel();
    // Panggil fetchMenus() tanpa await di initState
    viewModel.fetchMenus();
  }

  @override
  void dispose() {
    if (!_isExternalViewModel) {
      viewModel.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Menu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          // Kondisi 1: Loading
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Kondisi 2: Error
          if (viewModel.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      viewModel.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        viewModel.fetchMenus();
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Kondisi 3: Data berhasil dimuat
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.menus.length,
            itemBuilder: (context, index) {
              final MenuModel item = viewModel.menus[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: item.gambar.isNotEmpty
                        ? Image.network(
                            item.gambar,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 56,
                                height: 56,
                                color: const Color(0xFFF4ECE4),
                                child: const Icon(
                                  Icons.local_cafe,
                                  color: Colors.brown,
                                ),
                              );
                            },
                          )
                        : Container(
                            width: 56,
                            height: 56,
                            color: const Color(0xFFF4ECE4),
                            child: const Icon(
                              Icons.local_cafe,
                              color: Colors.brown,
                            ),
                          ),
                  ),
                  title: Text(
                    item.nama,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Rp ${formatRupiah(item.harga)}',
                    style: const TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMenuView(menu: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
