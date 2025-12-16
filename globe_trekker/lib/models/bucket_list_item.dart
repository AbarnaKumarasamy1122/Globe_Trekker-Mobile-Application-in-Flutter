import 'package:hive/hive.dart';
import 'country_model.dart';

part 'bucket_list_item.g.dart';

@HiveType(typeId: 1)
class BucketListItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Country country;
  @HiveField(2)
  final DateTime addedAt;
  @HiveField(3)
  bool visited;

  BucketListItem({
    required this.id,
    required this.country,
    required this.addedAt,
    this.visited = false,
  });

  factory BucketListItem.fromCountry(Country country) {
    return BucketListItem(
      id: '${country.name}_${DateTime.now().millisecondsSinceEpoch}',
      country: country,
      addedAt: DateTime.now(),
    );
  }
}