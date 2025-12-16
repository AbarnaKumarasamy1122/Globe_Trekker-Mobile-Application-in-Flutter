import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/country_model.dart';
import '../controllers/bucket_list_controller.dart';
import '../db/hive_service.dart';

class CountryDetailScreen extends StatefulWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  _CountryDetailScreenState createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  final TextEditingController _noteController = TextEditingController();
  final HiveService _hiveService = HiveService();
  String? _savedNote;
  bool _isEditingNote = false;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _loadNote() async {
    final note = await _hiveService.getNote(widget.country.name);
    setState(() {
      _savedNote = note;
      if (_savedNote != null) {
        _noteController.text = _savedNote!;
      }
    });
  }

  Future<void> _saveNote() async {
    if (_noteController.text.isNotEmpty) {
      await _hiveService.saveNote(widget.country.name, _noteController.text);
      setState(() {
        _savedNote = _noteController.text;
        _isEditingNote = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note saved')));
    }
  }

  Future<void> _deleteNote() async {
    final confirmed = await _showDeleteConfirmation(
      context,
      'Delete Note',
      'Are you sure you want to delete this note?',
    );

    if (confirmed == true) {
      await _hiveService.deleteNote(widget.country.name);
      setState(() {
        _savedNote = null;
        _noteController.clear();
        _isEditingNote = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note deleted')));
    }
  }

  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    String title,
    String message,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BucketListController>(
      builder: (context, bucketListController, child) {
        if (!bucketListController.isInitialized) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.country.name)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final isInBucketList = bucketListController.isInBucketList(
          widget.country.name,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.country.name),
            actions: [
              IconButton(
                icon: Icon(
                  isInBucketList ? Icons.bookmark : Icons.bookmark_border,
                  color: isInBucketList ? Colors.amber : null,
                ),
                onPressed: () {
                  if (isInBucketList) {
                    // Find and remove from bucket list
                    final item = bucketListController.items.firstWhere(
                      (item) => item.country.name == widget.country.name,
                    );
                    bucketListController.removeItem(item.id);
                  } else {
                    bucketListController.addCountry(widget.country);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isInBucketList
                            ? 'Removed from bucket list'
                            : 'Added to bucket list',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flag Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.country.flag,
                      width: 200,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 200,
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.flag, size: 50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Country Details
                _buildDetailRow('Country Code', widget.country.abbreviation),
                _buildDetailRow('Capital', widget.country.capital),
                _buildDetailRow(
                  'Population',
                  _formatPopulation(widget.country.population),
                ),
                _buildDetailRow('Currency', widget.country.currency),
                _buildDetailRow('Phone Code', widget.country.phone),
                const SizedBox(height: 16),

                // Emblem Image if available
                if (widget.country.emblem != null &&
                    widget.country.emblem!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'National Emblem',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.country.emblem!,
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 150,
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, size: 50),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                // Orthographic Map if available
                if (widget.country.orthographic != null &&
                    widget.country.orthographic!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Map View',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.country.orthographic!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.map, size: 50),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                // Personal Notes Section
                const SizedBox(height: 32),
                const Text(
                  'Personal Notes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                if (_savedNote != null && !_isEditingNote)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_savedNote!),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditingNote = true;
                                  });
                                },
                                child: const Text('Edit'),
                              ),
                              TextButton(
                                onPressed: _deleteNote,
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _noteController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText:
                                  'Add your personal notes about this country...',
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_isEditingNote)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEditingNote = false;
                                      _noteController.text = _savedNote ?? '';
                                    });
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ElevatedButton(
                                onPressed: _saveNote,
                                child: const Text('Save Note'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value.isNotEmpty ? value : 'N/A')),
        ],
      ),
    );
  }

  String _formatPopulation(int population) {
    if (population >= 1000000) {
      return '${(population / 1000000).toStringAsFixed(2)} million';
    } else if (population >= 1000) {
      return '${(population / 1000).toStringAsFixed(2)} thousand';
    }
    return population.toString();
  }
}
