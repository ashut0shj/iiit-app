import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class KeyRequisitionResponsesScreen extends StatefulWidget {
  static const String routeName = '/key_requisition_responses';

  const KeyRequisitionResponsesScreen({Key? key}) : super(key: key);

  @override
  _KeyRequisitionResponsesScreenState createState() =>
      _KeyRequisitionResponsesScreenState();
}

class _KeyRequisitionResponsesScreenState
    extends State<KeyRequisitionResponsesScreen> {
  final List<KeyRequisitionResponse> _responses = [];

  @override
  void initState() {
    super.initState();
    _fetchKeyRequisitionResponses();
  }

  void _fetchKeyRequisitionResponses() {
    DatabaseReference keyRequisitionRef =
        FirebaseDatabase.instance.reference().child('key_requisitions');
    keyRequisitionRef.onValue.listen((event) {
      _responses.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            KeyRequisitionResponse response =
                KeyRequisitionResponse.fromMap(value);
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
        title: Text('Key Requisition Responses'),
      ),
      body: ListView.builder(
        itemCount: _responses.length,
        itemBuilder: (context, index) {
          final response = _responses[index];
          return ListTile(
            title: Text(response.name),
            subtitle: Text(response.email),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KeyRequisitionResponseDetailsScreen(response: response),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class KeyRequisitionResponseDetailsScreen extends StatelessWidget {
  final KeyRequisitionResponse response;

  const KeyRequisitionResponseDetailsScreen({Key? key, required this.response})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Response Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${response.name}'),
            Text('Email: ${response.email}'),
            Text('Position: ${response.position}'),
            Text('Batch Year: ${response.batchYear}'),
            Text('Branch: ${response.branch}'),
            Text('Date: ${response.date}'),
            Text('Time From: ${response.timeFrom}'),
            Text('Time To: ${response.timeTo}'),
            Text('Reason: ${response.reason}'),
            Text('Contact No: ${response.contactNo}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle approval
              },
              child: Text('Approve'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle rejection
              },
              child: Text('Reject'),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Comments'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit comments
              },
              child: Text('Submit Comments'),
            ),
          ],
        ),
      ),
    );
  }
}

class KeyRequisitionResponse {
  final String name;
  final String email;
  final String position;
  final String batchYear;
  final String branch;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String reason;
  final String contactNo;

  KeyRequisitionResponse({
    required this.name,
    required this.email,
    required this.position,
    required this.batchYear,
    required this.branch,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.reason,
    required this.contactNo,
  });

  factory KeyRequisitionResponse.fromMap(Map<dynamic, dynamic> map) {
    return KeyRequisitionResponse(
      name: map['name'],
      email: map['email'],
      position: map['position'],
      batchYear: map['batch_year'],
      branch: map['branch'],
      date: map['date'],
      timeFrom: map['time_from'],
      timeTo: map['time_to'],
      reason: map['reason'],
      contactNo: map['contact_no'],
    );
  }
}
