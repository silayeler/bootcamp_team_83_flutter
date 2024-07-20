import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keySeenStory = 'seenStory';

  Future<void> setSeenStory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySeenStory, true);
  }

  Future<bool> hasSeenStory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySeenStory) ?? false;
  }
}
