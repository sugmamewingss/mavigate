import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mavigate/main.dart';

void main() {
  testWidgets('MaviGate full end-to-end journey including Orientation and Calender sub-journeys', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // 1. Build app
    await tester.pumpWidget(const MaviGateApp());
    expect(find.text('MaviGate'), findsOneWidget);
    expect(find.text('Academic Planner Pilihanmu!'), findsOneWidget);

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
    expect(find.text('Lupa kata sandi?'), findsOneWidget);

    // Test Forgot Password flow
    await tester.tap(find.text('Lupa kata sandi?'));
    await tester.pumpAndSettle();

    expect(find.text('Lupa kata sandi?'), findsOneWidget);
    expect(find.text('Kirim Tautan Atur Ulang'), findsOneWidget);
    expect(find.text('Kembali'), findsOneWidget);

    // Tap "Kembali" to return to LoginScreen
    await tester.tap(find.text('Kembali'));
    await tester.pumpAndSettle();

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
    await tester.enterText(textFields.at(0), 'Raven');
    await tester.enterText(textFields.at(1), 'raven@mavigate.com');
    await tester.enterText(textFields.at(2), 'secret123');
    await tester.enterText(textFields.at(3), 'secret123');

    // Tap "Buat Akun"
    await tester.ensureVisible(find.text('Buat Akun'));
    await tester.tap(find.text('Buat Akun'));
    await tester.pumpAndSettle();

    // 10. Dashboard: Home Screen (Beranda)
    expect(find.text('Selamat pagi, Raven 👋'), findsOneWidget);
    expect(find.text('Ayo jadikan hari ini bermakna.'), findsOneWidget);
    expect(find.text('Achiever Journey'), findsOneWidget);
    expect(find.text('40% selesai'), findsOneWidget);
    expect(find.text('Mulai perjalanan mu!'), findsOneWidget);
    expect(find.text('Langkah Kamu Selanjutnya'), findsOneWidget);
    expect(find.text('Lanjutkan Journey'), findsOneWidget);

    // 11. Navigate to Journey Section
    await tester.tap(find.text('Lanjutkan Journey'), warnIfMissed: false);
    await tester.pumpAndSettle();

    // Verify Journey Screen Dashboard
    expect(find.text('Journey'), findsWidgets);
    expect(find.text('Weekly Reset'), findsOneWidget);
    expect(find.text('HALO MABA Journey'), findsOneWidget);
    expect(find.text('JOURNEY STATUS'), findsOneWidget);
    expect(find.text('0%'), findsWidgets); // 0% initial
    expect(find.text('FOKUS SAAT INI'), findsOneWidget);

    // 12. Tap "Lanjutkan" on Focus Card to open Orientation mission (7 steps)
    await tester.tap(find.widgetWithText(ElevatedButton, 'Lanjutkan'));
    await tester.pumpAndSettle();

    // Sub-Journey: Orientation Mission (Step 1/7 to 7/7)
    for (int i = 0; i < 7; i++) {
      await tester.tap(find.widgetWithText(ElevatedButton, 'Lanjut'));
      await tester.pumpAndSettle();
    }

    // Verify Completion Dialog for Sub-Journey 1.1
    expect(find.text('Sub-Journey 1.1 selesai! 🎉'), findsOneWidget);
    await tester.tap(find.text('Lanjutkan →'));
    await tester.pumpAndSettle();

    // 13. Back on Journey Screen: Orientation completed (40%), Calender is ACTIVE
    expect(find.text('40%'), findsWidgets);
    expect(find.text('COMPLETED'), findsOneWidget);

    // 14. Now open Calender Mission
    await tester.tap(find.widgetWithText(ElevatedButton, 'Lanjutkan'));
    await tester.pumpAndSettle();

    // In CalenderMissionScreen
    expect(find.text('Siapkan Kalender'), findsWidgets);
    expect(find.text('Tambahkan aktivitasmu'), findsOneWidget);
    expect(find.text('Tambahkan ke Kalender'), findsOneWidget);

    // Fill form
    final calenderFields = find.byType(TextField);
    await tester.enterText(calenderFields.at(0), 'Kuliah Kecerdasan Artifisial');
    await tester.enterText(calenderFields.at(1), '27/08/26');
    await tester.enterText(calenderFields.at(2), '13.00 - 14.40');
    await tester.pumpAndSettle();

    // Tap "Tambahkan ke Kalender"
    await tester.tap(find.widgetWithText(ElevatedButton, 'Tambahkan ke Kalender'));
    await tester.pumpAndSettle();

    // Verify added notification card appears
    expect(find.text('Ditambahkan'), findsOneWidget);

    // Tap "Selesai ✓"
    await tester.tap(find.widgetWithText(ElevatedButton, 'Selesai'));
    await tester.pumpAndSettle();

    // Verify Completion Dialog for Sub-Journey 1.2
    expect(find.text('Sub-Journey 1.2 selesai! 🎉'), findsOneWidget);
    expect(find.text('Kalendermu sudah mulai terisi. Sekarang kamu punya gambaran yang lebih jelas tentang waktumu.'), findsOneWidget);

    // Tap "Lanjutkan →"
    await tester.tap(find.text('Lanjutkan →'));
    await tester.pumpAndSettle();

    // 15. Back on Journey Screen: Status is now 80%!
    expect(find.text('80%'), findsWidgets);
    expect(find.text('COMPLETED'), findsNWidgets(2));
  });
}
