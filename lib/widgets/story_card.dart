import 'package:flutter/material.dart';
import '../models/story_model.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 3),
          ),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(story.profilePic),
          ),
        ),
        const SizedBox(height: 5),
        Text(story.username, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
