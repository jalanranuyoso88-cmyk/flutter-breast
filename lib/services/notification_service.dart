import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String _reminderKey = 'breastlens_reminder_enabled';
  static const String _nextReminderKey = 'next_breastlens_reminder';

  // Initialize notifications (simplified version)
  static Future<void> initialize() async {
    print('NotificationService initialized (simplified version)');
  }

  // Set up monthly BreastLens reminder (simplified version)
  static Future<bool> setMonthlyReminder() async {
    try {
      // Save reminder status
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_reminderKey, true);
      
      // Set next reminder date (30 days from now)
      final nextReminder = DateTime.now().add(const Duration(days: 30));
      await prefs.setString(_nextReminderKey, nextReminder.toIso8601String());
      
      print('Monthly BreastLens reminder set successfully (simplified)');
      
      // Show success message (simulated notification)
      print('🔔 NOTIFICATION: Pengingat Bulanan BreastLens');
      print('📅 Jangan lupa untuk melakukan BreastLens setiap bulan!');
      print('⏰ Waktu yang tepat untuk memeriksa kesehatan payudara Anda.');
      
      return true;
    } catch (e) {
      print('Error setting monthly reminder: $e');
      return false;
    }
  }

  // Cancel monthly reminder
  static Future<void> cancelMonthlyReminder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_reminderKey, false);
      await prefs.remove(_nextReminderKey);
      
      print('Monthly BreastLens reminder cancelled');
    } catch (e) {
      print('Error cancelling monthly reminder: $e');
    }
  }

  // Check if reminder is enabled
  static Future<bool> isReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_reminderKey) ?? false;
  }

  // Get next reminder date
  static Future<DateTime?> getNextReminderDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_nextReminderKey);
    if (dateString != null) {
      try {
        return DateTime.parse(dateString);
      } catch (e) {
        print('Error parsing reminder date: $e');
        return null;
      }
    }
    return null;
  }

  // Show test notification (simulated)
  static Future<void> showTestNotification() async {
    print('🔔 TEST NOTIFICATION: Pengingat Bulanan BreastLens');
    print('📅 Jangan lupa untuk melakukan BreastLens setiap bulan!');
    print('⏰ Waktu yang tepat untuk memeriksa kesehatan payudara Anda.');
  }
}