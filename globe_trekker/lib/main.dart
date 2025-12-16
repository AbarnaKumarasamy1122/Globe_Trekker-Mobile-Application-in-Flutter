import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'models/country_model.dart';
import 'models/bucket_list_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(BucketListItemAdapter());

  // IMPORTANT for Flutter web:
  // If you see Hive box type errors, clear your browser's site data (IndexedDB) for this app.
  // The following lines will delete the boxes on every run. Remove them after the first successful run if you wish.
  await Hive.deleteBoxFromDisk('bucketlist');
  await Hive.deleteBoxFromDisk('countrynotes');

  // Open boxes with correct types
  await Hive.openBox('settings');
  await Hive.openBox<BucketListItem>('bucketlist');
  await Hive.openBox<String>('countrynotes');

  runApp(const MyApp());
}
