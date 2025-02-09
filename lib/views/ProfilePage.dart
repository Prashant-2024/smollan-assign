import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../models/profile_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          if (profileProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (profileProvider.errorMessage != null) {
            return Center(child: Text(profileProvider.errorMessage!));
          } else if (profileProvider.profile == null) {
            return const Center(child: Text("No profile data available"));
          }

          Profile profile = profileProvider.profile!;
          return RefreshIndicator(
            onRefresh: () => profileProvider.refreshProfile(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Profile Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(profile.profilePic),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.username,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  _buildStatColumn("Posts", profile.posts),
                                  _buildStatColumn("Followers", profile.followers),
                                  _buildStatColumn("Following", profile.following),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Bio Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (profile.bio.designation.isNotEmpty)
                          Text(
                            profile.bio.designation,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        if (profile.bio.description.isNotEmpty)
                          Text(
                            profile.bio.description,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                        if (profile.bio.website.isNotEmpty)
                          Text(
                            profile.bio.website,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  // Highlights Section
                  if (profile.highlights.isNotEmpty)
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: profile.highlights
                            .map(
                              (highlight) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(highlight.cover),
                                ),
                                const SizedBox(height: 4),
                                Text(highlight.title,
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),

                  // Gallery Grid
                  if (profile.gallery.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profile.gallery.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Image.network(
                          profile.gallery[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatColumn(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
