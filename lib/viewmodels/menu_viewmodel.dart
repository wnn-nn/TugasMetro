import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/menu_model.dart';

class MenuViewModel extends ChangeNotifier {
  static const String _url = 'https://dummyjson.com/recipes';

  // Client bisa diganti (mis. MockClient) saat testing.
  final http.Client _client;

  MenuViewModel({http.Client? client}) : _client = client ?? http.Client();

  // State daftar menu (dari API)
  List<MenuModel> menus = [];
  bool isLoading = false;
  String? errorMessage;

  // Kompatibilitas dengan versi sebelumnya
  List<MenuModel> get daftarMenu => menus;
  Future<void> muatDaftarMenu() => fetchMenus();

  // State halaman detail
  int jumlahPorsi = 1;
  bool isFavorite = false;

  bool _disposed = false;

  Future<void> fetchMenus() async {
    // TODO 1: mulai loading, hapus error lama
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // TODO 2: ambil data dari API (dengan batas waktu agar tidak loading selamanya)
      final response =
          await _client.get(Uri.parse(_url)).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        // TODO 3: decode JSON -> ambil data['recipes'] -> ubah ke MenuModel
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> recipes = data['recipes'] ?? [];
        menus = recipes
            .map((item) => MenuModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        // TODO 4: status bukan 200
        errorMessage = 'Gagal memuat menu (kode status: ${response.statusCode}).';
      }
    } catch (e) {
      // TODO 5: pesan ramah pengguna (tanpa dump exception)
      errorMessage =
          'Tidak dapat memuat menu. Periksa koneksi internet Anda lalu coba lagi.';
    } finally {
      // TODO 6: selesai loading
      isLoading = false;
      notifyListeners();
    }
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

  // Cegah error "used after being disposed" bila request selesai
  // setelah halaman ditutup.
  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _client.close();
    super.dispose();
  }
}
