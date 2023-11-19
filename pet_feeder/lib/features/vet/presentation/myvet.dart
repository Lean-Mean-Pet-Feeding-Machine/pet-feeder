import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/authentication/presentation/login.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import '../domain/vet_db.dart';

class MyVetMessagingPage extends StatefulWidget {
  @override
  _MyVetMessagingPageState createState() => _MyVetMessagingPageState();
}

class _MyVetMessagingPageState extends State<MyVetMessagingPage> {
  // Example messages
  /*TODO Vet messages from real vet*/
  final List<Message> messages = [
    Message(text: "Hi, how can I help you?", isUser: false),
    Message(text: "Hello!", isUser: true),
    Message(text: "I have a question about my pet.", isUser: true),
    Message(text: "Sure, ask away.", isUser: false),
  ];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final currentUser = ref.watch(authProvider);
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Vet'),
        ),
        drawer: CustomDrawer(
            // currentUser: currentUser,
            ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildMessage(message);
                },
              ),
            ),
            _buildInputField(),
          ],
        ),
      );
    });
  }

  Widget _buildMessage(Message message) {
    return Row(
      mainAxisAlignment:
          message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isUser)
          Container(
            width: 40.0,
            height: 35.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey, // Icon background color
            ),
            child: const Center(
              child: Icon(
                Icons.person, // Replace with desired icon
                color: Colors.white, // Icon color
                size: 24.0, // Icon size
              ),
            ),
          ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: message.isUser ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message.text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        if (message.isUser)
          Container(
            width: 40.0,
            height: 35.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // Icon background color
            ),
            child: const Center(
              child: Icon(
                Icons.person, // Replace with your desired icon
                color: Colors.white, // Icon color
                size: 24.0, // Icon size
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Type your message here...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final userMessage = _textEditingController.text;
              if (userMessage.isNotEmpty) {
                // Add the user's message to the list
                messages.add(Message(text: userMessage, isUser: true));
                _textEditingController.clear();
                setState(() {}); // Update the UI
              }
            },
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({
    required this.text,
    required this.isUser,
  });
}
