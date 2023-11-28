
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pet_feeder/features/all_data_provider.dart';
import 'package:pet_feeder/features/loading/loading.dart';
import 'package:pet_feeder/features/pet/data/pet_provider.dart';
import 'package:pet_feeder/features/user/data/user_providers.dart';

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
                  'Please register:',
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
                    name: 'username',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  FormBuilderTextField(
                    name: 'email',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  FormBuilderTextField(
                    name: 'confirmPassword',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                  ),
                  FormBuilderTextField(
                    name: 'zipcode',
                    validator: FormBuilderValidators.compose([]),
                    decoration: InputDecoration(labelText: 'Zipcode'),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/login');
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
                          print(_formKey.currentState?.value);
                          print(_formKey.currentState?.value['password']);

                          // Register user with Firebase Authentication
                          try {
                            // Convert the Firebase User to UserData
                            Pet pet = Pet(
                                id: '123',
                                ownerId: currentUserID!,
                                name: 'jeff',
                                weight: [],
                                when: [],
                                age: '2019-11-09T00:00:00Z',
                                species: 'Dog',
                                imagePath: 'cat2.png',
                                schedule: []
                            );

                            // Add user to userDB
                            ref.read(petDatabaseProvider).setPetData(pet);

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