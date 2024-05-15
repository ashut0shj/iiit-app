import 'package:flutter/material.dart';
import 'package:iiitnr/screens/gym_card.dart';
import 'package:iiitnr/screens/gympass_entry.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GymScreen(),
    );
  }
}

class GymScreen extends StatelessWidget {
  static const String routeName = '/gym_entry_form';
  // ignore: use_super_parameters
  const GymScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, GymPassForm.routeName);
              },
              child: const Text('Gym Pass Form'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, GymPassEntriesScreen.routeName);
              },
              child: const Text('Gym Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
