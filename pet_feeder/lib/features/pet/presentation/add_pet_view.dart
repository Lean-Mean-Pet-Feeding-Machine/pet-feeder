import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pet_feeder/features/all_data_provider.dart';
import 'package:pet_feeder/features/loading/loading.dart';
import 'package:pet_feeder/features/pet/data/pet_provider.dart';
import 'dart:math';

import '../domain/pet.dart';

class AddPetView extends ConsumerWidget {
  AddPetView({Key? key}) : super(key: key);

  static const routeName = '/addPetView';
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameField = GlobalKey<FormBuilderFieldState>();
  final _imagePathField = GlobalKey<FormBuilderFieldState>();
  final _breedField = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
            context: context,
            currentUserID: allData.currentUserID,
            pets: allData.pets,
            ref: ref),
        loading: () => const Loading(),
        error: (error, stacktrace) => Text(stacktrace.toString()));
  }

  Widget _build({
    required BuildContext context,
    required String? currentUserID,
    required List<Pet> pets,
    required WidgetRef ref,
  }) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 30.0),
            Container(
              height: 200.0,
              child: Image.asset('assets/images/dogncat.png'),
            ),
            const Column(
              children: <Widget>[
                Text(
                  'Add Your Pet:',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(labelText: 'name'),
                  ),
                  FormBuilderTextField(
                    name: 'breed',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(labelText: 'Breed'),
                  ),
                  FormBuilderDateTimePicker(
                    name: 'age',
                    decoration: InputDecoration(labelText: 'Age'),
                  ),
                  FormBuilderTextField(
                    name: 'species',
                    decoration: InputDecoration(labelText: 'Species'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'schedule',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration:
                        InputDecoration(labelText: 'Feeding Schedule (HH:mm)'),
                  ),
                  FormBuilderTextField(
                    name: 'imagePath',
                    decoration: InputDecoration(labelText: 'Image'),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: Text('Go Back'),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        child: Text('Clear'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.saveAndValidate()) {
                          try {
                            // Convert the Firebase Pet to Pet
                            Pet pet = Pet(
                              id: '${Random().nextInt(92233720)}', // magic random ID
                              ownerId: currentUserID!,
                              name: _formKey.currentState?.value['name'],
                              weight: [],
                              when: [],
                              age: _formKey.currentState!.value['age']
                                  .toString(),
                              species: _formKey.currentState?.value['species'],
                              imagePath:
                                  _formKey.currentState?.value['imagePath'],
                              schedule: [
                                _formKey.currentState?.value['schedule'] ?? ''
                              ],
                            );
                            await ref
                                .read(petDatabaseProvider)
                                .setPetDataDelayed(pet);

                            // delay before navigating to allow time for data update
                            await Future.delayed(
                                const Duration(milliseconds: 2000));

                            // Navigate to the next screen
                            Navigator.pushReplacementNamed(context, '/navbar');
                          } catch (e) {
                            print('Error during sign up: $e');
                          }
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
