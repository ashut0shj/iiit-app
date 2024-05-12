import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iiitnr/screens/forms.dart';
import 'package:iiitnr/screens/event_form.dart'; // Add this import statement
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      routes: {
        // DiscoverScreen.routeName: (context) => const DiscoverScreen(),
        // ArticleScreen.routeName: (context) => const ArticleScreen(),
        // AdminScreen.routeName: (context) => const AdminScreen(),
        FormsScreen.routeName: (context) => const FormsScreen(), // Remove const keyword
        EventForm.routeName: (context) => const EventForm(),
        // ExploreScreen.routeName: (context) => const ExploreScreen(),
        // ClubScreen.routeName: (context) => const ClubScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IIIT-NR App'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Action when logo is tapped
              },
              child: Image.asset('assets/logo.png'), // Change the path to your logo
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Forms'),
              onTap: () {
                // Navigate to FormsScreen
                Navigator.pushNamed(context, FormsScreen.routeName);
              },
            ),
            ListTile(
              title: const Text('Feed'),
              onTap: () {
                // Navigate to FeedScreen
                // Navigator.pushNamed(context, DiscoverScreen.routeName);
              },
            ),
            // Add more list items for other screens
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  // Navigate to FormsScreen
                  Navigator.pushNamed(context, FormsScreen.routeName);
                },
                child: const Center(
                  child: Text('Forms'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  // Navigate to DiscoverScreen
                  // Navigator.pushNamed(context, DiscoverScreen.routeName);
                },
                child: const Center(
                  child: Text('Feed'),
                ),
              ),
            ),
          ),
          // Add more cards for other screens
        ],
      ),
    );
  }
}
