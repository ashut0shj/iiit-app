import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class LetterOfRecommendationForm extends StatefulWidget {
  static const String routeName = '/lor_form';

  const LetterOfRecommendationForm({Key? key}) : super(key: key);

  @override
  _LetterOfRecommendationFormState createState() =>
      _LetterOfRecommendationFormState();
}

class _LetterOfRecommendationFormState
    extends State<LetterOfRecommendationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _studentName = '';
  String _reason = '';
  double? _cgpa;
  String _coCurriculars = '';
  String _lorText = '';
  String _requestedFaculty = '';
  String _requestReason = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data to Firebase
      DatabaseReference lorRef =
          FirebaseDatabase.instance.reference().child('lors');
      lorRef.push().set({
        'student_name': _studentName,
        'reason': _reason,
        'cgpa': _cgpa,
        'co_curriculars': _coCurriculars,
        'lor_text': _lorText,
        'requested_faculty': _requestedFaculty,
        'request_reason': _requestReason,
      });

      // Navigate to success page or do something else
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Letter of Recommendation Form'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Student Name',
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the student name.';
                }
                return null;
              },
              onSaved: (value) {
                _studentName = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Reason for LOR',
                icon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the reason for the LOR.';
                }
                return null;
              },
              onSaved: (value) {
                _reason = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'CGPA',
                icon: Icon(Icons.school),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the CGPA.';
                }
                return null;
              },
              onSaved: (value) {
                _cgpa = double.tryParse(value!);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Co-curriculars',
                icon: Icon(Icons.sports),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the co-curricular activities.';
                }
                return null;
              },
              onSaved: (value) {
                _coCurriculars = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Letter of Recommendation Text',
                icon: Icon(Icons.note),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the text for the LOR.';
                }
                return null;
              },
              onSaved: (value) {
                _lorText = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Requested Faculty',
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the requested faculty.';
                }
                return null;
              },
              onSaved: (value) {
                _requestedFaculty = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Reason for Request',
                icon: Icon(Icons.message),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the reason for the request.';
                }
                return null;
              },
              onSaved: (value) {
                _requestReason = value!;
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
