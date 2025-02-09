import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key}); // ✅ No need to pass postId

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Post? _post;
  bool _isLoading = true;
  bool _isLiked = false;
  int _likes = 0;

  @override
  void initState() {
    super.initState();
    _fetchPostData();
  }

  // ✅ Fetch the latest post data from API
  Future<void> _fetchPostData() async {
    try {
      Post post = await ApiService.fetchPost(); // ✅ Fetch Single Post API
      setState(() {
        _post = post;
        _likes = post.likes;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching post: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likes = _isLiked ? _likes + 1 : _likes - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Details")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _post == null
          ? const Center(child: Text("Failed to load post"))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Post Header (User Info)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(_post!.profilePic),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _post!.username,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _post!.postDate ?? "", // ✅ Show date if available
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ Post Image
            Image.network(
              _post!.imageUrl,
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 10),

            // ✅ Like & Comment Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : Colors.black,
                    ),
                    onPressed: _toggleLike,
                  ),
                  Text("$_likes likes", style: const TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(width: 15),

                  const Icon(Icons.comment_outlined),
                  Text(" ${_post!.comments} comments", style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // ✅ Post Caption & Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_post!.postText != null)
                    Text(
                      _post!.postText!,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 5),
                  Text(
                    _post!.caption,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Comments Section (Future Expansion)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "View all ${_post!.comments} comments",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
