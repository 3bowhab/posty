import 'package:flutter/material.dart';
import 'package:posty/models/user_model.dart';
import 'package:posty/services/firebase_service.dart';

class GoogleAuthViewModel extends ChangeNotifier {
  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<UserModel?> handleGoogleSignIn() async {
    _setLoading(true);
    try {
      final credential = await FirebaseService().signInWithGoogle();
      if (credential == null) {
        _setLoading(false);
        return null;
      }

      final userCredential = credential.user;
      if (userCredential == null) throw 'User data not found';

      UserModel? user = await FirebaseService.getUserFromFirestore(
        userCredential.uid,
      );

      if (user == null) {
        user = UserModel(
          uid: userCredential.uid,
          email: userCredential.email ?? '',
          name: userCredential.displayName ?? '',
        );
        await FirebaseService.addUserToFirestore(user);
      }

      _setLoading(false);
      return user;
    } catch (e) {
      _setLoading(false);
      rethrow;
    }
  }
}
