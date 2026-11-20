import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:menu_kafe/main.dart';
import 'package:menu_kafe/models/menu_model.dart';
import 'package:menu_kafe/viewmodels/menu_viewmodel.dart';

http.Response _okResponse() {
  return http.Response(
    jsonEncode({
      'recipes': [
        {'name': 'Nasi Goreng', 'caloriesPerServing': 200, 'ingredients': ['Nasi', 'Telur']},
        {'name': 'Soto Ayam', 'caloriesPerServing': 150},
      ],
    }),
    200,
  );
}

void main() {
  test('MenuModel.fromJson memakai nilai default saat data null', () {
    final menu = MenuModel.fromJson({});
    expect(menu.nama, 'Tanpa Nama');
    expect(menu.gambar, '');
    expect(menu.harga, 25000); // 250 x 100
    expect(menu.deskripsi, 'Menu spesial');
  });

  test('MenuModel.fromJson memetakan field dari API', () {
    final menu = MenuModel.fromJson({
      'name': 'Pizza',
      'image': 'http://x/y.jpg',
      'caloriesPerServing': 300,
      'ingredients': ['Keju', 'Tomat'],
    });
    expect(menu.nama, 'Pizza');
    expect(menu.harga, 30000);
    expect(menu.deskripsi, 'Keju, Tomat');
  });

  testWidgets('Menampilkan loading, lalu daftar menu dari API', (tester) async {
    final client = MockClient((request) async => _okResponse());

    await tester.pumpWidget(MainApp(viewModel: MenuViewModel(client: client)));
    expect(find.text('Katalog Menu'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Nasi Goreng'), findsOneWidget);
    expect(find.text('Soto Ayam'), findsOneWidget);

    // Klik item -> Halaman Detail
    await tester.tap(find.text('Nasi Goreng'));
    await tester.pumpAndSettle();
    expect(find.text('Detail Menu'), findsOneWidget);
    expect(find.text('Nasi, Telur'), findsOneWidget);
  });

  testWidgets('Menampilkan error + Coba Lagi, lalu berhasil setelah retry',
      (tester) async {
    var gagal = true;
    final client = MockClient((request) async {
      return gagal ? http.Response('error', 500) : _okResponse();
    });

    await tester.pumpWidget(MainApp(viewModel: MenuViewModel(client: client)));
    await tester.pumpAndSettle();

    expect(find.textContaining('500'), findsOneWidget);
    expect(find.text('Coba Lagi'), findsOneWidget);

    gagal = false;
    await tester.tap(find.text('Coba Lagi'));
    await tester.pumpAndSettle();

    expect(find.text('Coba Lagi'), findsNothing);
    expect(find.text('Nasi Goreng'), findsOneWidget);
  });
}