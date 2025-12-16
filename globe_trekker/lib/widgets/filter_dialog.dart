import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/country_controller.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final List<String> _regions = [
    'All',
    'Africa',
    'Americas',
    'Asia',
    'Europe',
    'Oceania',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CountryController>(context, listen: false);

    return AlertDialog(
      title: const Text('Filter Countries'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _regions.length,
          itemBuilder: (context, index) {
            final region = _regions[index];
            return ListTile(
              title: Text(region),
              onTap: () {
                if (region == 'All') {
                  controller.filterByRegion(null);
                } else {
                  controller.filterByRegion(region);
                }
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
