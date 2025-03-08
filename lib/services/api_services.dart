import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  static const String _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    //Error handling for the API response
    try {
      final response = await http
          .get(Uri.parse(_url))
          .timeout(const Duration(seconds: 10)); // Timeout for slow networks

      if (response.statusCode == 200) {
        try {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData.map((data) => Post.fromJson(data)).toList();
        } catch (e) {
          throw Exception('Error parsing data: Invalid JSON format.');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on TimeoutException {
      throw Exception('Request timed out. Please try again.');
    } on FormatException {
      throw Exception('Invalid response format.');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
