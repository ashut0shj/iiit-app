import 'package:flutter/material.dart';
import 'package:flutter_news_app_ui/models/club_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article_model.dart';
import '../widgets/custom_tag.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({Key? key}) : super(key: key);

  static const routeName = '/club';
  @override
  Widget build(BuildContext context) {
    final club = ModalRoute.of(context)!.settings.arguments as Clubs;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final imageHeight = screenHeight - appBarHeight - statusBarHeight;
    final imageWidth = screenWidth;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: imageHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                club.imageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _NewsBody(club: club),
          ),
        ],
      ),
    );
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({
    Key? key,
    required this.club,
  }) : super(key: key);

  final Clubs club;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomTag(
                backgroundColor: Colors.black,
                children: [
                  const SizedBox(width: 10),
                  Text(
                    club.title,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              CustomTag(
                backgroundColor: Colors.grey.shade200,
                children: const [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            club.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            club.subtitle,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          Text(
            club.body,
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => launchUrl(Uri.parse(
                    'https://docs.google.com/forms/d/1RD3cAPM7HWpZo622atupB099lUpij5QF9bvBr5vRfmA/viewform?edit_requested=true')),
                child: const Text('Register'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle add to calendar button press
                },
                child: const Text('Add to Calendar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
