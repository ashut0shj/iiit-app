import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GymPass {
  final String name;
  final String cardNumber;
  bool inside;

  GymPass({
    required this.name,
    required this.cardNumber,
    this.inside = false,
  });
}

class GymPassEntriesScreen extends StatefulWidget {
  static const String routeName = '/gym_pass_entries_screen';

  @override
  _GymPassEntriesScreenState createState() => _GymPassEntriesScreenState();
}

class _GymPassEntriesScreenState extends State<GymPassEntriesScreen> {
  final DatabaseReference _passRef =
      FirebaseDatabase.instance.reference().child('gym_passes');
  late List<GymPass> _passes = [];

  @override
  void initState() {
    super.initState();
    _fetchGymPasses();
  }

  void _fetchGymPasses() {
    _passRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        List<GymPass> passes = [];
        values.forEach((key, value) {
          passes.add(GymPass(
            name: value['name'],
            cardNumber: value['card_number'],
            inside: value['inside'] ?? false,
          ));
        });
        setState(() {
          _passes = passes;
        });
      }
    });
  }

  void _updateInsideStatus(int index, bool inside) {
    setState(() {
      _passes[index].inside = inside;
    });
    _passRef.child(index.toString()).update({'inside': inside});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Pass Entries'),
      ),
      body: ListView.builder(
        itemCount: _passes.length,
        itemBuilder: (context, index) {
          final pass = _passes[index];
          return ListTile(
            title: Text('Name: ${pass.name}'),
            subtitle: Text('Card Number: ${pass.cardNumber}'),
            trailing: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: pass.inside ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  _updateInsideStatus(index, !pass.inside);
                },
                child: Text(
                  pass.inside ? 'Inside' : 'Outside',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
