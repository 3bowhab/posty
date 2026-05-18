import 'package:flutter/material.dart';
import 'package:posty/api/api_manager.dart';
import 'package:posty/models/comment_model.dart';

enum CommentsState { loading, loaded, error, empty }

class PostDetailsViewModel extends ChangeNotifier {
  final ApiManager _apiManager = ApiManager();
  final int postId;

  PostDetailsViewModel({required this.postId});

  List<CommentModel> _comments = [];
  String _errorMessage = '';
  CommentsState _state = CommentsState.loading;

  int _page = 1;
  final int _limit = 3;
  bool _hasNextPage = true;
  bool _isFetchingMore = false;

  List<CommentModel> get comments => _comments;
  String get errorMessage => _errorMessage;
  CommentsState get state => _state;
  bool get isFetchingMore => _isFetchingMore;
  bool get hasNextPage => _hasNextPage;

  Future<void> fetchFirstComments() async {
    _page = 1;
    _hasNextPage = true;
    _isFetchingMore = false;
    _state = CommentsState.loading;
    notifyListeners();

    try {
      final fetchedComments = await _apiManager.getComments(
        postId: postId,
        page: _page,
        limit: _limit,
      );

      if (fetchedComments.isEmpty) {
        _state = CommentsState.empty;
      } else {
        _comments = fetchedComments;
        _state = CommentsState.loaded;

        if (fetchedComments.length < _limit) {
          _hasNextPage = false;
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      _state = CommentsState.error;
    }

    notifyListeners();
  }

  Future<void> fetchMoreComments() async {
    if (_isFetchingMore || !_hasNextPage || _state == CommentsState.loading) {
      return;
    }

    _isFetchingMore = true;
    notifyListeners();

    _page++;

    try {
      final fetchedComments = await _apiManager.getComments(
        postId: postId,
        page: _page,
        limit: _limit,
      );

      if (fetchedComments.isNotEmpty) {
        _comments.addAll(fetchedComments);

        if (fetchedComments.length < _limit) {
          _hasNextPage = false;
        }
      } else {
        _hasNextPage = false;
      }
    } catch (e) {
      _page--;
      debugPrint("Error fetching more comments: $e");
    }

    _isFetchingMore = false;
    notifyListeners();
  }
}
