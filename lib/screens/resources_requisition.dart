import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ResourcesRequisitionForm extends StatefulWidget {
  static const String routeName = '/resources_requisition_form';

  const ResourcesRequisitionForm({Key? key}) : super(key: key);

  @override
  _ResourcesRequisitionFormState createState() =>
      _ResourcesRequisitionFormState();
}

class _ResourcesRequisitionFormState extends State<ResourcesRequisitionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _resourcesNeeded = '';
  bool _financialSupportNeeded = false;
  double _financialSupportAmount = 0;
  bool _resourceCostInvolved = false;
  String _reason = '';
  String _benefitsToStudents = '';
  String _date = '';
  String _name = '';
  String _positionInClub = '';
  String _email = '';
  String _contactNo = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data to Firebase
      DatabaseReference resourcesRequisitionRef = FirebaseDatabase.instance
          .reference()
          .child('resources_requisitions');
      resourcesRequisitionRef.push().set({
        'resources_needed': _resourcesNeeded,
        'financial_support_needed': _financialSupportNeeded,
        'financial_support_amount': _financialSupportAmount,
        'resource_cost_involved': _resourceCostInvolved,
        'reason': _reason,
        'benefits_to_students': _benefitsToStudents,
        'date': _date,
        'name': _name,
        'position_in_club': _positionInClub,
        'email': _email,
        'contact_no': _contactNo,
      }).then((_) {
        // Show submit dialog
        _showSubmitDialog(context);
      }).catchError((error) {
        // Handle error
        print("Error submitting form: $error");
      });
    }
  }

  void _showSubmitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Submitted'),
          content: Text('Your resources requisition form has been successfully submitted!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources Requisition Form'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Resources Needed',
                icon: Icon(Icons.assignment),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the resources needed.';
                }
                return null;
              },
              onSaved: (value) {
                _resourcesNeeded = value!;
              },
            ),
            CheckboxListTile(
              title: const Text('Financial Support Needed'),
              value: _financialSupportNeeded,
              onChanged: (bool? value) {
                setState(() {
                  _financialSupportNeeded = value!;
                });
              },
            ),
            if (_financialSupportNeeded)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Amount of Financial Support Needed',
                  icon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_financialSupportNeeded &&
                      (value == null || value.isEmpty)) {
                    return 'Please enter the amount of financial support needed.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _financialSupportAmount = double.parse(value!);
                },
              ),
            CheckboxListTile(
              title: const Text('Resource Cost Involved'),
              value: _resourceCostInvolved,
              onChanged: (bool? value) {
                setState(() {
                  _resourceCostInvolved = value!;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Reason',
                icon: Icon(Icons.message),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the reason.';
                }
                return null;
              },
              onSaved: (value) {
                _reason = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Benefits to Students',
                icon: Icon(Icons.how_to_reg),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the benefits to students.';
                }
                return null;
              },
              onSaved: (value) {
                _benefitsToStudents = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date',
                icon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the date.';
                }
                return null;
              },
              onSaved: (value) {
                _date = value!;
              },
            ),
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
                labelText: 'Position in Club',
                icon: Icon(Icons.work),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your position in the club.';
                }
                return null;
              },
              onSaved: (value) {
                _positionInClub = value!;
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 30.0,
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
