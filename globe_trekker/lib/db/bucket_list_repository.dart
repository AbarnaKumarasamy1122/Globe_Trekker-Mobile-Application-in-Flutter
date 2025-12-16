import 'package:hive/hive.dart';
import '../models/bucket_list_item.dart';

class BucketListRepository {
  final Box<BucketListItem> box;
  
  BucketListRepository(this.box);
  
  Future<void> addItem(BucketListItem item) async {
    await box.put(item.id, item);
  }
  
  Future<void> removeItem(String id) async {
    await box.delete(id);
  }
  
  List<BucketListItem> getAllItems() {
    return box.values.toList();
  }
  
  Future<void> updateItem(BucketListItem item) async {
    await box.put(item.id, item);
  }
  
  bool isCountryInBucketList(String countryName) {
    return box.values.any((item) => item.country.name == countryName);
  }
}