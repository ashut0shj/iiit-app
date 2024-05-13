import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const routeName = '/discover';

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late List<EventDetails> eventDetails;

  @override
  void initState() {
    super.initState();
    fetchEventDetails();
  }

  void fetchEventDetails() {
    DatabaseReference eventDetailsRef = FirebaseDatabase.instance.reference().child('event_details');
    eventDetailsRef.once().then((DataSnapshot snapshot) {
      List<EventDetails> fetchedEventDetails = [];
      Object? values = snapshot.value;
      (values as Map<dynamic, dynamic>).forEach((key, value) {
        fetchedEventDetails.add(EventDetails.fromJson(value)); // Assuming you have a fromJson method in your EventDetails model
      });
      setState(() {
        eventDetails = fetchedEventDetails;
      });
    } as FutureOr Function(DatabaseEvent value)).catchError((error) {
      print('Failed to fetch event details: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover'),
      ),
      body: ListView.builder(
        itemCount: eventDetails.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(eventDetails[index].eventName),
            subtitle: Text('Date: ${eventDetails[index].selectedDate}, Time: ${eventDetails[index].selectedTime}'),
            onTap: () {
              // Handle tap on event details
            },
          );
        },
      ),
    );
  }
}

class EventDetails {
  final String eventName;
  final String selectedDate;
  final String selectedTime;

  EventDetails({
    required this.eventName,
    required this.selectedDate,
    required this.selectedTime,
  });

  factory EventDetails.fromJson(Map<dynamic, dynamic> json) {
    return EventDetails(
      eventName: json['eventName'],
      selectedDate: json['selectedDate'],
      selectedTime: json['selectedTime'],
    );
  }
}
