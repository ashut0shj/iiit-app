import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package



class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  static const routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 100.0,
                  child: Center(),
                ),
                const SizedBox(width: 20.0),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: const Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20.0),
                const Text(
                  'admin roles',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: const Center(
                child: Text(
                  'Roles',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Action for create an event button
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Create an Event',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Action for delete an event button
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Delete an Event',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Action for submit event report button
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Submit Event Report',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: const Center(
                child: Text(
                  'Forms',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSciOvI89bYDaKKFXUvKs3eE1feb-kjKypwQCD9BTJod9A1VFg/viewform'));
                  // Action for event requisition form button
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Event Requisition Form',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSciOvI89bYDaKKFXUvKs3eE1feb-kjKypwQCD9BTJod9A1VFg/viewform'));
                  // Action for key issue form button
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Key Issue form',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSciOvI89bYDaKKFXUvKs3eE1feb-kjKypwQCD9BTJod9A1VFg/viewform'));
                  // Action for grievance form button
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  'Grievance form',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

