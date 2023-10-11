import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../data_model/pet_db.dart';

//Commented out to test data model
// class PetInfo extends StatefulWidget {
//   static const String routeName = '/pet-info';
//   const PetInfo({Key? key}) : super(key: key);

//   @override
//   _PetInfoState createState() => _PetInfoState();
// }

// class _PetInfoState extends State<PetInfo> {
//   // TODO: Add text editing controllers (101)
//   final _weightController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _breedController = TextEditingController();
//   final _alarmController = TextEditingController();
//   final _name = 'jeff';
//   final _weightData = [12, 13, 13, 15, 16, 15];
//   List<FlSpot> spot = [];

//   @override
//   Widget build(BuildContext context) {
//     for (var i = 0.0; i < 12; i++) {
//       spot.add(FlSpot(i, i * 5));
//     }
//     print(spot.length);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pet name'),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           children: <Widget>[
//             const SizedBox(height: 80.0),
//             Column(
//               children: <Widget>[
//                 ClipOval(
//                   child: Image.asset(
//                     'assets/images/main_logo.png',
//                     width: 200, // Adjust the width as needed
//                     height: 200, // Adjust the height as needed
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 12.0),
//                 Text(
//                   _name,
//                   style: const TextStyle(fontSize: 50),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 80.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     SizedBox(
//                       width: 120,
//                       height: 60,
//                       child: TextField(
//                           style: const TextStyle(
//                             color: Colors.black,
//                           ),
//                           controller: _weightController,
//                           decoration: const InputDecoration(
//                             fillColor: Color.fromARGB(147, 3, 168, 244),
//                             filled: true,
//                             labelText: 'Weight',
//                           )),
//                     ),
//                     SizedBox(
//                       width: 120,
//                       height: 60,
//                       child: TextField(
//                         controller: _breedController,
//                         decoration: const InputDecoration(
//                           fillColor: Color.fromARGB(147, 139, 195, 74),
//                           filled: true,
//                           labelText: 'Breed',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 50,
//                 ),
//                 Column(
//                   children: [
//                     const SizedBox(height: 12.0),
//                     SizedBox(
//                       width: 120,
//                       height: 60,
//                       child: TextField(
//                         controller: _ageController,
//                         decoration: const InputDecoration(
//                           fillColor: Color.fromARGB(193, 255, 172, 64),
//                           filled: true,
//                           labelText: 'Age',
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 120,
//                       height: 60,
//                       child: TextField(
//                           controller: _alarmController,
//                           decoration: const InputDecoration(
//                             fillColor: Color.fromARGB(171, 223, 64, 251),
//                             filled: true,
//                             labelText: 'Alarm',
//                           )),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               width: 100,
//               height: 250,
//               child: LineChart(LineChartData(lineBarsData: [
//                 LineChartBarData(
//                   spots: spot,
//                   isCurved: false,
//                 )
//               ])),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class PetInfo extends StatelessWidget {
  final PetData pet;

  const PetInfo({Key? key, required this.pet}) : super(key: key);

  static const String routeName = '/pet-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Container(
                      width: 120,
                      height: 60,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(147, 3, 168, 244),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Weight: ${pet.weight}',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      width: 120,
                      height: 60,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(193, 255, 172, 64),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Age: ${pet.age}',
                          style: TextStyle(fontSize: 15, color: Colors.black),
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
                        child: Text(
                          'Breed: ${pet.breed}',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
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
                        child: Text(
                          'Alarm: ${pet.schedule}',
                          style: TextStyle(fontSize: 15, color: Colors.black),
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
              child: LineChart(LineChartData(lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0),
                    FlSpot(1, 5),
                    FlSpot(2, 10),
                    FlSpot(3, 15),
                    FlSpot(4, 20),
                    FlSpot(5, 25),
                  ],
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
