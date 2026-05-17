import 'package:flutter/material.dart';
import 'package:posty/models/user.dart';
import 'package:posty/services/firebase_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  Future<void> getUserData(
    String userId,
  ) async {
    currentUser = await FirebaseService.getUserFromFirestore(
      userId,
    );
    notifyListeners();
  }

  void updateUserData(UserModel updatedUser) {
    currentUser = updatedUser;
    notifyListeners();
  }
}