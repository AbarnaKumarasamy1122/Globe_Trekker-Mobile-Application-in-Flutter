import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/bucket_list_item.dart';
import '../models/country_model.dart';

class BucketListController extends ChangeNotifier {
  late Box<BucketListItem> _box;

  List<BucketListItem> _items = [];
  bool _isInitialized = false;

  List<BucketListItem> get items => _items;
  bool get isInitialized => _isInitialized;

  BucketListController() {
    _init();
  }

  void _init() {
    try {
      _box = Hive.box<BucketListItem>('bucketlist');
      _loadItems();
      _isInitialized = true;
    } catch (e) {
      print('Error initializing BucketListController: $e');
      _isInitialized = false;
    }
  }

  void _loadItems() {
    if (_isInitialized) {
      _items = _box.values.toList();
      notifyListeners();
    }
  }

  Future<void> addCountry(Country country) async {
    if (!_isInitialized) return;
    final item = BucketListItem.fromCountry(country);
    await _box.put(item.id, item);
    _loadItems();
  }

  Future<void> removeItem(String id) async {
    if (!_isInitialized) return;
    await _box.delete(id);
    _loadItems();
  }

  Future<void> updateItem(BucketListItem item) async {
    if (!_isInitialized) return;
    await _box.put(item.id, item);
    _loadItems();
  }

  bool isInBucketList(String countryName) {
    if (!_isInitialized) return false;
    return _items.any((item) => item.country.name == countryName);
  }

  void sortByName(bool ascending) {
    if (!_isInitialized) return;
    _items.sort(
      (a, b) => ascending
          ? a.country.name.compareTo(b.country.name)
          : b.country.name.compareTo(a.country.name),
    );
    notifyListeners();
  }

  void sortByRegion() {
    _items.sort((a, b) => a.country.name.compareTo(b.country.name));
    notifyListeners();
  }
}
