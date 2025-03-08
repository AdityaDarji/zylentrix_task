import 'package:flutter/material.dart';
import 'package:zylentrix_api_task/models/post_model.dart';
import 'package:zylentrix_api_task/services/api_services.dart';

class PostViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<int, List<Post>> groupedPosts = {};
  bool isLoading = true;
  String? errorMessage;

  Future<void> getPosts() async {
    try {
      isLoading = true;
      notifyListeners();

      List<Post> posts = await _apiService.fetchPosts();

      // Group all posts by userId
      groupedPosts = {};
      for (var post in posts) {
        groupedPosts.putIfAbsent(post.userId, () => []).add(post);
      }

      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
