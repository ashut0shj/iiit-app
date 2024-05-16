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
  String _name = '';
  String _cardNumber = '';
  bool _submitted = false;
  bool _inside = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data to Firebase
      DatabaseReference passRef =
          FirebaseDatabase.instance.reference().child('gym_passes');
      passRef.push().set({
        'name': _name,
        'card_number': _cardNumber,
        'inside': _inside,
      });

      setState(() {
        _submitted = true;
      });
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
            if (_submitted) // Show the inside status if form is submitted
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  _inside ? 'Inside' : 'Outside',
                  style: TextStyle(
                    fontSize: 30.0, // Set a larger font size
                    color: _inside ? Colors.green : Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
