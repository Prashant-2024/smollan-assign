import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/feed_provider.dart';
import '../widgets/story_card.dart';
import '../widgets/post_card.dart';
import 'PostPage.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FeedProvider>(context, listen: false).fetchFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final feedProvider = Provider.of<FeedProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instagram",
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: feedProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // Stories Section
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: feedProvider.stories.length,
                      itemBuilder: (context, index) {
                        return StoryCard(story: feedProvider.stories[index]);
                      },
                    ),
                  ),
                ),

                // Posts Section
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PostPage(),
                            ),
                          );
                        },
                        child: PostCard(post: feedProvider.posts[index]),
                      );
                    },
                    childCount: feedProvider.posts.length,
                  ),
                ),
              ],
            ),
    );
  }
}
