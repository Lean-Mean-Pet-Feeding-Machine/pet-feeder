import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PetInfo extends StatefulWidget {
  static const String routeName = '/pet-info';
  const PetInfo({Key? key}) : super(key: key);

  @override
  _PetInfoState createState() => _PetInfoState();
}

class _PetInfoState extends State<PetInfo> {
  // TODO: Add text editing controllers (101)
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();
  final _alarmController = TextEditingController();
  final _name = 'jeff';
  final _weightData = [12, 13, 13, 15, 16, 15];
  List<FlSpot> spot = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0.0; i < 12; i++) {
      spot.add(FlSpot(i, i * 5));
    }
    print(spot.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet name'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/main_logo.png'),
                const SizedBox(height: 12.0),
                Text(
                  _name,
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
                    SizedBox(
                      width: 120,
                      height: 60,
                      child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          controller: _weightController,
                          decoration: const InputDecoration(
                            fillColor: Colors.lightBlue,
                            filled: true,
                            labelText: 'Weight',
                          )),
                    ),
                    SizedBox(
                      width: 120,
                      height: 60,
                      child: TextField(
                        controller: _breedController,
                        decoration: const InputDecoration(
                          fillColor: Colors.lightGreen,
                          filled: true,
                          labelText: 'Breed',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: 120,
                      height: 60,
                      child: TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          fillColor: Colors.orangeAccent,
                          filled: true,
                          labelText: 'Age',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 60,
                      child: TextField(
                          controller: _alarmController,
                          decoration: const InputDecoration(
                            fillColor: Colors.purpleAccent,
                            filled: true,
                            labelText: 'Alarm',
                          )),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 100,
              height: 250,
              child: LineChart(LineChartData(lineBarsData: [
                LineChartBarData(
                  spots: spot,
                  isCurved: false,
                )
              ])),
            ),
          ],
        ),
      ),
    );
  }
}
