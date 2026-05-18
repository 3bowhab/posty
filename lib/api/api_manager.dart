import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:posty/api/api_constants.dart';
import 'package:posty/api/api_end_points.dart';
import 'package:posty/models/comment_model.dart';
import 'package:posty/models/post_model.dart';

class ApiManager {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      queryParameters: {},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<PostModel>> getPosts({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        ApiEndPoints.getPosts,
        queryParameters: {'_page': page, '_limit': limit},
      );

      final List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.data != null) {
        String errorMessage = 'Unknown Error from Server';
        if (e.response!.data is Map && e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        }
        throw Exception(errorMessage);
      } else {
        throw Exception(e.message ?? 'Network Error');
      }
    }
  }

  Future<List<CommentModel>> getComments({
    required int postId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        ApiEndPoints.getComments,
        queryParameters: {'postId': postId, '_page': page, '_limit': limit},
      );

      final List<dynamic> data = response.data;
      return data.map((json) => CommentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.data != null) {
        String errorMessage = 'Unknown Error from Server';
        if (e.response!.data is Map && e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        }
        throw Exception(errorMessage);
      } else {
        throw Exception(e.message ?? 'Network Error');
      }
    }
  }

  Future<PostModel> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    try {
      final response = await dio.post(
        ApiEndPoints.getPosts,
        data: {'title': title, 'body': body, 'userId': userId},
      );

      final newPost = PostModel.fromJson(response.data);

      debugPrint(
        "JSONPlaceholder server received the post successfully. New ID is: ${newPost.id}",
      );

      return newPost;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        String errorMessage = 'Unknown Error from Server';
        if (e.response!.data is Map && e.response!.data['message'] != null) {
          errorMessage = e.response!.data['message'];
        }
        throw Exception(errorMessage);
      } else {
        throw Exception(e.message ?? 'Network Error');
      }
    }
  }
}
