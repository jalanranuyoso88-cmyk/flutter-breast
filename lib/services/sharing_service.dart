import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/analysis_history.dart';

class SharingService {
  /// Show sharing options dialog
  static Future<void> showSharingOptions(
    BuildContext context,
    AnalysisHistory historyItem,
  ) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _SharingOptionsBottomSheet(historyItem: historyItem),
    );
  }
  
  /// Share to WhatsApp
  static Future<void> shareToWhatsApp(AnalysisHistory historyItem) async {
    try {
      final message = _buildShareMessage(historyItem);
      final whatsappUrl = 'whatsapp://send?text=${Uri.encodeComponent(message)}';
      
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        throw Exception('WhatsApp tidak terinstall di perangkat ini');
      }
    } catch (e) {
      throw Exception('Gagal membuka WhatsApp: $e');
    }
  }
  
  /// Share to Facebook
  static Future<void> shareToFacebook(AnalysisHistory historyItem) async {
    try {
      final message = _buildShareMessage(historyItem);
      final facebookUrl = 'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(message)}';
      
      if (await canLaunchUrl(Uri.parse(facebookUrl))) {
        await launchUrl(Uri.parse(facebookUrl));
      } else {
        throw Exception('Tidak dapat membuka Facebook');
      }
    } catch (e) {
      throw Exception('Gagal membuka Facebook: $e');
    }
  }
  
  /// Share to Twitter
  static Future<void> shareToTwitter(AnalysisHistory historyItem) async {
    try {
      final message = _buildShareMessage(historyItem);
      final twitterUrl = 'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}';
      
      if (await canLaunchUrl(Uri.parse(twitterUrl))) {
        await launchUrl(Uri.parse(twitterUrl));
      } else {
        throw Exception('Tidak dapat membuka Twitter');
      }
    } catch (e) {
      throw Exception('Gagal membuka Twitter: $e');
    }
  }
  
  /// Share to Instagram (opens Instagram app)
  static Future<void> shareToInstagram(AnalysisHistory historyItem) async {
    try {
      // Instagram doesn't support direct text sharing, so we'll try to open the app
      final instagramUrl = 'instagram://camera';
      
      if (await canLaunchUrl(Uri.parse(instagramUrl))) {
        await launchUrl(Uri.parse(instagramUrl));
      } else {
        // Fallback to web version
        final webUrl = 'https://www.instagram.com/';
        if (await canLaunchUrl(Uri.parse(webUrl))) {
          await launchUrl(Uri.parse(webUrl));
        } else {
          throw Exception('Instagram tidak terinstall di perangkat ini');
        }
      }
    } catch (e) {
      throw Exception('Gagal membuka Instagram: $e');
    }
  }
  
  /// Share using system share dialog (copy to clipboard)
  static Future<void> shareSystem(BuildContext context, AnalysisHistory historyItem) async {
    try {
      final message = _buildShareMessage(historyItem);
      // Copy to clipboard as fallback
      await Clipboard.setData(ClipboardData(text: message));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hasil analisis telah disalin ke clipboard'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      throw Exception('Gagal menyalin ke clipboard: $e');
    }
  }
  
  /// Build share message
  static String _buildShareMessage(AnalysisHistory historyItem) {
    final result = historyItem.isCancer ? 'Kanker' : 'Normal';
    final confidence = historyItem.confidenceText;
    final date = '${historyItem.timestamp.day}/${historyItem.timestamp.month}/${historyItem.timestamp.year}';
    
    return '''🔬 Hasil Analisis Kanker Payudara

📊 Hasil: $result
🎯 Tingkat Keyakinan: $confidence
📅 Tanggal: $date

💡 Aplikasi ini menggunakan teknologi AI untuk membantu deteksi dini kanker payudara. Selalu konsultasikan dengan dokter untuk hasil yang lebih akurat.

#DeteksiKankerPayudara #KesehatanWanita #AI''';
  }
}

class _SharingOptionsBottomSheet extends StatelessWidget {
  final AnalysisHistory historyItem;
  
  const _SharingOptionsBottomSheet({
    required this.historyItem,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Bagikan Hasil Analisis',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Sharing options
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                _SharingOption(
                  icon: Icons.message,
                  title: 'WhatsApp',
                  subtitle: 'Bagikan ke WhatsApp',
                  color: const Color(0xFF25D366),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      await SharingService.shareToWhatsApp(historyItem);
                    } catch (e) {
                      _showErrorSnackBar(context, e.toString());
                    }
                  },
                ),
                
                const SizedBox(height: 12),
                
                _SharingOption(
                  icon: Icons.facebook,
                  title: 'Facebook',
                  subtitle: 'Bagikan ke Facebook',
                  color: const Color(0xFF1877F2),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      await SharingService.shareToFacebook(historyItem);
                    } catch (e) {
                      _showErrorSnackBar(context, e.toString());
                    }
                  },
                ),
                
                const SizedBox(height: 12),
                
                _SharingOption(
                  icon: Icons.alternate_email,
                  title: 'Twitter',
                  subtitle: 'Bagikan ke Twitter',
                  color: const Color(0xFF1DA1F2),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      await SharingService.shareToTwitter(historyItem);
                    } catch (e) {
                      _showErrorSnackBar(context, e.toString());
                    }
                  },
                ),
                
                const SizedBox(height: 12),
                
                _SharingOption(
                  icon: Icons.camera_alt,
                  title: 'Instagram',
                  subtitle: 'Buka Instagram',
                  color: const Color(0xFFE4405F),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      await SharingService.shareToInstagram(historyItem);
                    } catch (e) {
                      _showErrorSnackBar(context, e.toString());
                    }
                  },
                ),
                
                const SizedBox(height: 12),
                
                _SharingOption(
                  icon: Icons.share,
                  title: 'Lainnya',
                  subtitle: 'Salin ke clipboard',
                  color: Colors.grey.shade600,
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      await SharingService.shareSystem(context, historyItem);
                    } catch (e) {
                      _showErrorSnackBar(context, e.toString());
                    }
                  },
                ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
  
  void _showErrorSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _SharingOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  
  const _SharingOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
