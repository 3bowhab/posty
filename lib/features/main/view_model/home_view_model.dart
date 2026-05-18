import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:posty/api/api_manager.dart';
import 'package:posty/models/post_model.dart';

enum HomeState { loading, loaded, error, empty }

class HomeViewModel extends ChangeNotifier {
  final ApiManager _apiManager = ApiManager();
  final String _postsBoxName = 'cached_posts_box';
  final String _postsKey = 'cached_posts_list';

  List<PostModel> _posts = [];
  String _errorMessage = '';
  HomeState _state = HomeState.loading;

  int _page = 1;
  final int _limit = 7;
  bool _hasNextPage = true;
  bool _isFetchingMore = false;
  bool _isOffline = false;

  List<PostModel> get posts => _posts;
  String get errorMessage => _errorMessage;
  HomeState get state => _state;
  bool get isFetchingMore => _isFetchingMore;
  bool get hasNextPage => _hasNextPage;
  bool get isOffline => _isOffline;

  Future<void> fetchFirstPosts() async {
    _page = 1;
    _hasNextPage = true;
    _isFetchingMore = false;
    _isOffline = false;
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

        final box = await Hive.openBox(_postsBoxName);
        final List<Map<String, dynamic>> rawData = fetchedPosts
            .map((post) => post.toJson())
            .toList();
        await box.put(_postsKey, rawData);

        if (fetchedPosts.length < _limit) {
          _hasNextPage = false;
        }
      }
    } catch (e) {
      final isLoadedFromCache = await _loadPostsFromCache();
      if (isLoadedFromCache) {
        _isOffline = true;
      } else {
        _errorMessage = e.toString();
        _state = HomeState.error;
      }
    }

    notifyListeners();
  }

  Future<void> fetchMorePosts() async {
    if (_isFetchingMore ||
        !_hasNextPage ||
        _state == HomeState.loading ||
        _isOffline) {
      return;
    }

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

        final box = await Hive.openBox(_postsBoxName);
        final List<Map<String, dynamic>> rawData = _posts
            .map((post) => post.toJson())
            .toList();
        await box.put(_postsKey, rawData);

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

  Future<bool> _loadPostsFromCache() async {
    try {
      final box = await Hive.openBox(_postsBoxName);
      final cachedData = box.get(_postsKey);

      if (cachedData != null && cachedData is List) {
        final List<PostModel> cachedPosts = [];
        for (var item in cachedData) {
          if (item is Map) {
            final Map<String, dynamic> convertedItem =
                Map<String, dynamic>.from(item);
            cachedPosts.add(PostModel.fromJson(convertedItem));
          }
        }

        if (cachedPosts.isNotEmpty) {
          _posts = cachedPosts;
          _state = HomeState.loaded;
          _hasNextPage = false;
          return true;
        }
      }
    } catch (e) {
      debugPrint("Error reading from Hive cache: $e");
    }
    return false;
  }

  void resetOfflineState() {
    _isOffline = false;
  }
}
