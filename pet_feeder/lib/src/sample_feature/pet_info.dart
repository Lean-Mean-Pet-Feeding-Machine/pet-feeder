import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../data_model/pet_db.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:pet_feeder/theme.dart';
import 'package:pet_feeder/thememode.dart';

class PetInfo extends ConsumerWidget {
  final PetData pet;

  const PetInfo({Key? key, required this.pet}) : super(key: key);

  static const String routeName = '/pet-info';

  static final _weightController = TextEditingController();
  static FocusNode _weightTextBox = FocusNode();
  static FocusNode _ageTextBox = FocusNode();
  static FocusNode _scheduleTextBox = FocusNode();
  static FocusNode _breedTextBox = FocusNode();
  static var currentDate = DateTime.now();
  static List<FlSpot> spots = [];

  String getDate(double value) {
    return DateFormat('MM/dd/yy')
        .format(DateTime.fromMillisecondsSinceEpoch(value.toInt()))
        .toString();
  }

  void printSpots() {
    spots.forEach((element) {
      print(element.toString());
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    spots = pet.weight
        .map((e) => FlSpot(e.$2.millisecondsSinceEpoch.toDouble(), e.$1))
        .toList();
    final currentThemeMode =
        ref.watch(themeModeProvider); // Watch the theme mode

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
                                      initialValue:
                                          pet.weight.last.$1.toString(),
                                      name: 'weightForm',
                                      onSubmitted: (val) {
                                        pet.weight.insert(pet.weight.length, (
                                          double.parse(val.toString()),
                                          currentDate
                                        ));
                                        print(pet.weight.last.toString());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                        const SizedBox(height: 5.0),
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
                                  '${(currentDate.difference(pet.age).inDays / 365).toStringAsFixed(2)}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      children: [
                        const SizedBox(height: 12.0),
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
                                        pet.breed = value;
                                      },
                                    ),
                                  ))),
                        ),
                        const SizedBox(height: 12.0),
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
                                        print(pet.schedule.toString());
                                      },
                                      initialValue:
                                          DateFormat(DateFormat.HOUR24_MINUTE)
                                              .parse(pet.schedule.last),
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
                                pet.age = val as DateTime;
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
                SizedBox(
                  width: 100,
                  height: 250,
                  child: LineChart(LineChartData(
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
                ),
              ],
            ),
          ),
        ));
  }
}
