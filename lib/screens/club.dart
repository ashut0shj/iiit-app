import 'package:flutter/material.dart';
import 'package:iiitnr/models/club_model.dart';
import 'package:iiitnr/screens/club_screen.dart';
import 'package:iiitnr/screens/screens.dart';
import 'package:iiitnr/widgets/image_container.dart';
import 'package:iiitnr/widgets/nav_bar.dart';

import '../models/article_model.dart';
import '../widgets/bottom_nav_bar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  static const routeName = '/explore';

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['All', 'Technical', 'Cultural', 'Miscellaneous'];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              );
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Club',
                style: TextStyle(color: Colors.black),
              ),
              Image.asset(
                'assets/logo.png',
                width: 50,
                height: 50,
              ),
            ],
          ),
        ),
        drawer: const MyAppDrawer(),
        bottomNavigationBar: const BottomNavBar(index: 1),
        body: _CategoryNews(tabs: tabs),
      ),
    );
  }
}

class _CategoryNews extends StatefulWidget {
  const _CategoryNews({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabs;

  @override
  __CategoryNewsState createState() => __CategoryNewsState();
}

class __CategoryNewsState extends State<_CategoryNews> {
  late List<Clubs> filteredClubs;
  late List<Clubs> allClubs;

  @override
  void initState() {
    super.initState();
    allClubs = Clubs.clubs;
    filteredClubs = allClubs;
  }

  void filterArticles(String category) {
    setState(() {
      if (category == 'All') {
        filteredClubs = allClubs;
      } else {
        filteredClubs =
            allClubs.where((article) => article.category == category).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          indicatorColor: Colors.black,
          tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
          onTap: (index) {
            filterArticles(widget.tabs[index]);
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredClubs.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ClubScreen.routeName,
                    arguments: filteredClubs[index],
                  );
                },
                child: Row(
                  children: [
                    ImageContainer(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(10.0),
                      borderRadius: 5,
                      imageUrl: filteredClubs[index].imageUrl,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            filteredClubs[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                filteredClubs[index].subtitle,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ExploreScreen(),
  ));
}
