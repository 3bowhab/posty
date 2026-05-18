import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posty/core/utils/firebase_exceptions.dart';
import 'package:posty/models/user_model.dart';
import 'package:posty/providers/user_provider.dart';
import 'package:posty/services/firebase_service.dart';
import 'package:provider/provider.dart';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController(
    text: "Ali",
  );
  final TextEditingController emailController = TextEditingController(
    text: "ali2@gmail.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "Password&123",
  );
  final TextEditingController confirmPasswordController = TextEditingController(
    text: "Password&123",
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;

    _setLoading(true);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      final String uid = credential.user?.uid ?? '';

      await FirebaseService.addUserToFirestore(
        UserModel(
          email: emailController.text,
          uid: uid,
          name: nameController.text,
        ),
      );

      if (!context.mounted) return false;

      await context.read<UserProvider>().getUserData(uid);

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      if (context.mounted) {
        throw FirebaseAuthExceptions.getMessage(e, context);
      }
      throw 'An error occurred';
    } catch (e) {
      _setLoading(false);
      throw e.toString();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
