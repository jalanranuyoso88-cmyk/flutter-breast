# LOGBOOK PENGEMBANGAN APLIKASI BreastLens
## Sistem Deteksi Dini Kanker Payudara Berbasis AI

**Nama Mahasiswa:** Aurum Hade Selsabila
**NIM:** 221211988
**Program Studi:** Teknik Informatika
**Universitas:** Universitas Mercu Bakti Jaya
**Pembimbing:** Ns. Weny Amelia, M.Kep, Sp, Kep.MB

---

## Daftar Isi
1. [Pengantar](#pengantar)
2. [Logbook Kegiatan](#logbook-kegiatan)
3. [Ringkasan Progress](#ringkasan-progress)
4. [Kendala dan Solusi](#kendala-dan-solusi)
5. [Kesimpulan](#kesimpulan)

---

## Pengantar

Logbook ini berisi dokumentasi kegiatan pengembangan aplikasi BreastLens (Sistem Deteksi Dini Kanker Payudara) yang dikembangkan sebagai bagian dari penelitian dan pengembangan teknologi kesehatan. Aplikasi ini menggunakan teknologi Artificial Intelligence dengan arsitektur Convolutional Neural Network (CNN) untuk mendeteksi kanker payudara melalui analisis gambar mammogram.

**Tujuan Pengembangan:**
- Membuat alat skrining awal kanker payudara yang mudah diakses
- Mengintegrasikan teknologi AI untuk analisis gambar medis
- Memastikan kepatuhan terhadap regulasi kesehatan dan privasi data
- Mengembangkan aplikasi mobile yang user-friendly

---

## Logbook Kegiatan

### Minggu 1-2: Perencanaan dan Setup Project (10%)
**Tanggal:** 15 Oktober 2024 - 28 Oktober 2024

**Kegiatan:**
- Analisis kebutuhan aplikasi berdasarkan literatur kesehatan
- Studi kasus aplikasi deteksi kanker payudara yang sudah ada
- Perancangan arsitektur aplikasi (Flutter + TensorFlow Lite)
- Setup environment development (Flutter SDK, Android Studio, VS Code)
- Inisialisasi repository Git dan struktur project

**Persentase Progress:** 10%
**Kendala:** Setup environment TensorFlow Lite untuk Flutter
**Solusi:** Update Flutter ke versi terbaru dan install dependencies yang kompatibel

---

### Minggu 3-4: Development UI/UX (25%)
**Tanggal:** 29 Oktober 2024 - 11 November 2024

**Kegiatan:**
- Desain interface aplikasi dengan tema kesehatan (pink theme)
- Implementasi halaman utama dengan navigasi bottom navigation
- Pembuatan halaman analisis gambar dengan drag & drop functionality
- Development halaman riwayat analisis dengan local storage
- Implementasi dark/light theme switching
- Testing UI responsiveness pada berbagai ukuran layar

**Persentase Progress:** 25%
**Kendala:** Implementasi image picker dan crop functionality
**Solusi:** Menggunakan package image_picker dan implementasi custom crop interface

---

### Minggu 5-6: Integrasi AI Model (40%)
**Tanggal:** 12 November 2024 - 25 November 2024

**Kegiatan:**
- Training model CNN untuk deteksi kanker payudara (dataset CBIS-DDSM)
- Konversi model TensorFlow ke TensorFlow Lite format
- Integrasi model TFLite ke dalam aplikasi Flutter
- Implementasi preprocessing gambar (resize, normalize)
- Development confidence scoring dan result interpretation
- Testing akurasi model pada berbagai kondisi gambar

**Persentase Progress:** 40%
**Kendala:** Model size terlalu besar untuk mobile deployment
**Solusi:** Model optimization dengan quantization dan pruning

---

### Minggu 7-8: Testing dan Debugging (55%)
**Tanggal:** 26 November 2024 - 9 Desember 2024

**Kegiatan:**
- Unit testing untuk fungsi preprocessing dan AI inference
- Integration testing untuk flow analisis lengkap
- Performance testing pada device Android/iOS
- Memory leak testing dan optimization
- User acceptance testing dengan sample users
- Bug fixing dan error handling improvement

**Persentase Progress:** 55%
**Kendala:** Memory overflow saat processing gambar besar
**Solusi:** Implementasi image compression dan batch processing

---

### Minggu 9-10: App Store Compliance (70%)
**Tanggal:** 10 Desember 2024 - 23 Desember 2024

**Kegiatan:**
- Analisis App Store Review Guidelines untuk aplikasi kesehatan
- Implementasi medical disclaimers dan warning messages
- Development privacy policy section dengan detail data handling
- Penambahan citations dari sumber medis terpercaya (WHO, ACS, Kemenkes)
- Implementasi consent forms untuk data collection
- Testing compliance dengan App Store requirements

**Persentase Progress:** 70%
**Kendala:** Rejection guidelines 1.4.1 (Safety) dan 5.1.1 (Legal)
**Solusi:** Penambahan comprehensive medical disclaimers dan privacy policy

---

### Minggu 11-12: Final Testing dan Deployment (85%)
**Tanggal:** 24 Desember 2024 - 6 Januari 2025

**Kegiatan:**
- End-to-end testing pada multiple devices
- Performance optimization dan battery usage testing
- Security testing untuk data protection
- Build testing untuk Android APK dan iOS IPA
- Documentation lengkap aplikasi dan user manual
- Preparation untuk App Store submission

**Persentase Progress:** 85%
**Kendala:** iOS signing certificate issues
**Solusi:** Setup Apple Developer account dan provisioning profiles

---

### Minggu 13-14: App Store Submission dan Finalization (100%)
**Tanggal:** 7 Januari 2025 - 20 Januari 2025

**Kegiatan:**
- Final build dengan version 4.0.6
- Upload ke App Store Connect
- Fill app store listing dengan description dan screenshots
- Submit untuk review
- Monitoring review process
- Final documentation dan laporan

**Persentase Progress:** 100%
**Status:** ✅ COMPLETED - App Store Ready

---

## Ringkasan Progress

| Periode | Kegiatan Utama | Progress | Status |
|---------|----------------|----------|--------|
| Minggu 1-2 | Planning & Setup | 10% | ✅ |
| Minggu 3-4 | UI/UX Development | 25% | ✅ |
| Minggu 5-6 | AI Integration | 40% | ✅ |
| Minggu 7-8 | Testing & Debugging | 55% | ✅ |
| Minggu 9-10 | App Store Compliance | 70% | ✅ |
| Minggu 11-12 | Final Testing | 85% | ✅ |
| Minggu 13-14 | Deployment | 100% | ✅ |

**Total Progress: 100%**

---

## Kendala dan Solusi

### 1. Technical Challenges
**Kendala:** Model AI terlalu besar untuk deployment mobile
**Solusi:** Model quantization dan optimization menggunakan TensorFlow Lite Converter

### 2. App Store Compliance
**Kendala:** Rejection karena kurangnya medical disclaimers
**Solusi:** Penambahan comprehensive warnings dan citations dari sumber terpercaya

### 3. Performance Issues
**Kendala:** Memory overflow pada processing gambar besar
**Solusi:** Implementasi image compression dan progressive loading

### 4. Cross-Platform Compatibility
**Kendala:** Perbedaan behavior antara Android dan iOS
**Solusi:** Platform-specific code implementation dan extensive testing

---

## Kesimpulan

Pengembangan aplikasi BreastLens telah berhasil diselesaikan dengan pencapaian 100% progress. Aplikasi ini telah memenuhi semua requirements teknis dan regulasi, termasuk:

✅ **Fitur Utama:**
- Deteksi kanker payudara menggunakan AI CNN
- Interface user-friendly dengan tema kesehatan
- Riwayat analisis lokal
- Dark/Light theme support

✅ **Compliance:**
- Medical disclaimers dan warnings
- Privacy policy lengkap
- Citations dari WHO, ACS, Kemenkes RI
- App Store Review Guidelines compliance

✅ **Technical Achievement:**
- Flutter framework untuk cross-platform development
- TensorFlow Lite untuk AI inference
- Local storage untuk data privacy
- Optimized performance untuk mobile devices

Aplikasi BreastLens siap untuk deployment ke App Store dan Google Play Store sebagai solusi inovatif untuk deteksi dini kanker payudara di Indonesia.

---

**Jakarta, 20 Januari 2025**

**Aurum Hade Selsabila**  
**NIM: 221211988**
