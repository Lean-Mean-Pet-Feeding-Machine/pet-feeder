import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pet_feeder/features/user/data/user_provider.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';

class SignUpPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDB = ref.watch(userDBProvider);

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            print(_formKey.currentState?.value);
                            print(_formKey.currentState?.value['password']);
                            userDB.addUser(UserData(
                              id: 'user-12',
                              email: _formKey.currentState?.value['email'],
                              userName:
                                  _formKey.currentState?.value['username'],
                              password:
                                  _formKey.currentState?.value['password'],
                            ));
                            Navigator.pushReplacementNamed(context, '/navbar');
                          }
                        },
                        child: Text('Submit')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        child: Text('Clear')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('Go Back'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
