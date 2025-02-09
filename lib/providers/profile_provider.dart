import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../services/api_service.dart'; // ✅ Import API service

class ProfileProvider extends ChangeNotifier {
  Profile? _profile;
  bool _isLoading = false;
  String? _errorMessage;

  Profile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ✅ Fetch profile from API
  Future<void> fetchProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profile = await ApiService.fetchProfile(); // ✅ Call API service
    } catch (e) {
      _profile = null;
      _errorMessage = "Error fetching profile: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ Refresh profile data
  Future<void> refreshProfile() async {
    await fetchProfile();
  }
}
