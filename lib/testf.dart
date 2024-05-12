import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.fort),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TestForm()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open form'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const TestForm(),
            );
          },
        ),
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  const TestForm({Key? key}) : super(key: key);

  @override
  State<TestForm> createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    _otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _feedbackController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              maxLength: 4096,
              decoration: const InputDecoration(
                labelText: 'Feedback',
                hintText: 'Enter your feedback here',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _otherController,
              decoration: const InputDecoration(
                labelText: 'Other Field',
                hintText: 'Enter other information here',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendFeedback();
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendFeedback() {
    String feedback = _feedbackController.text.trim();
    String other = _otherController.text.trim();
    if (feedback.isNotEmpty) {
      DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
      databaseReference.child('feedback').push().set({
        'timestamp': DateTime.now().toIso8601String(),
        'feedback': feedback,
        'other': other,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Feedback sent successfully'),
          ),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send feedback: $error'),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your feedback'),
        ),
      );
    }
  }
}
