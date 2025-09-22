# SADARI - Deteksi Dini Kanker Payudara (Flutter App)

Aplikasi Flutter untuk deteksi dini kanker payudara menggunakan teknologi AI. Aplikasi ini adalah versi mobile dari web application yang sama, memberikan pengalaman yang konsisten di platform iOS dan Android.

## 🚀 Fitur Utama

- **Analisis Gambar AI**: Upload gambar dan dapatkan analisis menggunakan teknologi deep learning
- **Panduan SADARI**: Langkah-langkah lengkap untuk melakukan pemeriksaan payudara sendiri
- **Riwayat Analisis**: Simpan dan lihat riwayat analisis sebelumnya
- **Pengingat Bulanan**: Notifikasi otomatis untuk mengingatkan SADARI setiap bulan
- **Edukasi Kanker**: Informasi lengkap tentang faktor risiko dan gejala kanker payudara
- **Tema Gelap/Terang**: Dukungan mode gelap dan terang
- **Offline Support**: Beberapa fitur tetap berfungsi tanpa koneksi internet

## 📱 Platform Support

- ✅ Android 5.0+ (API level 21+)
- ✅ iOS 11.0+
- ✅ Responsive design untuk berbagai ukuran layar

## 🛠️ Teknologi yang Digunakan

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **HTTP Client**: HTTP & Dio
- **Local Storage**: SharedPreferences
- **Image Picker**: image_picker
- **Notifications**: flutter_local_notifications
- **UI Components**: Material Design 3

## 📋 Prerequisites

Sebelum menjalankan aplikasi, pastikan:

1. **Flutter SDK** terinstall (versi 3.0 atau lebih baru)
2. **Dart SDK** terinstall
3. **Android Studio** atau **Xcode** untuk development
4. **Server Backend** berjalan di `http://192.168.18.9:5000`

## 🚀 Installation & Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd breast_cancer_flutter_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure API Endpoint
Edit file `lib/services/api_service.dart` dan sesuaikan `baseUrl`:
```dart
static const String baseUrl = 'http://YOUR_SERVER_IP:5000/api';
```

### 4. Run Application

#### Android
```bash
flutter run
```

#### iOS
```bash
flutter run -d ios
```

## 📁 Struktur Project

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Data models
│   ├── prediction_result.dart
│   ├── analysis_history.dart
│   ├── sadari_guide.dart
│   └── about_content.dart
├── providers/                # State management
│   ├── app_provider.dart
│   └── notification_provider.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── main_navigation.dart
│   ├── home_screen.dart
│   ├── history_screen.dart
│   ├── sadari_guide_screen.dart
│   ├── about_screen.dart
│   └── error_screen.dart
├── services/                 # API & services
│   ├── api_service.dart
│   └── notification_service.dart
├── widgets/                  # Reusable widgets
│   ├── image_picker_widget.dart
│   ├── result_display_widget.dart
│   ├── loading_widget.dart
│   ├── history_item_widget.dart
│   ├── sadari_step_widget.dart
│   ├── risk_factor_widget.dart
│   └── symptom_widget.dart
└── theme/
    └── app_theme.dart        # App theme configuration
```

## 🔧 Configuration

### API Configuration
Server backend harus berjalan dan dapat diakses dari device/emulator. Pastikan:

1. Server Flask berjalan di `http://192.168.18.9:5000`
2. CORS diaktifkan untuk domain Flutter
3. Endpoint API tersedia:
   - `GET /api/health` - Health check
   - `POST /api/predict` - Image prediction
   - `GET /api/history` - Get analysis history
   - `DELETE /api/history/{id}` - Delete history item
   - `GET /api/sadari/guide` - Get SADARI guide
   - `GET /api/about` - Get about content

### Notification Configuration
Untuk notifikasi berfungsi dengan baik:

#### Android
- Pastikan `POST_NOTIFICATIONS` permission granted
- Notification channel sudah dikonfigurasi

#### iOS
- Pastikan notification permission sudah di-grant
- Info.plist sudah dikonfigurasi dengan benar

## 🎨 UI/UX Features

- **Material Design 3**: Menggunakan design system terbaru
- **Responsive Layout**: Optimal di berbagai ukuran layar
- **Dark/Light Theme**: Dukungan tema gelap dan terang
- **Smooth Animations**: Transisi yang halus antar screen
- **Accessibility**: Dukungan accessibility untuk user yang membutuhkan

## 📊 Performance

- **Image Optimization**: Kompresi otomatis gambar sebelum upload
- **Lazy Loading**: Loading data secara bertahap
- **Caching**: Cache untuk data yang sering diakses
- **Memory Management**: Optimasi penggunaan memory

## 🔒 Security

- **HTTPS Support**: Dukungan koneksi aman
- **Data Validation**: Validasi input user
- **Secure Storage**: Penyimpanan data yang aman
- **Permission Handling**: Manajemen permission yang proper

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📦 Build for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

### Common Issues

1. **Connection Error**
   - Pastikan server backend berjalan
   - Check network connectivity
   - Verify API endpoint configuration

2. **Image Upload Failed**
   - Check camera/photo permissions
   - Verify image format support
   - Check network stability

3. **Notifications Not Working**
   - Grant notification permissions
   - Check device notification settings
   - Verify notification service configuration

## 📝 Changelog

### Version 1.0.0
- Initial release
- Basic image analysis functionality
- SADARI guide implementation
- History tracking
- Monthly reminder notifications
- Dark/light theme support

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

Untuk pertanyaan atau dukungan, silakan hubungi:
- Email: info@breastcancerdetection.com
- Website: www.breastcancerdetection.com

## ⚠️ Disclaimer

Aplikasi ini hanya untuk tujuan edukasi dan screening awal. Hasil analisis tidak menggantikan konsultasi medis profesional. Selalu konsultasikan dengan dokter untuk diagnosis yang akurat.










