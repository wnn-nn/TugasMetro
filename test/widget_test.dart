import 'package:flutter_test/flutter_test.dart';
import 'package:menu_kafe/main.dart';

void main() {
  testWidgets('Menampilkan daftar menu dan katalog kafe', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    // Memeriksa judul AppBar katalog
    expect(find.text('Katalog Menu'), findsOneWidget);

    // Memeriksa item menu tampil
    expect(find.text('Kopi Susu Gula Aren'), findsOneWidget);
    expect(find.text('Caramel Macchiato'), findsOneWidget);
  });
}
