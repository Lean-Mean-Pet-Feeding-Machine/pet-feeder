import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

void main() {
  runApp(
    MaterialApp(
      home: SchedulePage(),
    ),
  );
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? selectedDate;
  TextEditingController eventController = TextEditingController();
  late EventController eventControllerInstance;

  @override
  void initState() {
    super.initState();
    eventControllerInstance = EventController();
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _addEvent() {
    final event = CalendarEventData(
      date: selectedDate!,
      event: eventController.text,
      title: eventController.text,
    );

    setState(() {
      eventControllerInstance
          .add(event); // Add the event to the EventController
      eventController.clear(); // Clear the text field after adding the event
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            // TODO: Add time and date to schedule
            onPressed: () => _selectDate(context),
            child: Text('Select Date'),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: eventController,
              decoration: InputDecoration(labelText: 'Add Feeding Time:'),
              onSubmitted: (_) => _addEvent(),
            ),
          ),
          Expanded(
            child: DayView(
              controller: eventControllerInstance,
              eventTileBuilder: (date, events, boundary, start, end) {
                // Return your widget to display as event tile.
                return Container(
                  child: Column(
                    children: events.map((event) {
                      return ListTile(
                        title: Text(event.title),
                        subtitle:
                            Text('${event.date.hour}:${event.date.minute}'),
                      );
                    }).toList(),
                  ),
                );
              },
              // ... other properties remain the same
            ),
          ),
        ],
      ),
    );
  }
}
