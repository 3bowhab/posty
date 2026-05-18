import 'package:flutter/material.dart';
import 'package:posty/models/user_model.dart';
import 'package:posty/providers/user_provider.dart';
import 'package:posty/services/firebase_service.dart';
import 'package:provider/provider.dart';

class GoogleAuthViewModel extends ChangeNotifier {
  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    _setLoading(true);
    try {
      final credential = await FirebaseService().signInWithGoogle();
      if (credential == null) {
        _setLoading(false);
        return;
      }

      final userCredential = credential.user;
      if (userCredential == null) throw 'User data not found';

      UserModel? existingUser = await FirebaseService.getUserFromFirestore(
        userCredential.uid,
      );

      if (existingUser == null) {
        final newUser = UserModel(
          uid: userCredential.uid,
          email: userCredential.email ?? '',
          name: userCredential.displayName ?? '',
        );

        await FirebaseService.addUserToFirestore(newUser);

        if (context.mounted) {
          context.read<UserProvider>().updateUserData(newUser);
        }

        _setLoading(false);
      } else {
        if (context.mounted) {
          context.read<UserProvider>().updateUserData(existingUser);
        }

        _setLoading(false);
      }
    } catch (e) {
      _setLoading(false);
      rethrow;
    }
  }
}
