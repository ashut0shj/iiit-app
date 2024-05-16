import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EventResponse {
  final String name;
  final String email;
  final String position;
  final String selectedDate;
  final String selectedTime;
  final String requirements;
  final double? cost;
  final String requests;
  final String eventName;
  final String eventDescription;
  final String eventId;
  bool approved;
  String comments;

  EventResponse({
    required this.name,
    required this.email,
    required this.position,
    required this.selectedDate,
    required this.selectedTime,
    required this.requirements,
    required this.cost,
    required this.requests,
    required this.eventName,
    required this.eventDescription,
    required this.eventId,
    this.approved = false,
    this.comments = '',
  });

  factory EventResponse.fromMap(Map<dynamic, dynamic> map) {
    return EventResponse(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      position: map['position'] ?? '',
      selectedDate: map['selectedDate'] ?? '',
      selectedTime: map['selectedTime'] ?? '',
      requirements: map['requirements'] ?? '',
      cost: map['cost'],
      requests: map['requests'] ?? '',
      eventName: map['eventName'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      approved: map['approved'] ?? false,
      comments: map['comments'] ?? '',
      eventId: map['eventId'] ?? '',
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventResponsesScreen(),
    );
  }
}

class EventResponsesScreen extends StatefulWidget {
  static const String routeName = '/admin_form';
  @override
  _EventResponsesScreenState createState() => _EventResponsesScreenState();
}

class _EventResponsesScreenState extends State<EventResponsesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<EventResponse> _responses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchEventResponses();
  }

  void _fetchEventResponses() {
    DatabaseReference eventRef =
        FirebaseDatabase.instance.reference().child('event_details');
    eventRef.onValue.listen((event) {
      _responses.clear();
      if (event.snapshot.value != null) {
        Object? values = event.snapshot.value;
        (values as Map).forEach((key, value) {
          EventResponse response = EventResponse.fromMap(value);
          _responses.add(response);
        });
        setState(() {});
      }
    });
  }

  void _updateEventResponse(EventResponse response, bool approve) {
    response.approved = approve;
    DatabaseReference eventRef =
        FirebaseDatabase.instance.reference().child('event_details');
    if (approve) {
      eventRef.child(response.eventId).update({
        'approved': response.approved,
        'comments': response.comments,
      }).then((_) {
        setState(() {});
      });
    } else {
      eventRef.child(response.eventId).remove().then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Responses'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Approved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildResponseList(approved: false),
          _buildResponseList(approved: true),
        ],
      ),
    );
  }

  Widget _buildResponseList({required bool approved}) {
    final filteredResponses =
        _responses.where((response) => response.approved == approved).toList();
    return ListView.builder(
      itemCount: filteredResponses.length,
      itemBuilder: (context, index) {
        final response = filteredResponses[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${response.name}'),
                Text('Email: ${response.email}'),
                Text('Position: ${response.position}'),
                Text('Selected Date: ${response.selectedDate}'),
                Text('Selected Time: ${response.selectedTime}'),
                Text('Requirements: ${response.requirements}'),
                Text('Cost: ${response.cost ?? 'NA'}'),
                Text('Requests: ${response.requests}'),
                Text('Event Name: ${response.eventName}'),
                Text('Event Description: ${response.eventDescription}'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _updateEventResponse(response, true);
                      },
                      child: Text('Approve'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _updateEventResponse(response, false);
                      },
                      child: Text('Reject'),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Comments'),
                  onChanged: (value) {
                    response.comments = value;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
