import 'package:flutter/material.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String countryDetail = '/country-detail';
  static const String bucketList = '/bucket-list';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case countryDetail:
        final country = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => CountryDetailScreen(country: country),
        );
      case bucketList:
        return MaterialPageRoute(builder: (_) => const BucketListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static void navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, home);
  }

  static void navigateToDetail(BuildContext context, dynamic country) {
    Navigator.pushNamed(context, countryDetail, arguments: country);
  }

  static void navigateToBucketList(BuildContext context) {
    Navigator.pushNamed(context, bucketList);
  }
}

// Import these for the router to work - add to actual implementation
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => Container();
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Container();
}

class CountryDetailScreen extends StatelessWidget {
  final dynamic country;
  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) => Container();
}

class BucketListScreen extends StatelessWidget {
  const BucketListScreen({super.key});

  @override
  Widget build(BuildContext context) => Container();
}
