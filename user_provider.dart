import 'package:flutter/material.dart';
import 'package:hooka/screens/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser ;
  late Box<User> _userBox;
  bool _isLoading = false; // Loading state

  UserProvider() {
    _openHiveBox().then((_) {
      _fetchUserData();
    });
  }

  Future<void> _openHiveBox() async {
    _userBox = await Hive.openBox<User>('users');
  }

  Future<void> _fetchUserData() async {
    try {
      _currentUser  = _userBox.get('currentUser '); // Ensure no extra space in the key
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during fetching
      print('Error fetching user data: $e');
    }
  }

  User? get currentUser  => _currentUser ;

  Future<void> saveUserData(User updatedUser ) async {
    _isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners about loading state

    try {
      _currentUser  = updatedUser ;
      await _userBox.put('currentUser ', _currentUser !); // Ensure no extra space in the key
      notifyListeners(); // Notify listeners after saving
    } catch (e) {
      // Handle any errors that occur during saving
      print('Error saving user data: $e');
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners about loading state change
    }
  }

  bool get isLoading => _isLoading; // Expose loading state
}
