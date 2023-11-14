import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/food_item/data/food_item_provider.dart';
import 'package:pet_feeder/features/food_item/domain/food_item_db.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

// final List<String> images = [
//   'assets/images/dog_food/dog_food1.jpg',
//   'assets/images/dog_food/dog_food2.jpg',
//   'assets/images/dog_food/dog_food3.jpg',
// ];

// final List<String> petIds = [
//   'pet-001',
//   'pet-002',
//   'pet-003',
//   'pet-004',
// ];

// const currentPet = 'pet-002';

// class FoodCatalogPage extends ConsumerWidget {
//   final List<Text> nutrientInfo = [
//     const Text('Has too much carbohydrates'),
//     const Text('High in sodium'),
//     const Text('Good amount of protein'),
//     const Text('fdkfjl'),
//   ];

//   List<Text> nutientInfo(FoodItemData foodItemData) {
//     List<Text> list = [];
//     foodItemData.nutrients?.forEach((key, value) {
//       list.add(Text('$key: ${value.truncate()}'));
//     });
//     return list;
//   }

//   Widget info(FoodItemData foodItem) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(50.0),
//           child: Image(
//             width: 100,
//             height: 200,
//             image: AssetImage(foodItem.imagePath),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsetsDirectional.all(50.0),
//           child: Column(
//             children: nutientInfo(foodItem),
//           ),
//         )
//       ],
//     );
//   }

//   final List<Widget> recommendations = images
//       .map((imagePath) => Container(
//             margin: EdgeInsets.all(6.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               image: DecorationImage(
//                 image: AssetImage(imagePath),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ))
//       .toList();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final foodItemDB = ref.watch(foodItemDBProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Food Catalog'),
//         automaticallyImplyLeading: false,
//       ),
//       body: ListView(
//         children: [
//           Column(
//             children: <Widget>[
//               info(foodItemDB.getFoodItemsForPet(currentPet).first)
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Recommendation'),
//             ],
//           ),
//           CarouselSlider(
//             items: recommendations,
// //Slider Container properties
//             options: CarouselOptions(
//               height: 400,
//               enlargeCenterPage: true,
//               autoPlay: false,
//               aspectRatio: 16 / 9,
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enableInfiniteScroll: false,
//               autoPlayAnimationDuration: Duration(milliseconds: 800),
//               viewportFraction: 0.4,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class FoodCatalogPage extends StatefulWidget {
  @override
  _FoodCatalogPageState createState() => _FoodCatalogPageState();
}

class _FoodCatalogPageState extends State<FoodCatalogPage> {
  late Future<File?> _imageFuture;
  bool _imageSelected = false;

  final List<String> recommendations = [
    'assets/images/dog_food/dog_food1.jpg',
    'assets/images/dog_food/dog_food2.jpg',
    'assets/images/dog_food/dog_food3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _imageFuture = pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Catalog'),
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _imageFuture = pickImage();
                  });
                },
                child: Text('Select Image'),
              ),
              FutureBuilder<File?>(
                future: _imageFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _imageSelected = snapshot.data != null;
                  }

                  return Visibility(
                    visible: _imageSelected,
                    child: Column(
                      children: [
                        if (_imageSelected && snapshot.data != null)
                          Image.file(
                            snapshot.data!,
                            height: MediaQuery.of(context).size.height * 0.4,
                          )
                        else
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            color: Colors.grey,
                            child: Center(
                              child: Text('No image selected'),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () async {
                            if (snapshot.data != null) {
                              await readTextFromImage(snapshot.data!);
                            }
                          },
                          child: Text('Extract Text'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Recommendation'),
            ],
          ),
          CarouselSlider(
            items: recommendations
                .map((imagePath) => Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 400,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  Future<void> readTextFromImage(File imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognisedText =
          await textRecognizer.processImage(inputImage);
      String text = recognisedText.text;

      // Filter lines containing "Calories," "Protein," and "Fat"
      List<String> relevantLines = text
          .split('\n')
          .where((line) =>
              line.contains('Calories') ||
              line.contains('Protein') ||
              line.contains('Fat'))
          .toList();

      // Display the relevant lines in a dialog.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Extracted Nutritional Information:'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: relevantLines
                  .map((line) => Text(
                        line,
                        style: TextStyle(fontSize: 16),
                      ))
                  .toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error during text recognition: $e');
    } finally {
      textRecognizer.close();
    }
  }
}
