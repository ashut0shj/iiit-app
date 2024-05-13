import 'package:flutter/material.dart';
import 'event_responses.dart'; 
import 'key_response.dart';

import 'grievanceresponses.dart';
import 'letterrespomse.dart'; 

class FormsResponsesScreen extends StatelessWidget {
  static const String routeName = '/forms_responses';

  const FormsResponsesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, EventResponsesScreen.routeName);
            },
            child: const Text('Event Proposal Form Responses'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, KeyRequisitionResponsesScreen.routeName);
            },
            child: const Text('Key Requisition Form Responses'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, GrievanceResponsesScreen.routeName);
            },
            child: const Text('Grievance Form Responses'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LetterOfRecommendationResponsesScreen.routeName);
            },
            child: const Text('Letter of Recommendation Form Responses'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushNamed(context, ResourcesRequisitionFormResponses.routeName);
            },
            child: const Text('Resources Requisition Form Responses'),
          ),
          // Add more buttons for other forms if needed
        ],
      ),
    );
  }
}
