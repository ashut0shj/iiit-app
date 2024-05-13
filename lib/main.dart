import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iiitnr/screens/article_screen.dart';
import 'package:iiitnr/screens/forms.dart';
import 'package:iiitnr/screens/event_form.dart'; 
// import 'package:iiitnr/screens/discover.dart';
import 'package:iiitnr/screens/grievanceresponses.dart';
import 'package:iiitnr/screens/key_form.dart';
import 'package:iiitnr/screens/resources_requisition.dart';
import 'package:iiitnr/screens/grievance_form.dart';
import 'package:iiitnr/screens/letter.dart';
import 'package:iiitnr/screens/discover_screen.dart';
import 'package:iiitnr/screens/club.dart';
import 'package:iiitnr/screens/adminform.dart';
import 'package:iiitnr/screens/event_responses.dart';
import 'package:iiitnr/screens/key_response.dart';
import 'package:iiitnr/screens/letterrespomse.dart';
import 'package:iiitnr/widgets/nav_bar.dart';
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
    
        // ArticleScreen.routeName: (context) => const ArticleScreen(),
        // AdminScreen.routeName: (context) => const AdminScreen(),
        FormsScreen.routeName: (context) => const FormsScreen(), // Remove const keyword
        EventForm.routeName: (context) => const EventForm(),
        KeyRequisitionForm.routeName: (context) => const KeyRequisitionForm(),// Add EventForm to routes
        DiscoverScreen.routeName: (context) => const DiscoverScreen(),
        // ClubScreen.routeName: (context) => const ClubScreen(),
        ResourcesRequisitionForm.routeName: (context) => const ResourcesRequisitionForm(),
        GrievanceForm.routeName: (context) => const  GrievanceForm(),
        LetterOfRecommendationForm.routeName:(context) => const LetterOfRecommendationForm(),
        EventResponsesScreen.routeName: (context) => EventResponsesScreen(),
        ExploreScreen.routeName: (context) => const ExploreScreen(),
        FormsResponsesScreen.routeName: (context) => const FormsResponsesScreen(),
        GrievanceResponsesScreen.routeName: (context) => const GrievanceResponsesScreen(),  
        LetterOfRecommendationResponsesScreen.routeName: (context) => const LetterOfRecommendationResponsesScreen(),
        KeyRequisitionResponsesScreen.routeName: (context) => const KeyRequisitionResponsesScreen(),
        ArticleScreen.routeName: (context) => const ArticleScreen(),
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
      drawer: const MyAppDrawer(),
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
                  Navigator.pushNamed(context, DiscoverScreen.routeName);
                  
                },
                child: const Center(
                  child: Text('Feed'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ExploreScreen.routeName);
                  
                },
                child: const Center(
                  child: Text('Clubs'),
                ),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, FormsResponsesScreen.routeName);
                  
                },
                child: const Center(
                  child: Text('Calender'),
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
