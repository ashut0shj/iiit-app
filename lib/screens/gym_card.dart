import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GymPassForm extends StatefulWidget {
  static const String routeName = '/gym_pass_form';

  const GymPassForm({super.key});

  @override
  _GymPassFormState createState() => _GymPassFormState();
}

class _GymPassFormState extends State<GymPassForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _category = '';
  String _gender = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data to Firebase
      DatabaseReference passRef =
          FirebaseDatabase.instance.reference().child('gym_passes');
      passRef.push().set({
        'card_number': _cardNumber,
        'category': _category,
        'gender': _gender,
      });

      // Navigate to success page or do something else
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Pass Entry'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Number',
                icon: Icon(Icons.credit_card),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your card number.';
                }
                return null;
              },
              onSaved: (value) {
                _cardNumber = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Category (Student/Faculty)',
                icon: Icon(Icons.category),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your category.';
                }
                return null;
              },
              onSaved: (value) {
                _category = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Gender (Male/Female)',
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your gender.';
                }
                return null;
              },
              onSaved: (value) {
                _gender = value!;
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
