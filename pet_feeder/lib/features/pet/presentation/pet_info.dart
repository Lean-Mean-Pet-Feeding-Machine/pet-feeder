import 'package:accordion/accordion.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:pet_feeder/features/all_data_provider.dart';
import 'package:pet_feeder/features/common/theme.dart';
import 'package:pet_feeder/features/common/thememode.dart';
import 'package:pet_feeder/features/loading/loading.dart';
import 'package:pet_feeder/features/pet/data/pet_provider.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import 'package:pet_feeder/features/pet/presentation/edit_pet_controller.dart';
import 'package:pet_feeder/features/user/domain/user.dart';
import '../domain/pet_db.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PetInfo extends ConsumerWidget {
  final Pet pet;

  const PetInfo({Key? key, required this.pet}) : super(key: key);

  static const String routeName = '/pet-info';

  static final FocusNode _weightTextBox = FocusNode();
  static final FocusNode _ageTextBox = FocusNode();
  static final FocusNode _scheduleTextBox = FocusNode();
  static final FocusNode _breedTextBox = FocusNode();
  static final _radioKey = GlobalKey<FormBuilderFieldState>();
  static var currentDate = DateTime.now();

  String getDate(double value) {
    return DateFormat('MM/dd/yy')
        .format(DateTime.fromMillisecondsSinceEpoch(value.toInt()))
        .toString();
  }

  double calculateIdealWeight(double bcsScore, List<double> weight) {
    double idealWeight =  bcsScore - 4;
    idealWeight = idealWeight * 10;
    idealWeight = idealWeight + 100;
    idealWeight = 100 / idealWeight;
    idealWeight = idealWeight * weight.last;
    return idealWeight;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
        data: (allData) => _build(
          context: context,
          // pets: allData.pets,
          pet: pet,
          // users: allData.users,
          ref: ref,
        ),
        error: (error, st) => Text(error.toString()),
        loading: () => Loading(),
    );
  }

  Widget _build(
      {
        required BuildContext context,
        required WidgetRef ref,
        required Pet pet,
        // required List<Pet> pets,
        // required List<User> users,
      }) {
    List<(double, DateTime)> weights = [];
    double idealWeight = 0;
    if (pet.weight.isNotEmpty && pet.bcsScore != null) {
      idealWeight = calculateIdealWeight(pet.bcsScore!, pet.weight);
    }

    print(idealWeight);
    List<FlSpot> spots = [];

    for (int i = 0; i < pet.weight.length; i++) {
      weights.add((pet.weight[i], DateTime.parse(pet.when[i])));
    }

    spots = weights
        .map((e) => FlSpot(e.$2.millisecondsSinceEpoch.toDouble(), e.$1))
        .toList();

    final currentThemeMode =
        ref.watch(themeModeProvider); // Watch the theme mode
    ref.watch(petDatabaseProvider);

    return Theme(
        data: currentThemeMode == ThemeModeOption.light
            ? lightTheme
            : darkTheme, // Apply appropriate theme based on the currentThemeMode
        child: Scaffold(
          appBar: AppBar(
            title: Text(pet.name),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                const SizedBox(height: 80.0),
                Column(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        pet.imagePath,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      pet.name,
                      style: const TextStyle(fontSize: 50),
                    ),
                  ],
                ),
                const SizedBox(height: 80.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Weight'),
                        Container(
                          width: 120,
                          height: 60,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(147, 3, 168, 244),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                              child: GestureDetector(
                            onLongPress: () {
                              FocusScope.of(context)
                                  .requestFocus(_weightTextBox);
                            },
                            child: AbsorbPointer(
                              child: ListTile(
                                title: FormBuilder(
                                  child: Center(
                                    child: FormBuilderTextField(
                                      focusNode: _weightTextBox,
                                      initialValue: weights.isNotEmpty ? weights.last.$1.toString() : 'Nope',
                                      name: 'weightForm',
                                      onSubmitted: (value) {
                                        List<double> tmpWeight = [...pet.weight];
                                        List<String> tmpWhen = [...pet.when];
                                        tmpWeight.add(double.parse(value!));
                                        tmpWhen.add(DateTime.now().toIso8601String());
                                        Pet tmpPet = Pet(
                                          id: pet.id,
                                          ownerId: pet.ownerId,
                                          name: pet.name,
                                          weight: tmpWeight,
                                          when: tmpWhen,
                                          age: pet.age,
                                          species: pet.species,
                                          imagePath: pet.imagePath,
                                          schedule: pet.schedule,
                                          breed: pet.breed,
                                        );
                                        ref.watch(editPetControllerProvider.notifier).updatePet(
                                            pet: tmpPet, onSuccess: () => print('updated weight')
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                        Text('Age'),
                        Container(
                          width: 120,
                          height: 60,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(193, 255, 172, 64),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onLongPress: () {
                              FocusScope.of(context).requestFocus(_ageTextBox);
                            },
                            child: Center(
                              child: Text(
                                  '${(currentDate.difference(DateTime.parse(pet.age)).inDays / 365).toStringAsFixed(2)}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Column(
                      children: [
                        Text("Breed"),
                        Container(
                          width: 120,
                          height: 60,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(147, 139, 195, 74),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                              child: GestureDetector(
                                  onLongPress: () {
                                    FocusScope.of(context)
                                        .requestFocus(_breedTextBox);
                                  },
                                  child: AbsorbPointer(
                                    child: FormBuilderTextField(
                                      focusNode: _breedTextBox,
                                      name: 'breed',
                                      initialValue: pet.breed ?? 'Nothing',
                                      onSubmitted: (value) {
                                        Pet tmpPet = Pet(
                                          id: pet.id,
                                          ownerId: pet.ownerId,
                                          name: pet.name,
                                          weight: pet.weight,
                                          when: pet.when,
                                          age: pet.age,
                                          species: pet.species,
                                          imagePath: pet.imagePath,
                                          schedule: pet.schedule,
                                          breed: value,
                                        );
                                        ref.watch(editPetControllerProvider.notifier).updatePet(
                                            pet: tmpPet, onSuccess: () => print('updated breed')
                                        );
                                      },
                                    ),
                                  ))),
                        ),
                        Text("Schedule"),
                        Container(
                          width: 120,
                          height: 60,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(171, 223, 64, 251),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                              child: GestureDetector(
                                  onLongPress: () {
                                    FocusScope.of(context)
                                        .requestFocus(_scheduleTextBox);
                                  },
                                  child: AbsorbPointer(
                                    child: FormBuilderDateTimePicker(
                                      onChanged: (value) {
                                        pet.schedule.insert(
                                            pet.schedule.length,
                                            DateFormat(DateFormat.HOUR24_MINUTE)
                                                .format(value as DateTime)
                                                .toString());
                                      },
                                      initialValue:
                                          pet.schedule.isNotEmpty ? 
                                          DateFormat(DateFormat.HOUR24_MINUTE)
                                              .parse(pet.schedule.last) 
                                      : DateTime(2023),
                                      name: 'schedule',
                                      focusNode: _scheduleTextBox,
                                      inputType: InputType.time,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ))),
                        ),
                        Container(
                          width: 0,
                          height: 0,
                          child: Opacity(
                            opacity: 0,
                            child: FormBuilderDateTimePicker(
                              onChanged: (val) {
                                Pet tmpPet = Pet(
                                  id: pet.id,
                                  ownerId: pet.ownerId,
                                  name: pet.name,
                                  weight: pet.weight,
                                  when: pet.when,
                                  age: val!.toIso8601String(),
                                  species: pet.species,
                                  imagePath: pet.imagePath,
                                  schedule: pet.schedule,
                                  breed: pet.breed,
                                );
                                ref.watch(editPetControllerProvider.notifier).updatePet(
                                    pet: tmpPet, onSuccess: () => print('updated')
                                );
                              },
                              inputType: InputType.date,
                              focusNode: _ageTextBox,
                              name: 'age',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                weights.isNotEmpty ?
                SizedBox(
                  width: 100,
                  height: 250,
                  child: LineChart(LineChartData(
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                       HorizontalLine(
                           y: idealWeight * 1.10,
                           color: Colors.red
                      ),
                        HorizontalLine(
                            y: idealWeight * 0.9,
                            color: Colors.green
                        )
                      ]
                    ),
                      minX: spots.map((e) => e.x).min - 340000000,
                      maxX: currentDate.millisecondsSinceEpoch.toDouble(),
                      minY: (spots.map((e) => e.y).min - 5).floorToDouble(),
                      maxY: (spots.map((e) => e.y).max + 5).floorToDouble(),
                      titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  reservedSize: 12, showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  reservedSize: 40,
                                  showTitles: true,
                                  interval: (currentDate.millisecondsSinceEpoch
                                              .toDouble() -
                                          spots.map((e) => e.x).min) /
                                      spots.length,
                                  getTitlesWidget: (value, meta) {
                                    if (value ==
                                        spots.map((e) => e.x).min - 340000000) {
                                      return Text('');
                                    }
                                    return Text(getDate(value));
                                  }))),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: false,
                        )
                      ])),
                ) : SizedBox(),
                Accordion(
                    children: [
                      AccordionSection(
                        isOpen: false,
                        header: Center(
                          child: Text(
                            'Body condition score',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        content: Column(
                          children: [
                            Image.asset('assets/images/bcs/bcs_dog_chart.png'),
                            FormBuilder(
                              child: Column(
                                children: [
                                  FormBuilderRadioGroup(
                                    key: _radioKey,
                                    validator: FormBuilderValidators.required(),
                                    name: 'BCS',
                                    options: [
                                      1,
                                      2,
                                      3,
                                      4,
                                      5,
                                      6,
                                      7,
                                      8,
                                      9,
                                    ].map((e) => FormBuilderFieldOption(value: e)).toList()
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      pet.idealWeight ?? 0 * 0.9;
                                      if (_radioKey.currentState!.validate()) {
                                        print(_radioKey.currentState?.value);
                                        idealWeight = pet.calculateIdealWeight(_radioKey.currentState?.value);
                                        Pet tmpPet = Pet(
                                          id: pet.id,
                                          ownerId: pet.ownerId,
                                          name: pet.name,
                                          weight: pet.weight,
                                          when: pet.when,
                                          age: pet.age,
                                          species: pet.species,
                                          imagePath: pet.imagePath,
                                          schedule: pet.schedule,
                                          breed: pet.breed,
                                          bcsScore: _radioKey.currentState?.value,
                                        );
                                        ref.watch(editPetControllerProvider.notifier).updatePet(
                                            pet: tmpPet, onSuccess: () => print('updated bcs score')
                                        );

                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              ),

                            ),
                          ],
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ));
  }
}
