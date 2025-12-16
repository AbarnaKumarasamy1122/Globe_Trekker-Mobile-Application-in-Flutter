import 'package:hive/hive.dart';

class HiveService {
  static const String notesBox = 'countrynotes';
  static const String settingsBox = 'settings';

  Future<void> saveNote(String countryName, String note) async {
    final box = Hive.box<String>(notesBox);
    await box.put(countryName, note);
  }

  Future<String?> getNote(String countryName) async {
    final box = Hive.box<String>(notesBox);
    return box.get(countryName);
  }

  Future<void> deleteNote(String countryName) async {
    final box = Hive.box<String>(notesBox);
    await box.delete(countryName);
  }

  Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(settingsBox);
    await box.put(key, value);
  }

  Future<dynamic> getSetting(String key) async {
    final box = Hive.box(settingsBox);
    return box.get(key);
  }
}
