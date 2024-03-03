import 'package:flutter/material.dart';

import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IIIT-Student App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: DiscoverScreen.routeName, // Set DiscoverScreen as the initial route
      routes: {
        DiscoverScreen.routeName: (context) => const DiscoverScreen(), // Use DiscoverScreen as the initial route
        ArticleScreen.routeName: (context) => const ArticleScreen(),
        AdminScreen.routeName: (context) => const AdminScreen(),
      },
    );
  }
}
