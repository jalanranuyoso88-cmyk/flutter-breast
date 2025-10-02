import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import 'breast_cancer_education_screen.dart';

class BreastLensGuideScreen extends StatefulWidget {
  const BreastLensGuideScreen({super.key});

  @override
  State<BreastLensGuideScreen> createState() => _BreastLensGuideScreenState();
}

class _BreastLensGuideScreenState extends State<BreastLensGuideScreen> {
  Map<String, dynamic>? _breastlensGuide;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isReminderEnabled = false;
  DateTime? _nextReminderDate;

  @override
  void initState() {
    super.initState();
    _loadBreastLensGuide();
    _loadReminderStatus();
  }

  Future<void> _loadReminderStatus() async {
    final isEnabled = await NotificationService.isReminderEnabled();
    final nextDate = await NotificationService.getNextReminderDate();
    
    if (mounted) {
      setState(() {
        _isReminderEnabled = isEnabled;
        _nextReminderDate = nextDate;
      });
    }
  }

  Future<void> _loadBreastLensGuide() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final guide = await ApiService.getBreastLensGuide();
      if (mounted) {
        setState(() {
          _breastlensGuide = guide?.toJson() ?? _getFallbackGuideData();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        // Jika API gagal, gunakan data fallback
        setState(() {
          _breastlensGuide = _getFallbackGuideData();
          _isLoading = false;
        });
      }
    }
  }

  Map<String, dynamic> _getFallbackGuideData() {
    return {
      'title': 'Panduan BreastLens',
      'description': 'BreastLens adalah metode sederhana yang bisa Anda lakukan sendiri setiap bulan. Lakukan seminggu setelah menstruasi selesai.',
      'steps': [
        {
          'number': 1,
          'title': 'Lihat',
          'description': 'Berdiri di depan cermin, perhatikan perubahan bentuk, ukuran, atau kulit payudara.'
        },
        {
          'number': 2,
          'title': 'Angkat Tangan',
          'description': 'Angkat kedua tangan di atas kepala dan perhatikan apakah ada kerutan atau tarikan.'
        },
        {
          'number': 3,
          'title': 'Raba',
          'description': 'Gunakan tiga jari, raba seluruh area payudara dan ketiak. Rasakan jika ada benjolan atau penebalan yang tidak biasa.'
        }
      ],
      'cancer_education': {
        'title': 'Edukasi Kanker Payudara',
        'description': 'Penting untuk memahami faktor risiko dan gejala kanker payudara untuk deteksi dini yang lebih baik.',
        'risk_factors': [
          {
            'name': 'Usia',
            'description': 'Risiko meningkat seiring bertambahnya usia, terutama setelah 50 tahun'
          },
          {
            'name': 'Riwayat Keluarga',
            'description': 'Memiliki keluarga dengan riwayat kanker payudara atau ovarium'
          },
          {
            'name': 'Genetik',
            'description': 'Mutasi gen BRCA1 atau BRCA2'
          },
          {
            'name': 'Hormon',
            'description': 'Terapi hormon jangka panjang atau menstruasi dini'
          }
        ],
        'symptoms': [
          {
            'name': 'Benjolan',
            'description': 'Benjolan keras yang tidak hilang setelah menstruasi'
          },
          {
            'name': 'Perubahan Ukuran',
            'description': 'Perubahan ukuran atau bentuk payudara'
          },
          {
            'name': 'Kulit Berubah',
            'description': 'Kulit payudara berkerut, kemerahan, atau bersisik'
          },
          {
            'name': 'Nyeri',
            'description': 'Nyeri payudara yang tidak biasa atau persisten'
          }
        ]
      }
    };
  }

  Future<void> _setMonthlyReminder() async {
    try {
      final success = await NotificationService.setMonthlyReminder();
      
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengingat BreastLens bulanan berhasil diaktifkan!'),
            backgroundColor: Colors.green,
          ),
          );
          await _loadReminderStatus();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal mengaktifkan pengingat. Periksa izin notifikasi.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _cancelReminder() async {
    try {
      await NotificationService.cancelMonthlyReminder();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengingat BreastLens bulanan dibatalkan.'),
          backgroundColor: Colors.orange,
        ),
        );
        await _loadReminderStatus();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Panduan BreastLens',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE91E63),
                Color(0xFFAD1457),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadBreastLensGuide,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat panduan...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadBreastLensGuide,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_breastlensGuide == null) {
      return const Center(
        child: Text('Tidak dapat memuat panduan'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header Section
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    Theme.of(context).primaryColor.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icon.png',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Panduan BreastLens',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Panduan lengkap BreastLens',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Steps Section
          if (_breastlensGuide!['steps'] != null) ...[
            Text(
              'Langkah-Langkah BreastLens',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...(_breastlensGuide!['steps'] as List).map((step) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    step['number'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(step['title']),
                subtitle: Text(step['description']),
              ),
            )),
          ],
          
          const SizedBox(height: 32),
          
          // Monthly Reminder Section
          _buildMonthlyReminderSection(),
          
          const SizedBox(height: 32),
          
          // Breast Cancer Education Section
          _buildBreastCancerEducationSection(),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildMonthlyReminderSection() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Bell Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active,
              color: Colors.blue,
              size: 30,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Title
          Text(
            'Pengingat Bulanan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 12),
          
          // Message
          Text(
            'Jangan lupa untuk melakukan BreastLens setiap\nbulan!',
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.black,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Reminder Status
          if (_isReminderEnabled && _nextReminderDate != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pengingat Aktif',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pengingat berikutnya: ${_formatDate(_nextReminderDate!)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _cancelReminder,
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Batalkan Pengingat'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ] else ...[
            // Set Reminder Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue,
                    Color(0xFFE91E63),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _setMonthlyReminder,
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.event_note,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                label: const Text(
                  'Setel Pengingat BreastLens Bulanan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Widget _buildBreastCancerEducationSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE91E63),
            Color(0xFFAD1457),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE91E63).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pelajari tentang kanker',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Tingkatkan pengetahuan Anda tentang kanker payudara untuk pencegahan dan deteksi dini yang lebih baik',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BreastCancerEducationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFE91E63),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Edukasi Kanker Payudara',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}