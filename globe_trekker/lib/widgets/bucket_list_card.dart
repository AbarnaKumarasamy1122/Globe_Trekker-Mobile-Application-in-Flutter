import 'package:flutter/material.dart';
import '../models/bucket_list_item.dart';

class BucketListCard extends StatelessWidget {
  final BucketListItem item;
  final VoidCallback onDelete;
  final VoidCallback onToggleVisited;

  const BucketListCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onToggleVisited,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.country.flag),
        ),
        title: Text(
          item.country.name,
          style: TextStyle(
            decoration: item.visited ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('Capital: ${item.country.capital}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                item.visited ? Icons.check_circle : Icons.check_circle_outline,
                color: item.visited ? Colors.green : null,
              ),
              onPressed: onToggleVisited,
            ),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
