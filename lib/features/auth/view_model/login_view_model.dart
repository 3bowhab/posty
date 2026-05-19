import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController(
    text: "ali2@gmail.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "Password&123",
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<String?> login() async {
    if (!formKey.currentState!.validate()) return null;

    setLoading(true);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      setLoading(false);
      return credential.user?.uid;
    } on FirebaseAuthException {
      setLoading(false);
      rethrow;
    } catch (e) {
      setLoading(false);
      throw e.toString();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
