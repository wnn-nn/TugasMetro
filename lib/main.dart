import 'package:flutter/material.dart';

import 'viewmodels/menu_viewmodel.dart';
import 'views/daftar_menu_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  // Opsional: ViewModel bisa disuntikkan (dipakai untuk testing).
  final MenuViewModel? viewModel;

  const MainApp({super.key, this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Kafe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),

      home: DaftarMenuView(viewModel: viewModel),
    );
  }
}