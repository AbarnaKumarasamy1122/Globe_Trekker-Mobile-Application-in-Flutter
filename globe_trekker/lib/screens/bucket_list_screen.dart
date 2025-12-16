import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/bucket_list_controller.dart';
import '../models/bucket_list_item.dart';
import '../widgets/bucket_list_card.dart';

class BucketListScreen extends StatefulWidget {
  const BucketListScreen({super.key});

  @override
  _BucketListScreenState createState() => _BucketListScreenState();
}

class _BucketListScreenState extends State<BucketListScreen> {
  SortOption _sortOption = SortOption.nameAscending;

  Future<bool?> _showDeleteConfirmation(String countryName) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove from Bucket List'),
          content: Text(
            'Are you sure you want to remove $countryName from your bucket list?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BucketListController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bucket List'),
        actions: [
          PopupMenuButton<SortOption>(
            onSelected: (option) {
              setState(() {
                _sortOption = option;
              });
              _applySorting(controller, option);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: SortOption.nameAscending,
                child: Text('Sort A-Z'),
              ),
              const PopupMenuItem(
                value: SortOption.nameDescending,
                child: Text('Sort Z-A'),
              ),
              const PopupMenuItem(
                value: SortOption.region,
                child: Text('Sort by Region'),
              ),
            ],
          ),
        ],
      ),
      body: controller.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No countries in bucket list',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Add countries from the explorer',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return BucketListCard(
                  item: item,
                  onDelete: () async {
                    final confirmed = await _showDeleteConfirmation(
                      item.country.name,
                    );
                    if (confirmed == true) {
                      controller.removeItem(item.id);
                    }
                  },
                  onToggleVisited: () {
                    final updatedItem = BucketListItem(
                      id: item.id,
                      country: item.country,
                      addedAt: item.addedAt,
                      visited: !item.visited,
                    );
                    controller.updateItem(updatedItem);
                  },
                );
              },
            ),
    );
  }

  void _applySorting(BucketListController controller, SortOption option) {
    switch (option) {
      case SortOption.nameAscending:
        controller.sortByName(true);
        break;
      case SortOption.nameDescending:
        controller.sortByName(false);
        break;
      case SortOption.region:
        controller.sortByRegion();
        break;
    }
  }
}

enum SortOption { nameAscending, nameDescending, region }
