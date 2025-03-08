import 'package:flutter/material.dart';
import 'package:zylentrix_api_task/services/api_services.dart';
import '../models/post_model.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  Map<int, List<Post>> groupedPosts = {}; // Stores posts grouped by userId
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final List<Post> posts =
          await ApiService().fetchPosts(); //Using API service

      // Grouping posts by userId
      Map<int, List<Post>> grouped = {};
      for (var post in posts) {
        grouped.putIfAbsent(post.userId, () => []).add(post);
      }

      setState(() {
        groupedPosts = grouped;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching data: $error';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Posts Grouped by User'),
        centerTitle: true,
        backgroundColor: Colors.orange[400],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: groupedPosts.length,
                  itemBuilder: (context, index) {
                    int userId = groupedPosts.keys.elementAt(index);
                    List<Post> userPosts = groupedPosts[userId]!;

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'User: $userId',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        children:
                            userPosts.map((post) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SizedBox(
                                  width:
                                      double.infinity, // Ensures width is full
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Title:', // Label for Title
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          post.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          'Description:', // Label for Description
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          post.body,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
