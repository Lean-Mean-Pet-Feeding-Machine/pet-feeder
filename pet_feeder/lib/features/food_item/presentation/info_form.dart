import 'package:flutter/material.dart';

class NutritionalInfoForm extends StatefulWidget {
  final double protein;
  final double calories;
  final double fat;

  NutritionalInfoForm({
    required this.protein,
    required this.calories,
    required this.fat,
  });

  @override
  _NutritionalInfoFormState createState() => _NutritionalInfoFormState();
}

class _NutritionalInfoFormState extends State<NutritionalInfoForm> {
  late TextEditingController proteinController;
  late TextEditingController caloriesController;
  late TextEditingController fatController;
  String selectedPet = 'Spot'; // Default pet

  @override
  void initState() {
    super.initState();
    proteinController = TextEditingController(text: widget.protein.toString());
    caloriesController =
        TextEditingController(text: widget.calories.toString());
    fatController = TextEditingController(text: widget.fat.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutritional Information Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pet:'),
            DropdownButton<String>(
              value: selectedPet,
              items: ['Spot', 'Mittens']
                  .map((pet) => DropdownMenuItem<String>(
                        value: pet,
                        child: Text(pet),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPet = value!;
                });
              },
            ),
            SizedBox(height: 16),
            Text('Protein:'),
            TextFormField(controller: proteinController),
            SizedBox(height: 16),
            Text('Calories:'),
            TextFormField(controller: caloriesController),
            SizedBox(height: 16),
            Text('Fat:'),
            TextFormField(controller: fatController),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Process the form data (save to database, etc.)
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
