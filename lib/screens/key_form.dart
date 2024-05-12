import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class KeyRequisitionForm extends StatefulWidget {
  static const String routeName = '/key_requisition_form';

  const KeyRequisitionForm({Key? key}) : super(key: key);

  @override
  _KeyRequisitionFormState createState() => _KeyRequisitionFormState();
}

class _KeyRequisitionFormState extends State<KeyRequisitionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _position = '';
  String _batchYear = '';
  String _branch = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimeFrom = TimeOfDay.now();
  TimeOfDay selectedTimeTo = TimeOfDay.now();
  String _reason = '';
  String _contactNo = '';
  String _email = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data to Firebase
      DatabaseReference keyRequisitionRef = FirebaseDatabase.instance.reference().child('key_requisitions');
      keyRequisitionRef.push().set({
        'name': _name,
        'position': _position,
        'batch_year': _batchYear,
        'branch': _branch,
        'date': selectedDate.toString(),
        'time_from': selectedTimeFrom.toString(),
        'time_to': selectedTimeTo.toString(),
        'reason': _reason,
        'contact_no': _contactNo,
        'email': _email,
      });

      // Navigate to success page or do something else
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  _selectTimeFrom(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTimeFrom,
    );
    if (pickedTime != null && pickedTime != selectedTimeFrom) {
      setState(() {
        selectedTimeFrom = pickedTime;
      });
    }
  }

  _selectTimeTo(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTimeTo,
    );
    if (pickedTime != null && pickedTime != selectedTimeTo) {
      setState(() {
        selectedTimeTo = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Requisition Form'),
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
                labelText: 'Position',
                icon: Icon(Icons.work),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your position.';
                }
                return null;
              },
              onSaved: (value) {
                _position = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Batch Year',
                icon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your batch year.';
                }
                return null;
              },
              onSaved: (value) {
                _batchYear = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Branch',
                icon: Icon(Icons.location_city),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your branch.';
                }
                return null;
              },
              onSaved: (value) {
                _branch = value!;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Reason',
                icon: Icon(Icons.message),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the reason for key requisition.';
                }
                return null;
              },
              onSaved: (value) {
                _reason = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contact No.',
                icon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your contact number.';
                }
                return null;
              },
              onSaved: (value) {
                _contactNo = value!;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      'Selected Date: ${selectedDate.toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'From: ${selectedTimeFrom.format(context)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _selectTimeFrom(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0, 
                            horizontal: 10.0
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.greenAccent,
                        ),
                        child: const Text(
                          'Select time',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'To: ${selectedTimeTo.format(context)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _selectTimeTo(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0, 
                            horizontal: 10.0
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.greenAccent,
                        ),
                        child: const Text(
                          'Select time',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0, 
                  horizontal: 30.0
                ),
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
