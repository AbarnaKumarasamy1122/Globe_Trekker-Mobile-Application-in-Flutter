import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';
import 'api_exceptions.dart';

class ApiService {
  static const String baseUrl = 'https://api.sampleapis.com/countries/countries';
  
  final http.Client client;
  
  ApiService({http.Client? client}) : client = client ?? http.Client();
  
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await client.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw ApiException('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }
}