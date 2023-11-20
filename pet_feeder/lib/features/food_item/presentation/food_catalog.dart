import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/food_item/data/food_item_provider.dart';
import 'package:pet_feeder/features/food_item/domain/food_item_db.dart';
import 'package:pet_feeder/features/authentication/presentation/login.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'info_form.dart';

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
    return Consumer(builder: (context, ref, child) {
      final currentUser = ref.watch(authProvider);
      return Scaffold(
        appBar: AppBar(
          title: Text('Food Catalog'),
        ),
        drawer: CustomDrawer(),
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
    });
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

      // Extract protein, calories, and fat from the text
      double protein = extractNutrientValue(text, 'Protein');
      double calories = extractNutrientValue(text, 'Calories');
      double fat = extractNutrientValue(text, 'Fat');

      // Navigate to the form with extracted values
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NutritionalInfoForm(
            protein: protein,
            calories: calories,
            fat: fat,
          ),
        ),
      );
    } catch (e) {
      print('Error during text recognition: $e');
    } finally {
      textRecognizer.close();
    }
  }

  // Helper function to extract nutrient values from text
  double extractNutrientValue(String text, String nutrient) {
    RegExp regex = RegExp('$nutrient[\\s]*([0-9]+)');
    Match? match = regex.firstMatch(text);
    return match != null ? double.parse(match.group(1)!) : 0.0;
  }
}
