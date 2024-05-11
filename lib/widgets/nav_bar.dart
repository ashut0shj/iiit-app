import 'package:flutter/material.dart';
import 'package:iiitnr/screens/screens.dart';
import 'package:iiitnr/testf.dart';
import 'package:iiitnr/screens/club.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('username'),
            accountEmail: Text('user@iiit.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(
                  Icons.person_outline, // Using Icon widget instead of IconData directly
                  size: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.rss_feed),
            title: const Text('Feed'),
            onTap: () {Navigator.pushNamed(context, DiscoverScreen.routeName);},
          ),
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('Explore'),
            onTap: () {
              Navigator.pushNamed(context, ExploreScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendar'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.pie_chart),
            title: const Text('My Events'),
            onTap: () {Navigator.pushNamed(context, DiscoverScreen.routeName);},
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('User'),
            onTap: () {Navigator.pushNamed(context, AdminScreen.routeName);},
          ),
            ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Event Form'), // Add the option for Event Form
            onTap: () {
              Navigator.pushNamed(context, EventForm.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.event_available),
            title: const Text('Event Forms'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TestForm()));
            },
          ),
        ],
      ),
    );
  }
}
