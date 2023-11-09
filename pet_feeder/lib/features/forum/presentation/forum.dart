import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search forums...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search functionality here
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fakePosts.length,
              itemBuilder: (context, index) {
                final post = fakePosts[index];
                return _buildPostItem(
                    post, index == 0); // Pass true for the first post
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem(Post post, bool showThumbsUp) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.person), // User icon
                  SizedBox(width: 8.0),
                  Text(post.username), // Username
                ],
              ),
              SizedBox(height: 8.0),
              Text(post.text), // Post content
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: post.tags.map((tag) {
                  return Chip(
                    label: Text('#$tag'), // Tag
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_upward), // Upvote button
                onPressed: () {
                  // Handle upvote functionality here
                },
              ),
              Text(
                  '0'), // Upvote count (you can replace it with the actual count)
              IconButton(
                icon: Icon(Icons.arrow_downward), // Downvote button
                onPressed: () {
                  // Handle downvote functionality here
                },
              ),
            ],
          ),
        ),
        if (showThumbsUp)
          Positioned(
            bottom: 18.0,
            right: 20.0,
            child: Tooltip(
              message: 'Vet Approved',
              child: Icon(
                Icons.thumb_up, // Thumbs up icon
                color: Colors.blue,
                size: 30.0,
              ),
            ),
          ),
      ],
    );
  }
}

class Post {
  final String username;
  final String text;
  final List<String> tags;

  Post({
    required this.username,
    required this.text,
    required this.tags,
  });
}

// Sample data for testing
List<Post> fakePosts = [
  Post(
      username: 'User1',
      text: 'This is a post about dogs.',
      tags: ['dog', 'pet', 'breed']),
  Post(
      username: 'User2',
      text: 'Looking for advice on dog care.',
      tags: ['dog', 'pet', 'care']),
  Post(
      username: 'User3',
      text: "How do I know my dog's breed??",
      tags: ['breed', 'pet']),
];
