import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LetterOfRecommendationResponsesScreen extends StatefulWidget {
  static const String routeName = '/lor_responses';

  const LetterOfRecommendationResponsesScreen({Key? key}) : super(key: key);

  @override
  _LetterOfRecommendationResponsesScreenState createState() =>
      _LetterOfRecommendationResponsesScreenState();
}

class _LetterOfRecommendationResponsesScreenState
    extends State<LetterOfRecommendationResponsesScreen> {
  final List<LetterOfRecommendationResponse> _responses = [];

  @override
  void initState() {
    super.initState();
    _fetchLetterOfRecommendationResponses();
  }

  void _fetchLetterOfRecommendationResponses() {
    DatabaseReference lorRef =
        FirebaseDatabase.instance.reference().child('lors');
    lorRef.onValue.listen((event) {
      _responses.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            LetterOfRecommendationResponse response =
                LetterOfRecommendationResponse.fromMap(value);
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
        title: Text('Letter of Recommendation Responses'),
      ),
      body: ListView.builder(
        itemCount: _responses.length,
        itemBuilder: (context, index) {
          final response = _responses[index];
          return ListTile(
            title: Text(response.studentName),
            subtitle: Text(response.requestedFaculty),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LORResponseDetailsScreen(response: response),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LORResponseDetailsScreen extends StatelessWidget {
  final LetterOfRecommendationResponse response;

  const LORResponseDetailsScreen({Key? key, required this.response})
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
            Text('Student Name: ${response.studentName}'),
            Text('Requested Faculty: ${response.requestedFaculty}'),
            Text('Reason for LOR: ${response.reason}'),
            Text('CGPA: ${response.cgpa ?? 'N/A'}'),
            Text('Co-curriculars: ${response.coCurriculars}'),
            Text('LOR Text: ${response.lorText}'),
            Text('Request Reason: ${response.requestReason}'),
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

class LetterOfRecommendationResponse {
  final String studentName;
  final String reason;
  final double? cgpa;
  final String coCurriculars;
  final String lorText;
  final String requestedFaculty;
  final String requestReason;

  LetterOfRecommendationResponse({
    required this.studentName,
    required this.reason,
    required this.cgpa,
    required this.coCurriculars,
    required this.lorText,
    required this.requestedFaculty,
    required this.requestReason,
  });

  factory LetterOfRecommendationResponse.fromMap(Map<dynamic, dynamic> map) {
    return LetterOfRecommendationResponse(
      studentName: map['student_name'],
      reason: map['reason'],
      cgpa: map['cgpa'] != null ? double.tryParse(map['cgpa'].toString()) : null,
      coCurriculars: map['co_curriculars'],
      lorText: map['lor_text'],
      requestedFaculty: map['requested_faculty'],
      requestReason: map['request_reason'],
    );
  }
}
