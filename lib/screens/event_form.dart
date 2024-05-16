import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EventForm extends StatefulWidget {
  static const String routeName = '/event_form';

  const EventForm({super.key});

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _position = '';
  String _requirements = '';
  double? _cost;
  String _requests = '';
  String _clubName = ''; // Add club name variable
  String _category = 'Technical'; // Initialize _category to 'Technical'

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late final File? _image = null; // Initialize _image to null

  void _navigateToEventDetails() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsForm(
            name: _name,
            email: _email,
            position: _position,
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            requirements: _requirements,
            cost: _cost,
            requests: _requests,
            image: _image, // Pass _image to EventDetailsForm
            category: _category, // Pass _category to EventDetailsForm
            clubName: _clubName, // Pass _clubName to EventDetailsForm
          ),
        ),
      );
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

  _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Planning Form'),
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
                if (value!.isEmpty) {
                  return 'Please enter your email.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
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
                _position = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText:
                    'Requirements for the Event (Optional , Fill NA if not required)',
                icon: Icon(Icons.list),
              ),
              onSaved: (value) {
                _requirements = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText:
                    'Cost for the Requirements (Optional , Fill NA if not required)',
                icon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                    _cost = double.parse(value);
                  } catch (e) {
                    _cost = null; // Set null if parsing fails
                  }
                } else {
                  _cost = null;
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText:
                    'Any Additional Requests (Optional , Fill NA if not required)',
                icon: Icon(Icons.note),
              ),
              onSaved: (value) {
                _requests = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Club Name', // Add club name field
                icon: Icon(Icons.group),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the club name.';
                }
                return null;
              },
              onSaved: (value) {
                _clubName = value!;
              },
            ),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Category',
                icon: Icon(Icons.category),
              ),
              items: <String>[
                'Technical',
                'Cultural',
                'Miscellaneous',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _category = newValue!;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Selected Date: ${selectedDate.toString().contains(' ') ? selectedDate.toString().split(' ')[0] : selectedDate.toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    'Selected Time: ${selectedTime.toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: const Text(
                      'Select date',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
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
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _navigateToEventDetails,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: const TextStyle(fontSize: 16.0),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}


class EventDetailsForm extends StatefulWidget {
  final String name;
  final String email;
  final String position;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String requirements;
  final double? cost;
  final String requests;
  File? image;
  String category;
  String clubName; // Add club name variable

  EventDetailsForm({
    super.key,
    required this.name,
    required this.email,
    required this.position,
    required this.selectedDate,
    required this.selectedTime,
    required this.requirements,
    required this.cost,
    required this.requests,
    required this.image,
    required this.category,
    required this.clubName, // Pass club name from EventForm
  });

  @override
  _EventDetailsFormState createState() => _EventDetailsFormState();
}

class _EventDetailsFormState extends State<EventDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _eventName = '';
  String _eventDescription = '';
  String imageUrl = ''; // Initialize imageUrl

  void _saveEventDataToFirebase() async {
    DatabaseReference eventDetailsRef =
        FirebaseDatabase.instance.reference().child('event_details');
    DatabaseReference newEventRef = eventDetailsRef.push();
    String? eventId = newEventRef.key; // Get the key generated by push()
    await newEventRef.set({
      'name': widget.name,
      'email': widget.email,
      'position': widget.position,
      'selectedDate': widget.selectedDate.toString(),
      'selectedTime': widget.selectedTime.toString(),
      'requirements': widget.requirements,
      'cost': widget.cost,
      'requests': widget.requests,
      'eventName': _eventName,
      'eventDescription': _eventDescription,
      'imageUrl': imageUrl,
      'approveStatus': false,
      'category': widget.category, // Save category to database
      'clubName': widget.clubName, // Save club name to database
    });

    // Store the reference ID (key) in the database entry itself
    await eventDetailsRef.child(eventId!).update({'eventId': eventId});
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.image = File(pickedFile.path);
      });

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('event_images');
      String uniqueFileName =
          DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);

      try {
        await referenceImageToUpload.putFile(File(pickedFile.path));
        imageUrl = await referenceImageToUpload.getDownloadURL();
      } catch (error) {
        print('Error uploading image: $error');
      }
    }
  }

  void _showSubmitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Submitted'),
          content:
              Text('Your event form has been successfully submitted!'),
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
        title: const Text('Event Details Form'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Event Name',
                icon: Icon(Icons.event),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the event name.';
                }
                return null;
              },
              onSaved: (value) {
                _eventName = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Event Description',
                icon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the event description.';
                }
                return null;
              },
              onSaved: (value) {
                _eventDescription = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text(widget.image == null ? 'Select Image' : 'Change Image'),
            ),
            SizedBox(height: 20),
            if (widget.image != null)
              Image.network(
                imageUrl, // Use imageUrl instead of _image.path
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _saveEventDataToFirebase();
                  _showSubmitDialog(context); // Show submit dialog
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: const TextStyle(fontSize: 16.0),
                backgroundColor: Colors.greenAccent,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
