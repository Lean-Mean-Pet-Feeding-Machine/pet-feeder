import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> images = [
  'assets/images/dog_food/dog_food1.jpg',
  'assets/images/dog_food/dog_food2.jpg',
  'assets/images/dog_food/dog_food3.jpg',
];

class FoodCatalogPage extends StatefulWidget {
  const FoodCatalogPage({super.key});

  @override
  _FoodCatalogPageState createState() => _FoodCatalogPageState();
}

class _FoodCatalogPageState extends State<FoodCatalogPage> {

  final List<Text> nutrientInfo = [
    const Text('Has too much carbohydrates'),
    const Text('High in sodium'),
    const Text('Good amount of protein'),
    const Text('Good calcium'),
  ];


  final List<Widget> recommendations = images.map((path) => Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(path),
                    fit: BoxFit.cover,
                  ),
                ),
              )).toList();

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image(
                      image: AssetImage('assets/images/dog_food/food_label.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(50.0),

                    child: Column(
                      children: nutrientInfo,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Recommendation'),
                ],
              )
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
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}


