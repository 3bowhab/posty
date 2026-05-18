import 'package:flutter/material.dart';
import 'package:posty/api/api_manager.dart';
import 'package:posty/models/post_model.dart';

enum HomeState { loading, loaded, error, empty }

class HomeViewModel extends ChangeNotifier {
  final ApiManager _apiManager = ApiManager();

  List<PostModel> _posts = [];
  String _errorMessage = '';
  HomeState _state = HomeState.loading;

  int _page = 1;
  final int _limit = 7;
  bool _hasNextPage = true;
  bool _isFetchingMore = false;

  List<PostModel> get posts => _posts;
  String get errorMessage => _errorMessage;
  HomeState get state => _state;
  bool get isFetchingMore => _isFetchingMore;
  bool get hasNextPage => _hasNextPage;

  Future<void> fetchFirstPosts() async {
    _page = 1;
    _hasNextPage = true;
    _isFetchingMore = false;
    _state = HomeState.loading;
    notifyListeners();

    try {
      final fetchedPosts = await _apiManager.getPosts(
        page: _page,
        limit: _limit,
      );

      if (fetchedPosts.isEmpty) {
        _state = HomeState.empty;
      } else {
        _posts = fetchedPosts;
        _state = HomeState.loaded;

        if (fetchedPosts.length < _limit) {
          _hasNextPage = false;
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      _state = HomeState.error;
    }

    notifyListeners();
  }

  Future<void> fetchMorePosts() async {
    if (_isFetchingMore || !_hasNextPage || _state == HomeState.loading) return;

    _isFetchingMore = true;
    notifyListeners();

    _page++;

    try {
      final fetchedPosts = await _apiManager.getPosts(
        page: _page,
        limit: _limit,
      );

      if (fetchedPosts.isNotEmpty) {
        _posts.addAll(fetchedPosts);

        if (fetchedPosts.length < _limit) {
          _hasNextPage = false;
        }
      } else {
        _hasNextPage = false;
      }
    } catch (e) {
      _page--;
      debugPrint("Error fetching more posts: $e");
    }

    _isFetchingMore = false;
    notifyListeners();
  }
}
