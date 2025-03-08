import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  static const String _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse(_url))
          .timeout(const Duration(seconds: 10)); //Timeout for slow networks

      if (response.statusCode == 200) {
        try {
          List<dynamic> jsonData = json.decode(response.body);
          return jsonData.map((data) => Post.fromJson(data)).toList();
        } catch (e) {
          throw Exception('Error parsing data: $e'); //Parsing issue
        }
      } else {
        throw Exception('Server error: ${response.statusCode}'); //Server error
      }
    } catch (e) {
      throw Exception('Network error: $e'); //General error (e.g., no internet)
    }
  }
}
