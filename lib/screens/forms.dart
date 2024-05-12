import 'package:flutter/material.dart';
import 'package:iiitnr/screens/event_form.dart';
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
          // Add buttons for other forms if needed
        ],
      ),
    );
  }
}
