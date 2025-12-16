import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const CountryCard({super.key, required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Flag
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: country.flag.isNotEmpty
                    ? Image.network(
                        country.flag,
                        width: 60,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 40,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.flag,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 60,
                            height: 40,
                            color: Colors.grey[200],
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 60,
                        height: 40,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.flag,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(width: 16),

              // Country Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      country.capital.isNotEmpty
                          ? country.capital
                          : 'No capital',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // Region Chip
              Chip(
                label: Text(country.region),
                backgroundColor: _getRegionColor(country.region),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _getRegionColor(String region) {
    final colors = {
      'Asia': Colors.blue[100],
      'Europe': Colors.green[100],
      'Africa': Colors.orange[100],
      'Americas': Colors.red[100],
      'Oceania': Colors.purple[100],
    };
    return colors[region] ?? Colors.grey[100];
  }
}
