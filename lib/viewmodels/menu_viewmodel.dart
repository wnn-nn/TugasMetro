import 'package:flutter/material.dart';

import '../models/menu_model.dart';

class MenuViewModel extends ChangeNotifier {
  List<MenuModel> daftarMenu = [];
  int jumlahPorsi = 1;
  bool isFavorite = false;

  void muatDaftarMenu() {
    daftarMenu = MenuModel.ambilDataMenu();
    notifyListeners();
  }

  int hitungTotalHarga(int hargaSatuan) {
    return jumlahPorsi * hargaSatuan;
  }

  void tambahPorsi() {
    jumlahPorsi++;
    notifyListeners();
  }

  void kurangiPorsi() {
    if (jumlahPorsi > 1) {
      jumlahPorsi--;
      notifyListeners();
    }
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}