import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mavigate/main.dart';

void main() {
  testWidgets('MaviGate complete onboarding and MABA completion flow test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build app
    await tester.pumpWidget(const MaviGateApp());
    expect(find.text('MaviGate'), findsOneWidget);

    // Let splash finish
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Page 1: Landing Page with Maskot
    expect(find.text('College is confusing.\nLet\'s navigate it.'), findsOneWidget);
    await tester.tap(find.text('Ayo Mulai'));
    await tester.pumpAndSettle();

    // Page 2: Basics
    expect(find.text('Ayo pahami dulu dasarnya!'), findsOneWidget);
    await tester.tap(find.text('Ayo Siapkan Jadwal'));
    await tester.pumpAndSettle();

    // Page 3: Stepper ("Ayo siapkan kamu kuliah!")
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

    // In Build Your Schedule
    expect(find.text('Build Your Schedule'), findsOneWidget);
    expect(find.text('0 kelas ditambahkan'), findsOneWidget);

    // Add a class "Bla bla bla"
    await tester.enterText(find.byType(TextField), 'Bla bla bla');
    await tester.tap(find.text('Tambah Kelas'));
    // Wait for SnackBar duration to complete
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify class is added
    expect(find.text('Bla bla bla'), findsOneWidget);
    expect(find.text('Senin, 08:00 - 10:00'), findsOneWidget);
    expect(find.text('1 kelas ditambahkan'), findsOneWidget);

    // Tap "Selesai" using Key
    await tester.tap(find.byKey(const Key('build_schedule_finish_button')), warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify Completion Milestone Screen ("🎉 Selamat, tahap MABA selesai!!!")
    expect(find.text('🎉 Selamat, tahap MABA\nselesai!!!'), findsOneWidget);
    expect(find.text('3 / 3 Selesai'), findsOneWidget);
    expect(find.text('Dasar Kampus'), findsOneWidget);
    expect(find.text('Rencana Prioritas'), findsOneWidget);
    expect(find.text('Jadwal Kelas'), findsOneWidget);
    expect(find.text('Ayo Tentukan Targetmu'), findsOneWidget);
  });
}
