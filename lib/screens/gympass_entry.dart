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

class _GymPassEntriesScreenState extends State<GymPassEntriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<GymPass> _passes = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchGymPasses();
  }

  void _fetchGymPasses() {
    DatabaseReference passRef =
        FirebaseDatabase.instance.reference().child('gym_passes');
    passRef.onValue.listen((event) {
      _passes.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            GymPass pass = GymPass(
              name: value['name'] ?? '',
              cardNumber: value['card_number'] ?? '',
              inside: value['inside'] ?? false,
            );
            _passes.add(pass);
          });
          setState(() {});
        }
      }
    });
  }

  void _updateGymPassStatus(GymPass pass, bool inside) {
    pass.inside = inside;
    DatabaseReference passRef =
        FirebaseDatabase.instance.reference().child('gym_passes');
    passRef.child(pass.cardNumber).update({
      'inside': inside,
    }).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Pass Entries'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Inside'),
            Tab(text: 'Outside'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPassList(inside: true),
          _buildPassList(inside: false),
        ],
      ),
    );
  }

  Widget _buildPassList({required bool inside}) {
    final filteredPasses =
        _passes.where((pass) => pass.inside == inside).toList();
    return ListView.builder(
      itemCount: filteredPasses.length,
      itemBuilder: (context, index) {
        final pass = filteredPasses[index];
        return ListTile(
          title: Text('Name: ${pass.name}'),
          subtitle: Text('Card Number: ${pass.cardNumber}'),
          trailing: Switch(
            value: pass.inside,
            onChanged: (value) {
              _updateGymPassStatus(pass, value);
            },
          ),
        );
      },
    );
  }
}
