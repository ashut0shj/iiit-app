import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GymPassEntriesScreen extends StatefulWidget {
  static const String routeName = '/gym_pass_entries';

  const GymPassEntriesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GymPassEntriesScreenState createState() => _GymPassEntriesScreenState();
}

class _GymPassEntriesScreenState extends State<GymPassEntriesScreen> {
  final List<GymPassEntry> _entries = [];
  final Map<String, int> _shiftCounts = {
    '5am to 7:30 boys': 0,
    '7:30 to 9am girls': 0,
    '9 to 1 faculty': 0,
    '6 to 7:30 girls': 0,
    '7:30 to 9 boys': 0,
    '9 to 10:30 boys': 0,
    '2pm to 6pm mix (on holidays)': 0,
  };

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
      _shiftCounts.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            GymPassEntry entry = GymPassEntry.fromMap(value);
            _entries.add(entry);
            _updateShiftCounts(entry);
          });
          setState(() {});
        }
      }
    });
  }

  void _updateShiftCounts(GymPassEntry entry) {
    // Update shift counts based on entry timings
    if (entry.shift.isNotEmpty) {
      _shiftCounts[entry.shift] = _shiftCounts[entry.shift]! + 1;
    }
  }

  bool _canApprovePass(String shift) {
    // Check if the pass can be approved based on shift counts
    if (_shiftCounts.containsKey(shift)) {
      return _shiftCounts[shift]! < 40;
    }
    return true; // Default to true if shift not found
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
          final bool canApprove = _canApprovePass(entry.shift);
          return ListTile(
            title: Text('Card Number: ${entry.cardNumber}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${entry.category}'),
                Text('Gender: ${entry.gender}'),
                Text('Shift: ${entry.shift}'),
                if (canApprove)
                  ElevatedButton(
                    onPressed: () {
                      // Handle approval
                    },
                    child: Text('Approve'),
                  )
                else
                  Text('Approval disabled for this shift'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GymPassEntry {
  final String cardNumber;
  final String category;
  final String gender;
  final String shift;

  GymPassEntry({
    required this.cardNumber,
    required this.category,
    required this.gender,
    required this.shift,
  });

  factory GymPassEntry.fromMap(Map<dynamic, dynamic> map) {
    return GymPassEntry(
      cardNumber: map['card_number'],
      category: map['category'],
      gender: map['gender'],
      shift: map['shift'],
    );
  }
}
