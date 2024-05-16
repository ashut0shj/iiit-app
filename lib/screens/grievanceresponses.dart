import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GrievanceResponse {
  final String name;
  final String email;
  final String grievance;
  final String authority;
  final String grievanceId;
  bool approved;
  String comments;

  GrievanceResponse({
    required this.name,
    required this.email,
    required this.grievance,
    required this.authority,
    required this.grievanceId,
    this.approved = false,
    this.comments = '',
  });

  factory GrievanceResponse.fromMap(Map<dynamic, dynamic> map) {
    return GrievanceResponse(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      grievance: map['grievance'] ?? '',
      authority: map['authority'] ?? '',
      approved: map['approved'] ?? false,
      comments: map['comments'] ?? '',
      grievanceId: map['grievanceId'] ?? '',
    );
  }
}

class GrievanceResponsesScreen extends StatefulWidget {
  static const String routeName = '/grievance_responses';

  const GrievanceResponsesScreen({Key? key}) : super(key: key);

  @override
  _GrievanceResponsesScreenState createState() =>
      _GrievanceResponsesScreenState();
}

class _GrievanceResponsesScreenState extends State<GrievanceResponsesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<GrievanceResponse> _responses = [];
  List<GrievanceResponse> _allResponses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchGrievanceResponses();
  }

  void _fetchGrievanceResponses() {
    DatabaseReference grievanceRef =
        FirebaseDatabase.instance.reference().child('grievances');
    grievanceRef.onValue.listen((event) {
      _responses.clear();
      _allResponses.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            GrievanceResponse response =
                GrievanceResponse.fromMap(value);
            _allResponses.add(response);
            if (!response.approved) {
              _responses.add(response);
            }
          });
          setState(() {});
        }
      }
    });
  }

  void _updateGrievanceResponse(
      GrievanceResponse response, bool approve) {
    response.approved = approve;
    DatabaseReference grievanceRef =
        FirebaseDatabase.instance.reference().child('grievances');
    if (approve) {
      grievanceRef.child(response.grievanceId).update({
        'approved': response.approved,
        'comments': response.comments,
      }).then((_) {
        setState(() {});
      });
    } else {
      grievanceRef.child(response.grievanceId).remove().then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grievance Responses'),
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
          _buildResponseList(_responses),
          _buildResponseList(_allResponses),
        ],
      ),
    );
  }

  Widget _buildResponseList(List<GrievanceResponse> responses) {
    return ListView.builder(
      itemCount: responses.length,
      itemBuilder: (context, index) {
        final response = responses[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${response.name}'),
                Text('Email: ${response.email}'),
                Text('Grievance: ${response.grievance}'),
                Text('Authority: ${response.authority}'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _updateGrievanceResponse(response, true);
                      },
                      child: Text('Approve'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _updateGrievanceResponse(response, false);
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
