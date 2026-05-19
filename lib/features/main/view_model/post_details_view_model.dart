import 'package:flutter/material.dart';
import 'package:posty/data/api/api_manager.dart';
import 'package:posty/data/models/comment_model.dart';

enum CommentsState { loading, loaded, error, empty }

class PostDetailsViewModel extends ChangeNotifier {
  final ApiManager _apiManager = ApiManager();
  final int postId;

  PostDetailsViewModel({required this.postId});

  List<CommentModel> _comments = [];
  String _errorMessage = '';
  CommentsState _state = CommentsState.loading;

  List<CommentModel> get comments => _comments;
  String get errorMessage => _errorMessage;
  CommentsState get state => _state;

  Future<void> fetchFirstComments() async {
    _state = CommentsState.loading;
    notifyListeners();

    try {
      final fetchedComments = await _apiManager.getComments(postId: postId);

      if (fetchedComments.isEmpty) {
        _state = CommentsState.empty;
      } else {
        _comments = fetchedComments;
        _state = CommentsState.loaded;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _state = CommentsState.error;
    }

    notifyListeners();
  }
}
