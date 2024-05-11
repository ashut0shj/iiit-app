import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_app_ui/screens/club.dart';
import 'package:flutter_news_app_ui/screens/club_screen.dart';

import 'screens/screens.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
      initialRoute:
          ExploreScreen.routeName, // Set DiscoverScreen as the initial route
      routes: {
        DiscoverScreen.routeName: (context) =>
            const DiscoverScreen(), // Use DiscoverScreen as the initial route
        ArticleScreen.routeName: (context) => const ArticleScreen(),
        ClubScreen.routeName: (context) => const ClubScreen(),
        AdminScreen.routeName: (context) => const AdminScreen(),
        ExploreScreen.routeName: (context) => const ExploreScreen(),
      },
    );
  }
}
