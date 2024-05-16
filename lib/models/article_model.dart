import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final String views; // Changed the type to String
  final DateTime createdAt;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.views, // Changed the type to String
    required this.createdAt,
  });

  static List<Article> articles = [];

  static Future<List<Article>> fetchArticlesFromFirebase() async {
    List<Article> fetchedArticles = [];

    try {
      DatabaseReference articlesRef =
          FirebaseDatabase.instance.reference().child('articles');
      DataSnapshot snapshot = await articlesRef.once();
      if (snapshot.value != null) {
        Map<dynamic, dynamic> articlesData = snapshot.value;
        articlesData.forEach((key, value) {
          fetchedArticles.add(Article.fromMap(key, value));
        });
      }
    } catch (error) {
      print('Error fetching articles: $error');
    }

    return fetchedArticles;
  }

  factory Article.fromMap(String id, Map<dynamic, dynamic> map) {
    return Article(
      id: id,
      title: map['eventName'] ?? '',
      subtitle: map['eventDescription'] ?? '',
      body: map['eventDescription'] ?? '',
      author: '', // You can set author if available in Firebase
      authorImageUrl: '', // You can set author image URL if available in Firebase
      category: '', // You can set category if available in Firebase
      imageUrl: '', // You can set image URL if available in Firebase
      views: map['selectedDate'] ?? '',
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [id];

  static String _randomDateInRange(DateTime start, DateTime end) {
    final random = Random();
    final day = random.nextInt(end.difference(start).inDays) + 1;
    final date = start.add(Duration(days: day));
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
}

void main() async {
  // Fetch articles from Firebase
  List<Article> articles = await Article.fetchArticlesFromFirebase();

  // Use the fetched articles list
  for (Article article in articles) {
    print('Title: ${article.title}');
    print('Subtitle: ${article.subtitle}');
    print('Body: ${article.body}');
    print('Views: ${article.views}');
    print('Created At: ${article.createdAt}');
    print('Author: ${article.author}');
    print('Author Image URL: ${article.authorImageUrl}');
    print('Category: ${article.category}');
    print('Image URL: ${article.imageUrl}');
    print('ID: ${article.id}');
    print('-----------------------------');
  }
}
