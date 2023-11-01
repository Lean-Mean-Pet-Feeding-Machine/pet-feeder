import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/food_item/data/food_item_provider.dart';
import 'package:pet_feeder/features/food_item/domain/food_item_db.dart';

final List<String> images = [
  'assets/images/dog_food/dog_food1.jpg',
  'assets/images/dog_food/dog_food2.jpg',
  'assets/images/dog_food/dog_food3.jpg',
];

final List<String> petIds = [
  'pet-001',
  'pet-002',
  'pet-003',
  'pet-004',
];

const currentPet = 'pet-002';

class FoodCatalogPage extends ConsumerWidget {
  final List<Text> nutrientInfo = [
    const Text('Has too much carbohydrates'),
    const Text('High in sodium'),
    const Text('Good amount of protein'),
    const Text('fdkfjl'),
  ];

  List<Text> nutientInfo(FoodItemData foodItemData) {
    List<Text> list = [];
    foodItemData.nutrients?.forEach((key, value) {
      list.add(Text('$key: ${value.truncate()}'));
    });
    return list;
  }

  Widget info(FoodItemData foodItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image(
            width: 100,
            height: 200,
            image: AssetImage(foodItem.imagePath),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.all(50.0),
          child: Column(
            children: nutientInfo(foodItem),
          ),
        )
      ],
    );
  }

  final List<Widget> recommendations = images
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
      .toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItemDB = ref.watch(foodItemDBProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Catalog'),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              info(foodItemDB.getFoodItemsForPet(currentPet).first)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Recommendation'),
            ],
          ),
          CarouselSlider(
            items: recommendations,
//Slider Container properties
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
}
