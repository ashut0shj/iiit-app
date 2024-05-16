import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GrievanceForm extends StatefulWidget {
  static const String routeName = '/grievance_form';

  const GrievanceForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GrievanceFormState createState() => _GrievanceFormState();
}

class _GrievanceFormState extends State<GrievanceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _grievance = '';
  String _authority = '';

  void _submitForm() {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    // Save data to Firebase
    DatabaseReference grievanceRef =
        FirebaseDatabase.instance.reference().child('grievances');
    DatabaseReference newGrievanceRef = grievanceRef.push();
    String grievanceId = newGrievanceRef.key!; // Generate a unique grievanceId
    newGrievanceRef.set({
      'grievanceId': grievanceId,
      'name': _name,
      'email': _email,
      'grievance': _grievance,
      'authority': _authority,
      'approved': false,
    });

    // Navigate to success page or do something else
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grievance Form'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Grievance',
                icon: Icon(Icons.message),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your grievance.';
                }
                return null;
              },
              onSaved: (value) {
                _grievance = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Authority',
                icon: Icon(Icons.account_balance),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the authority to address the grievance.';
                }
                return null;
              },
              onSaved: (value) {
                _authority = value!;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: const TextStyle(fontSize: 16.0),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
