<div align="center">

  <img src="docs/images/app-logo.png" alt="MaviGate logo" width="180" />

  <p align="center">
    <img src="docs/images/app-mockup.png" alt="MaviGate mockup" width="400" />
  </p>

  # MaviGate

  **Academic Planner Pilihanmu: Panduan dan perencana akademik terstruktur serta tergamifikasi untuk mahasiswa baru dalam menavigasi kehidupan perkuliahan.**

  <br />

  ![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Language](https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![Type](https://img.shields.io/badge/Type-Cross--Platform-4A90E2?style=for-the-badge)
  ![Platform](https://img.shields.io/badge/Platform-Web%20%7C%20Android%20%7C%20iOS-4361EE?style=for-the-badge)

</div>

---

## Table of contents

- [Project overview](#project-overview)
- [Key features](#key-features)
- [Technology stack](#technology-stack)
- [Project structure](#project-structure)
- [Getting Started](#getting-started)
- [Team](#team)

---

## Project overview

| Item | Details |
| --- | --- |
| Application Type | Cross-platform (Mobile & Web) |
| Primary Platform | Web, Android, iOS |

**MaviGate** adalah aplikasi *academic planner* dan pendamping orientasi tergamifikasi yang dirancang khusus untuk mahasiswa baru (MABA). Memasuki dunia perkuliahan sering kali membingungkan karena banyaknya istilah baru (KRS, SKS, SIAM, Gapura, Brone), jadwal yang padat, serta tuntutan manajemen waktu mandiri. MaviGate menyelesaikan masalah ini dengan menghadirkan alur misi bertahap (*sequential journey*), perencana jadwal kelas interaktif, kalender aktivitas harian, serta pelacak target studi yang intuitif dan menyenangkan.

---

## Key features

| Feature | What the user can do |
| --- | --- |
| **Interactive Onboarding & Stepper** | Memahami dasar perkuliahan melalui 3 tahapan orientasi berurutan dengan validasi status terkunci (*locked/unlocked*). |
| **Schedule Builder (Build Your Schedule)** | Merancang dan menambahkan jadwal mata kuliah semester awal secara dinamis dengan deteksi bentrok hari dan jam. |
| **Target & Experience Selection** | Memilih gaya pengalaman perkuliahan (*Intensive* atau *Balanced*) yang disesuaikan dengan preferensi belajar. |
| **Sequential Journey System (0% - 100%)** | Menyelesaikan rangkaian misi bertahap (Orientation ➔ Calender ➔ Goals) dengan persentase progres dinamis dan *congratulatory milestone*. |
| **Campus Knowledge Guide (7-Step Orientation)** | Mengenal ekosistem kampus (Jadwal, KRS, SKS, SIAM, Gapura, Brone, dan Halo FILKOM) melalui antarmuka *segmented progress*. |
| **Academic Calendar & Schedule Timeline** | Melihat visualisasi kalender bulanan, memantau agenda harian per kategori (Kelas, Aktivitas, Personal), serta menambahkan jadwal baru melalui modal interaktif. |
| **Personalized User Profile & Goals Tracker** | Melihat status *Current Journey (Achiever)*, riwayat kelulusan misi, target pribadi, serta pengaturan akun. |
| **Local Credential Storage & Authentication** | Sistem registrasi dan autentikasi aman dengan validasi lokal, proteksi login salah, dan pembaruan nama pengguna secara dinamis di seluruh layar. |

---

## Technology stack

| Category | Technology | Purpose |
| --- | --- | --- |
| **Frontend Framework** | Flutter (Dart 3.x) | Membangun UI cross-platform modern yang responsif dan berkinerja tinggi. |
| **Architecture** | Clean Modular Component Architecture | Pemisahan kode yang rapi antara `core`, `models`, `screens`, `services`, dan `widgets`. |
| **State Management** | Reactive Stateful Architecture & Notifiers | Mengelola status misi, formulir jadwal, serta navigasi bottom taskbar secara instan. |
| **Local Database & Auth** | `AuthDatabaseService` (Singleton In-Memory / Local Service) | Menyimpan kredensial user, mengelola sesi aktif, dan memvalidasi otentikasi login. |
| **Typography & Assets** | Google Fonts (Plus Jakarta Sans) & Custom Vector Assets | Tipografi modern yang nyaman dibaca serta ilustrasi maskot burung hantu (`Pose 14`, `Pose 15`, `Pose 16`, `Maskot.png`). |
| **Design System & Styling** | Custom Dark Palette (`AppColors`) | Tema gelap modern dengan aksen *Electric Blue* (`#4361EE`), *Emerald Green* (`#10B981`), dan *Coral* (`#F87171`). |
| **Testing** | Flutter Test / Widget Testing | Pengujian otomatis end-to-end seluruh alur registrasi, 4 tab navigasi, dan misi 100% kelulusan. |

---

## Project structure

```text
├── lib/
│   ├── core/
│   │   └── theme/               # Color palette tokens, typography, and theme data
│   ├── models/
│   │   ├── calendar_model.dart  # Data model for calendar timeline events & categories
│   │   └── journey_model.dart   # Data model for sub-journeys, status, and 7-step missions
│   ├── screens/
│   │   ├── auth/                # Login, Register, and Forgot Password screens
│   │   ├── calendar/            # Interactive monthly calendar and daily timeline
│   │   ├── home/                # Main home dashboard with 4-tab IndexedStack
│   │   ├── journey/             # Journey dashboard, Orientation 7-step, Calendar & Goals missions
│   │   ├── onboarding/          # Landing, Basics, Stepper, Schedule Builder & Target Selection
│   │   ├── profile/             # User identity, Achiever journey, history, and goals
│   │   └── splash/              # Animated dark splash screen with mascot
│   ├── services/
│   │   └── auth_database_service.dart # Local credentials store and session manager
│   ├── widgets/
│   │   ├── cards/               # Achiever card, journey hero card, focus card, sub-journey cards
│   │   ├── common/              # MaviGate logo and shared UI widgets
│   │   ├── dialogs/             # Mission completion modal (Pose 16) and Add Schedule modal
│   │   └── navigation/          # Custom persistent bottom taskbar
│   └── main.dart                # Application entry point and theme configuration
├── assets/
│   └── images/                  # Mascot poses (13-16, Maskot.png) and logo.png
├── docs/
│   └── images/                  # Documentation mockup and logo assets
├── test/
│   └── widget_test.dart         # Comprehensive end-to-end unit and integration test suite
└── pubspec.yaml                 # Dependencies and asset configuration
```

---

## Getting Started

Untuk menjalankan project **MaviGate** di lingkungan lokal kamu, ikuti langkah-langkah berikut:

### Prerequisites

*   **Flutter SDK**: Versi 3.x ke atas sudah terpasang.
*   **Dart SDK**: Versi 3.x ke atas.
*   **IDE**: Visual Studio Code atau Android Studio dengan plugin Flutter & Dart.
*   **Browser / Emulator**: Google Chrome (untuk Web), Android Emulator, atau Perangkat Fisik.

### Installation

1.  **Clone repositori**
    ```sh
    git clone https://github.com/sugmamewingss/mavigate.git
    ```
2.  **Masuk ke direktori project**
    ```sh
    cd mavigate
    ```
3.  **Pasang semua dependensi**
    ```sh
    flutter pub get
    ```
4.  **Jalankan aplikasi (Mode Web / Chrome)**
    ```sh
    flutter run -d chrome
    ```
    *Atau jalankan pada perangkat Android/iOS yang terhubung:*
    ```sh
    flutter run
    ```
5.  **Jalankan Test Otomatis**
    ```sh
    flutter test
    ```

---

## Team

| Name | Role | Responsibilities | Contact |
| --- | --- | --- | --- |
| **Rezha Anugrah Putra** | Product Manager | Product planning, feature roadmap, sprint management, and user requirement analysis. | [LinkedIn](https://www.linkedin.com/in/rezha-anugrah-putra/) |
| **Raven** | UI/UX Designer | User research, UI wireframing, high-fidelity Figma design mockups, and visual design system. | [LinkedIn](https://www.linkedin.com/) *(menyusul)* |
| **Alfi Perdiansyah Putra** | Mobile Engineer | Full-stack Flutter architecture, state management, widget development, database integration, and automated testing. | [GitHub](https://github.com/sugmamewingss) |
