// File: lib/views/daftar_menu_view.dart
import 'package:flutter/material.dart';

import '../models/menu_model.dart';
import '../viewmodels/menu_viewmodel.dart';
import 'detail_menu_view.dart';

class DaftarMenuView extends StatefulWidget {
  const DaftarMenuView({super.key});

  @override
  State<DaftarMenuView> createState() => _DaftarMenuViewState();
}

class _DaftarMenuViewState extends State<DaftarMenuView> {
  // Menghubungkan View dengan ViewModel
  final MenuViewModel viewModel = MenuViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.muatDaftarMenu();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Kafe (MVVM)')),
      // ListenableBuilder mendengarkan perubahan state dari ViewModel
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.daftarMenu.length,
            itemBuilder: (context, index) {
              final MenuModel item = viewModel.daftarMenu[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.local_cafe, color: Colors.brown),
                  title: Text(item.nama),
                  subtitle: Text('Rp ${item.harga}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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