import 'package:flutter/material.dart';
import 'package:flutter_news_app_ui/screens/screens.dart';
import 'package:flutter_news_app_ui/widgets/image_container.dart';
import 'package:flutter_news_app_ui/widgets/nav_bar.dart';

import '../models/article_model.dart';
import '../widgets/bottom_nav_bar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const routeName = '/discover';

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
                'Feed',
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
  late List<Article> filteredArticles;
  late List<Article> allArticles;

  @override
  void initState() {
    super.initState();
    allArticles = Article.articles;
    filteredArticles = allArticles;
  }

  void filterArticles(String category) {
    setState(() {
      if (category == 'All') {
        filteredArticles = allArticles;
      } else {
        filteredArticles = allArticles.where((article) => article.category == category).toList();
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
            itemCount: filteredArticles.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ArticleScreen.routeName,
                    arguments: filteredArticles[index],
                  );
                },
                child: Row(
                  children: [
                    ImageContainer(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(10.0),
                      borderRadius: 5,
                      imageUrl: filteredArticles[index].imageUrl,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            filteredArticles[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.group,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                filteredArticles[index].author,
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.calendar_today,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${filteredArticles[index].views}',
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
    home: DiscoverScreen(),
  ));
}
