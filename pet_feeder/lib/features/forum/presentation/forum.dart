import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/authentication/presentation/login.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import 'package:pet_feeder/features/common/theme.dart';
import 'package:pet_feeder/features/common/thememode.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final currentUser = ref.watch(authProvider);

      return Theme(
        data: ThemeModeOption.light == ThemeModeOption.light
            ? lightTheme
            : darkTheme,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Forum'),
          ),
          drawer: CustomDrawer(),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    _performSearch(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 8.0),
                        Text(
                          'Search forums...',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: fakePosts.length,
                  itemBuilder: (context, index) {
                    final post = fakePosts[index];
                    return PostItem(post, index == 0);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _performSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: PostSearchDelegate(fakePosts),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  final bool showThumbsUp;

  PostItem(this.post, this.showThumbsUp);

  @override
  Widget build(BuildContext context) {
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
                    label: Text('#$tag'),
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
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  // Handle upvote functionality here
                },
              ),
              Text('0'),
              IconButton(
                icon: Icon(Icons.arrow_downward),
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
                Icons.thumb_up,
                color: Colors.blue,
                size: 30.0,
              ),
            ),
          ),
      ],
    );
  }
}

class PostSearchDelegate extends SearchDelegate<List<Post>> {
  final List<Post> allPosts;

  PostSearchDelegate(this.allPosts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = searchPosts(query);
    return _buildSearchResults(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = searchPosts(query);
    return _buildSearchResults(results);
  }

  Widget _buildSearchResults(List<Post> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final post = results[index];
        return PostItem(post, index == 0);
      },
    );
  }

  List<Post> searchPosts(String query) {
    return allPosts.where((post) {
      // Check if the post's text contains the search query
      return post.text.toLowerCase().contains(query.toLowerCase());
    }).toList();
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

// Sample data
List<Post> fakePosts = [
  Post(
    username: 'PetLover123',
    text:
        'My dog is overweight, and I need advice on creating a weight loss diet plan. Any tips?',
    tags: ['dog', 'pet', 'weight-loss', 'diet'],
  ),
  Post(
    username: 'Mark',
    text:
        'Looking for low-calorie cat treats. Any recommendations to keep my cat healthy?',
    tags: ['cat', 'pet', 'treats', 'nutrition'],
  ),
  Post(
    username: 'CatMom4ever',
    text:
        'I have 3 cats, two are severely overweight and one is diabetic and I need to find a way to feed them separately to keep track of their health. Does anyone have any tips?',
    tags: ['dog', 'pet', 'exercise', 'fitness'],
  ),
  Post(
    username: 'Elon',
    text:
        'My cat refuses to eat the prescribed diet for weight management. Any suggestions to make it more appealing?',
    tags: ['cat', 'pet', 'obesity', 'diet'],
  ),
  Post(
    username: 'Newbie',
    text:
        "Just adopted a puppy! What's the best puppy food for healthy growth and development?",
    tags: ['dog', 'pet', 'puppy', 'nutrition'],
  ),
  Post(
    username: 'SeniorPetCare',
    text:
        'Tips on caring for senior dogs and cats, especially regarding their diet and exercise routine.',
    tags: ['dog', 'cat', 'senior-pet', 'care'],
  ),
  Post(
    username: 'John2',
    text: 'What food brands do you recommend for a 6 month old puppy?',
    tags: ['dog'],
  ),
];
