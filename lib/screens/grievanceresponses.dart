import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GrievanceResponsesScreen extends StatefulWidget {
  static const String routeName = '/grievance_responses';

  const GrievanceResponsesScreen({Key? key}) : super(key: key);

  @override
  _GrievanceResponsesScreenState createState() =>
      _GrievanceResponsesScreenState();
}

class _GrievanceResponsesScreenState extends State<GrievanceResponsesScreen> {
  final List<GrievanceResponse> _responses = [];

  @override
  void initState() {
    super.initState();
    _fetchGrievanceResponses();
  }

  void _fetchGrievanceResponses() {
    DatabaseReference grievanceRef =
        FirebaseDatabase.instance.reference().child('grievances');
    grievanceRef.onValue.listen((event) {
      _responses.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            GrievanceResponse response =
                GrievanceResponse.fromMap(value);
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
        title: Text('Grievance Responses'),
      ),
      body: ListView.builder(
        itemCount: _responses.length,
        itemBuilder: (context, index) {
          final response = _responses[index];
          return ListTile(
            title: Text(response.name),
            subtitle: Text(response.authority),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GrievanceResponseDetailsScreen(response: response),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GrievanceResponseDetailsScreen extends StatelessWidget {
  final GrievanceResponse response;

  const GrievanceResponseDetailsScreen({Key? key, required this.response})
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
            Text('Grievance: ${response.grievance}'),
            Text('Authority: ${response.authority}'),
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

class GrievanceResponse {
  final String name;
  final String email;
  final String grievance;
  final String authority;

  GrievanceResponse({
    required this.name,
    required this.email,
    required this.grievance,
    required this.authority,
  });

  factory GrievanceResponse.fromMap(Map<dynamic, dynamic> map) {
    return GrievanceResponse(
      name: map['name'],
      email: map['email'],
      grievance: map['grievance'],
      authority: map['authority'],
    );
  }
}
