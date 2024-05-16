import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GymPassEntriesScreen extends StatefulWidget {
  static const String routeName = '/gym_pass_entries';

  const GymPassEntriesScreen({super.key});

  @override
  _GymPassEntriesScreenState createState() => _GymPassEntriesScreenState();
}

class _GymPassEntriesScreenState extends State<GymPassEntriesScreen> {
  final List<GymPassEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _fetchGymPassEntries();
  }

  void _fetchGymPassEntries() {
    DatabaseReference passRef =
        FirebaseDatabase.instance.reference().child('gym_passes');
    passRef.onValue.listen((event) {
      _entries.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            if (value is Map<dynamic, dynamic>) {
              GymPassEntry entry = GymPassEntry.fromMap(value);
              _entries.add(entry);
            } else {
              print('Unexpected data format for entry: $value');
            }
          });
          setState(() {});
          print('Data fetched successfully: $_entries');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Pass Entries'),
      ),
      body: ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          final entry = _entries[index];
          return Card(
            child: ListTile(
              title: Text('Card Number: ${entry.cardNumber}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${entry.category}'),
                  Text('Gender: ${entry.gender}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GymPassEntry {
  final int cardNumber;
  final String category;
  final String gender;

  GymPassEntry({
    required this.cardNumber,
    required this.category,
    required this.gender,
  });

  factory GymPassEntry.fromMap(Map<dynamic, dynamic> map) {
    return GymPassEntry(
      cardNumber: map['card_number'],
      category: map['category'],
      gender: map['gender'],
    );
  }
}
