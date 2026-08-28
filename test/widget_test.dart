import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mavigate/main.dart';

void main() {
  testWidgets('MaviGate full end-to-end journey from splash to home screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // 1. Build app
    await tester.pumpWidget(const MaviGateApp());
    expect(find.text('MaviGate'), findsOneWidget);

    // Let splash finish
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // 2. Page 1: Landing Page with Maskot
    expect(find.text('College is confusing.\nLet\'s navigate it.'), findsOneWidget);
    await tester.tap(find.text('Ayo Mulai'));
    await tester.pumpAndSettle();

    // 3. Page 2: Basics
    expect(find.text('Ayo pahami dulu dasarnya!'), findsOneWidget);
    await tester.tap(find.text('Ayo Siapkan Jadwal'));
    await tester.pumpAndSettle();

    // 4. Page 3: Stepper ("Ayo siapkan kamu kuliah!")
    expect(find.text('Ayo siapkan kamu kuliah!'), findsOneWidget);
    expect(find.text('Kamu resmi MABA!'), findsOneWidget);
    expect(find.text('Atur Prioritasmu!'), findsOneWidget);
    expect(find.text('Atur Prioritas'), findsOneWidget);
    expect(find.text('Terkunci'), findsOneWidget);

    // Tap "Atur Prioritas" on Step 02 to unlock Step 03
    await tester.tap(find.text('Atur Prioritas'));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify Step 02 is completed and Step 03 is now unlocked with "Buat Jadwal" button
    expect(find.text('Buat Jadwal'), findsOneWidget);

    // Tap "Buat Jadwal" to enter Build Your Schedule screen
    await tester.ensureVisible(find.text('Buat Jadwal'));
    await tester.tap(find.text('Buat Jadwal'));
    await tester.pumpAndSettle();

    // 5. In Build Your Schedule
    expect(find.text('Build Your Schedule'), findsOneWidget);
    expect(find.text('0 kelas ditambahkan'), findsOneWidget);

    // Add a class "Algoritma Pemrograman"
    await tester.enterText(find.byType(TextField), 'Algoritma Pemrograman');
    await tester.tap(find.text('Tambah Kelas'));
    // Wait for SnackBar duration to complete
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify class is added
    expect(find.text('Algoritma Pemrograman'), findsOneWidget);
    expect(find.text('Senin, 08:00 - 10:00'), findsOneWidget);
    expect(find.text('1 kelas ditambahkan'), findsOneWidget);

    // Tap Back button from BuildScheduleScreen to return with schedule
    await tester.tap(find.byKey(const Key('build_schedule_back_button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // 6. Page 4: Completion Milestone Screen ("🎉 Selamat, tahap MABA selesai!!!")
    expect(find.text('🎉 Selamat, tahap MABA\nselesai!!!'), findsOneWidget);
    expect(find.text('3 / 3 Selesai'), findsOneWidget);
    expect(find.text('Dasar Kampus'), findsOneWidget);
    expect(find.text('Rencana Prioritas'), findsOneWidget);
    expect(find.text('Jadwal Kelas'), findsOneWidget);

    // Tap "Ayo Tentukan Targetmu" to go to Target Selection Screen
    await tester.tap(find.text('Ayo Tentukan Targetmu'));
    await tester.pumpAndSettle();

    // 7. Page 5: Target Selection Screen
    expect(find.text('Seperti apa pengalaman kuliah yang kamu inginkan?'), findsOneWidget);
    expect(find.text('Intensive'), findsOneWidget);
    expect(find.text('Balanced'), findsOneWidget);

    // Select "Intensive"
    await tester.tap(find.text('Intensive'));
    await tester.pumpAndSettle();

    // Tap "Ayo Tentukan Targetmu" to go to Auth (Login Screen)
    await tester.tap(find.text('Ayo Tentukan Targetmu'));
    await tester.pumpAndSettle();

    // 8. Auth: Login Screen
    expect(find.text('Selamat datang kembali 👋'), findsOneWidget);
    expect(find.text('Siap untuk bernavigasi?'), findsOneWidget);
    expect(find.text('Buat akun'), findsOneWidget);

    // Tap "Buat akun" to open Register Screen
    await tester.tap(find.text('Buat akun'));
    await tester.pumpAndSettle();

    // 9. Auth: Register Screen
    expect(find.text('Mari kita mulai.'), findsOneWidget);
    expect(find.text('Nama'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);
    expect(find.text('Konfirmasi Kata Sandi'), findsOneWidget);

    // Fill registration form
    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), 'Mavigator MABA');
    await tester.enterText(textFields.at(1), 'maba@mavigate.com');
    await tester.enterText(textFields.at(2), 'secret123');
    await tester.enterText(textFields.at(3), 'secret123');

    // Tap "Buat Akun"
    await tester.ensureVisible(find.text('Buat Akun'));
    await tester.tap(find.text('Buat Akun'));
    await tester.pumpAndSettle();

    // 10. Dashboard: Home Screen (Beranda)
    expect(find.text('Halo, Mavigator MABA! 👋'), findsOneWidget);
    expect(find.text('maba@mavigate.com'), findsOneWidget);
    expect(find.text('Rencana Akademik Kamu'), findsOneWidget);
  });
}
