import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/country_model.dart';

enum SortOrder { ascending, descending, none }

class CountryController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  String _searchQuery = '';
  String? _selectedRegion;
  SortOrder _sortOrder = SortOrder.none;
  bool _isLoading = false;
  String? _error;
  
  List<Country> get countries => _filteredCountries;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  CountryController() {
    loadCountries();
  }
  
  Future<void> loadCountries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _countries = await _apiService.fetchCountries();
      _applyFilters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void searchCountries(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }
  
  void filterByRegion(String? region) {
    _selectedRegion = region;
    _applyFilters();
  }
  
  void sortCountries(SortOrder order) {
    _sortOrder = order;
    _applyFilters();
  }
  
  void _applyFilters() {
    List<Country> filtered = _countries;
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((country) =>
              country.name.toLowerCase().contains(_searchQuery) ||
              country.capital.toLowerCase().contains(_searchQuery))
          .toList();
    }
    
    // Apply region filter
    if (_selectedRegion != null && _selectedRegion!.isNotEmpty) {
      filtered = filtered
          .where((country) => country.region == _selectedRegion)
          .toList();
    }
    
    // Apply sorting
    switch (_sortOrder) {
      case SortOrder.ascending:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOrder.descending:
        filtered.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortOrder.none:
        break;
    }
    
    _filteredCountries = filtered;
    notifyListeners();
  }
  
  List<String> getRegions() {
    return _countries
        .map((country) => country.region)
        .where((region) => region.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }
}