import 'package:flutter/material.dart';
import 'package:posty/api/api_manager.dart';

enum CreatePostState { idle, loading, success, error }

class CreatePostViewModel extends ChangeNotifier {
  final ApiManager _apiManager = ApiManager();

  CreatePostState _state = CreatePostState.idle;
  String _errorMessage = '';

  CreatePostState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> createPost({required String title, required String body}) async {
    _state = CreatePostState.loading;
    notifyListeners();

    try {
      await _apiManager.createPost(title: title, body: body, userId: 1);
      _state = CreatePostState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = CreatePostState.error;
    }

    notifyListeners();
  }

  void resetState() {
    _state = CreatePostState.idle;
    _errorMessage = '';
  }
}
