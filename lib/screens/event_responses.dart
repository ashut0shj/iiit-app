import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class EventResponse {
  final String name;
  final String email;
  final String position;
  final String selectedDate;
  final String selectedTime;
  final String requirements;
  final double? cost;
  final String requests;

  EventResponse({
    required this.name,
    required this.email,
    required this.position,
    required this.selectedDate,
    required this.selectedTime,
    required this.requirements,
    required this.cost,
    required this.requests,
  });

  factory EventResponse.fromMap(Map<dynamic, dynamic> map) {
    return EventResponse(
      name: map['name'],
      email: map['email'],
      position: map['position'],
      selectedDate: map['selectedDate'],
      selectedTime: map['selectedTime'],
      requirements: map['requirements'],
      cost: map['cost'],
      requests: map['requests'],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EventResponsesScreen(),
    );
  }
}

class EventResponsesScreen extends StatefulWidget {
  static const String routeName = '/event_form_res';

  const EventResponsesScreen({super.key});
  @override
  _EventResponsesScreenState createState() => _EventResponsesScreenState();
}

class _EventResponsesScreenState extends State<EventResponsesScreen> {
  final List<EventResponse> _responses = [];

  @override
  void initState() {
    super.initState();
    _fetchEventResponses();
  }

  void _fetchEventResponses() {
    DatabaseReference eventRef =
        FirebaseDatabase.instance.reference().child('events');
    eventRef.onValue.listen((event) {
      _responses.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            EventResponse response = EventResponse.fromMap(value);
            _responses.add(response);
          });
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Responses'),
      ),
      body: ListView.builder(
        itemCount: _responses.length,
        itemBuilder: (context, index) {
          final response = _responses[index];
          return ListTile(
            title: Text(response.name),
            subtitle: Text(response.email),
            onTap: () {
              // Handle tap on response
            },
          );
        },
      ),
    );
  }
}
