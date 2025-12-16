import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/country_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/country_card.dart';
import '../widgets/shimmer_loader.dart';
import '../widgets/error_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/filter_dialog.dart';
import 'bucket_list_screen.dart';
import 'country_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Explorer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BucketListScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
          Consumer<ThemeController>(
            builder: (context, themeController, child) {
              return IconButton(
                icon: Icon(
                  themeController.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: themeController.toggleTheme,
              );
            },
          ),
        ],
      ),
      body: Consumer<CountryController>(
        builder: (context, controller, child) {
          if (controller.isLoading && controller.countries.isEmpty) {
            return const ShimmerLoader();
          }

          if (controller.error != null && controller.countries.isEmpty) {
            return CustomErrorWidget(
              message: controller.error!,
              onRetry: controller.loadCountries,
            );
          }

          return RefreshIndicator(
            onRefresh: controller.loadCountries,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomSearchBar(
                    onSearch: (query) {
                      controller.searchCountries(query);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.countries.length,
                    itemBuilder: (context, index) {
                      final country = controller.countries[index];
                      return CountryCard(
                        country: country,
                        onTap: () => _navigateToDetail(context, country),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => FilterDialog());
  }

  void _navigateToDetail(BuildContext context, country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryDetailScreen(country: country),
      ),
    );
  }
}
