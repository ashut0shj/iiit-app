import 'package:flutter/material.dart';
import 'event_form.dart'; 
import 'key_form.dart';
import 'resources_requisition.dart';
import 'grievance_form.dart';
import 'letter.dart';// Import the EventForm screen from the same directory or package
// Import other form screens if needed

class FormsScreen extends StatelessWidget {
  static const String routeName = '/forms';

  const FormsScreen({super.key});

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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, EventForm.routeName); // Navigate to EventForm screen
            },
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, EventForm.routeName); // Handle button tap if needed
              },
              child: const Text('Event Proposal Form'),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, KeyRequisitionForm.routeName);
              // Navigate to Key Requisition Form screen
            },
            child: const Text('Key Requisition Form'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
             Navigator.pushNamed(context, GrievanceForm.routeName);
              // Navigate to Grievance Form screen
            },
            child: const Text('Grievance Form'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LetterOfRecommendationForm.routeName);
              // Navigate to Letter of Recommendation Form screen
            },
            child: const Text('Letter of Recommendation Form'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ResourcesRequisitionForm.routeName);
              // Navigate to Resources Requisition Form screen
            },
            child: const Text('Resources Requisition Form'),
          ),
          // Add more buttons for other forms if needed
        ],
      ),
    );
  }
}