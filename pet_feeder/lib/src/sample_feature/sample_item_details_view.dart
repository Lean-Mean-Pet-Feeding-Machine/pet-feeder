import 'package:flutter/material.dart';

class SampleItemDetailsView extends StatelessWidget {
  static const String routeName = '/sampleItemDetails';

  const SampleItemDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display your content here
            Text('More Information Here'),
          ],
        ),
      ),
    );
  }
}
