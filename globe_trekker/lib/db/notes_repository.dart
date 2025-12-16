import 'package:hive_flutter/hive_flutter.dart';

class NotesRepository {
  static const String _boxName = 'countryNotes';
  late Box<String> _box;

  Future<void> init() async {
    _box = await Hive.openBox<String>(_boxName);
  }

  Future<void> saveNote(String countryName, String note) async {
    await _box.put(countryName, note);
  }

  String? getNote(String countryName) {
    return _box.get(countryName);
  }

  Future<void> deleteNote(String countryName) async {
    await _box.delete(countryName);
  }

  Map<String, String> getAllNotes() {
    final Map<String, String> notes = {};
    for (var key in _box.keys) {
      final note = _box.get(key);
      if (note != null) {
        notes[key.toString()] = note;
      }
    }
    return notes;
  }

  bool hasNote(String countryName) {
    return _box.containsKey(countryName);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
