import 'package:equatable/equatable.dart';
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

  static List<Article> articles = [
    Article(
      id: '1',
      title: 'Chai Pe Charcha',
      subtitle: 'Aliquam laoreet ante non diam suscipit accumsan. Sed vel consequat leo, non suscipit odio. Aliquam turpis',
      body: 'Chalo chai peete hain. Apnon ke saath, haas-parihaas karte hain. Chalo aaj hum sab chai par charcha karte hain. Greetings everyone. The last tea you had didnt involve the flavor of new ideas through discussions, right? So, We MUN IIIT-NR warmly invite you to join for this captivating event. This is an excellent opportunity to engage with diverse perspectives, viewpoints, and issues related to politics, geopolitics, and daily life. Were gonna have an informal, unmoderated chat about all sorts of hot topics while sipping tea. Think of it like those chai gatherings on nukkads of our country. Well you might recall the previous tea session we had during Chai pe Charcha, which was filled with controversies ranging from pseudo headlines to the Amber Heard and Johnny Depp situation. So, why think? Fill this Form to register for the event - form link. Details of the event. Venue: Amphi Theatre Date: 9/10/2023 Time: 7.30 PM. Come and get aware of what is happening around you, how people put their thoughts differently, and share their perspective on political leaders, media & social media trends around them. Lets make it an unforgettable gathering filled with great conversations and lots of laughter. Because Discussion can bring the change.',
      author: 'MUN',
      authorImageUrl: 'https://sac.iiitnr.ac.in/_next/static/media/mun_logo.2a74544b.png',
      category: 'Cultural',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/unnamed%20(1).png?alt=media&token=624321a7-a315-49af-b70e-326936ee520c',
      views: _randomDateInRange(DateTime(2023, 8, 1), DateTime(2023, 8, 31)).toString().substring(0,10), // Random date in string format
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Article(
      id: '2',
      title: 'CodeNubs',
      subtitle: 'Aliquam laoreet ante non diam suscipit accumsan. Sed vel consequat leo, non suscipit odio. Aliquam turpis',
      body: 'Hey all, To help you get started with your Competitive Programming journey, TSoC is organizing a Coding Competition on 7th November 2023 from 6:30 PM - 8:30 PM. The competition is hosted on Codeforces. The contest would be held in offline mode at CP Lab. Make sure to carry your laptops and be prepared. Follow these instructions: 1) Make an account on: (Skip if already have) 2) Add IIIT Naya Raipur to your organization, and your account should be visible on this page: 3) Try solving this problem: Youll find all the necessary details in the links above. The contest link will be shared with everyone through the mail. Happy Coding!',
      author: 'TSoC',
      authorImageUrl: 'https://sac.iiitnr.ac.in/_next/static/media/tsoc_logo.bd701a51.jpg',
      category: 'Technical',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/CODENUBS%20(Billboard%20(Square)).png?alt=media&token=94a55ac7-2a29-48a8-9950-0e593719b0c5',
      views: _randomDateInRange(DateTime(2023, 8, 1), DateTime(2023, 8, 31)).toString().substring(0,10), // Random date in string format
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Article(
      id: '3',
      title: 'Labrynth',
      subtitle: 'Aliquam laoreet ante non diam suscipit accumsan. Sed vel consequat leo, non suscipit odio. Aliquam turpis',
      body: 'Greetings from Inquizitive! We extend a heartfelt welcome to you for our eagerly anticipated treasure hunt event, LABYRINTH 3.0. Prepare yourself for an immersive and exhilarating adventure that promises to be unlike any other. Picture yourself navigating through a labyrinth of clues, each one more enigmatic than the last, as you embark on a journey of discovery and intrigue. With months of experience under your belt, can you showcase your deep understanding and intimate knowledge of our college to unravel the mysteries that lie ahead? As you delve deeper into the labyrinth, youll find yourself immersed in a world of excitement, challenge, and exhilaration. So gather your wits, sharpen your skills, and join us for an unforgettable exploration filled with twists, turns, and surprises at every corner. We look forward to seeing you there!',
      author: 'Inquizitive',
      authorImageUrl: 'https://github.com/ashut0shj/iiit-app/blob/main/assets/image/inquizitive_logo.75457948.jpg?raw=true',
      category: 'Technical',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/pasted%20image%200.png?alt=media&token=f7b80591-13f5-4fc1-9f85-afc445d726fd',
      views: _randomDateInRange(DateTime(2023, 8, 1), DateTime(2023, 8, 31)).toString().substring(0,10), // Random date in string format
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    Article(
      id: '4',
      title: 'Hands On NumPy and Pandas',
      subtitle: 'Aliquam laoreet ante non diam suscipit accumsan. Sed vel consequat leo, non suscipit odio. Aliquam turpis',
      body: 'Greetings Everyone, If youve been grappling with your AIML course projects, fret not – the AIML Club is here to provide the support you need! We are excited to unveil a highly-anticipated workshop that promises to be a game-changer for your AIML journey: the Numpy and Pandas session. Date: Thursday, November 23, 2023 Time: 6:30 P.M. onwards Venue: Room No. 135 This workshop is tailored to offer an immersive exploration of Numpy and Pandas, two essential tools for AIML practitioners. In this session, you can look forward to: Discovering the fundamentals and role of these concepts in Data Science. Gaining a profound understanding of handling arrays, indexing, and operations. Acquiring valuable insights through hands-on experience, thereby enhancing the efficiency and productivity of your projects. We will also be guiding you about how you could submit notebooks on a competitive platform. Looking forward to welcoming you and embarking on this exciting event. Note: This workshop is mandatory for First-year students. Everyone should come with their laptops.',
      author: 'AIML Club',
      authorImageUrl: 'https://github.com/ashut0shj/iiit-app/blob/main/assets/image/aiml_logo.a4c23a16.jpg?raw=true',
      category: 'Technical',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/aiml_logo.a4c23a16.jpg?alt=media&token=97d889a2-910d-4a4b-bfda-929a8e4dbe4b',
      views: _randomDateInRange(DateTime(2023, 8, 1), DateTime(2023, 8, 31)).toString().substring(0,10), // Random date in string format
      createdAt: DateTime.now().subtract(const Duration(hours: 19)),
    ),
    Article(
      id: '5',
      title: 'Clueless Gamer',
      subtitle: 'Aliquam laoreet ante non diam suscipit accumsan. Sed vel consequat leo, non suscipit odio. Aliquam turpis',
      body: 'Hello Gaming Enthusiasts, Are you ready to elevate your gaming prowess and team dynamics to new heights? Brace yourselves, as Club C2C is back with an electrifying gaming event: CLUELESS GAMER! Were on the lookout for dynamic duos – one partner with nimble fingers, a knack for gaming strategy, and lightning-quick reflexes, and the other partner armed with knowledge of hidden game secrets and handy cheat codes. Together, yoll embark on a gaming journey where cooperation is the key to victory. Think of it as a virtual adventure where one player builds, and the other explores. Your combined efforts will be essential to conquer challenges. Our lineup includes an impressive variety of games, spanning from heart-pounding first-person shooters to exhilarating sports simulations, high-speed races, and everything in between. Prepare to bring your A-game, a hearty sense of humor, and an unyielding appetite for victory! And remember, in the heat of the gaming battle, you certainly don t want to find yourself short on health potions during a critical boss fight! Event Details: Date: September 5th and 6th, 2023. (Qualification round on 5th Sept) Time: Starting at 6:30 PM Fill in the Form: Form P.S. If you havent yet found your Player 2, fret not. Well connect you with a compatible online partner whos equally enthusiastic about conquering the virtual gaming realm. In the immortal words of the legendary gamer Killjoy, Dont stress if I die. It was great knowing you all. Also, delete my hard drive.Get set for the CLUELESS GAMER challenge on September 5th and 6th! Well see you in the virtual battleground! For any queries: Panshul Senapati: 7489992873 Aseem Rai: 91688 07828 Game on, Panshul Senapati',
      author: 'C2C Club',
      authorImageUrl: 'https://github.com/ashut0shj/iiit-app/blob/main/assets/image/c2c_logo.63bd7aa9.png?raw=true',
      category: 'Cultural',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/shutterbug_logo.651ea2c1.jpeg?alt=media&token=50a74a35-5d79-49d9-82c9-e1a1e714245e',
      views: _randomDateInRange(DateTime(2023, 8, 1), DateTime(2023, 8, 31)).toString().substring(0,10), // Random date in string format
      createdAt: DateTime.now().subtract(const Duration(hours: 20)),
    ),
    Article(
      id: '6',
      title: 'Shutterbug',
      subtitle: 'Aliquam laoreet ante non diam suscipit accumsan. Sed vel consequat leo, non suscipit odio. Aliquam turpis',
      body: 'Greetings, photography enthusiasts! Are you ready to capture the world through your lens and showcase your unique perspective? Club Shutterbug is thrilled to announce our upcoming photography competition, SHUTTERBUG! This event is a celebration of creativity, imagination, and the art of visual storytelling. We invite you to participate and share your captivating photographs that reflect your vision and creativity. Whether you are a seasoned photographer or a budding enthusiast, this competition is the perfect platform to showcase your talent and passion for photography. The competition will be held in two rounds: Round 1: Online Submission Date: 10th September 2023 Time: 6:30 PM onwards Round 2: Exhibition and Judging Date: 12th September 2023 Time: 6:30 PM onwards Venue: Amphi Theatre We encourage you to explore different themes, experiment with various styles, and capture the beauty of the world around you. Let your photographs tell a story, evoke emotions, and inspire others. So, grab your cameras, unleash your creativity, and embark on a visual journey that promises to be unforgettable. For any queries, feel free to contact: Aseem Rai: 9168807828 Panshul Senapati: 7489992873 We look forward to seeing your stunning photographs and celebrating the art of photography with you! Best wishes, Club Shutterbug',
      author: 'ShutterBug Club',
      authorImageUrl: 'https://github.com/ashut0shj/iiit-app/blob/main/assets/image/c2c_logo.63bd7aa9.png?raw=true',
      category: 'Cultural',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/shutterbug_logo.651ea2c1.jpeg?alt=media&token=50a74a35-5d79-49d9-82c9-e1a1e714245e',
      views: _randomDateInRange(DateTime(2023, 8, 1), DateTime(2023, 8, 31)).toString().substring(0,10), // Random date in string format
      createdAt: DateTime.now().subtract(const Duration(hours: 20)),
    ),
    Article(
      id: '7',
      title: 'Pellentesque habitant morbi tristique senectus',
      subtitle: 'Et netus et malesuada fames',
      body: 'Nulla facilisi morbi tempus iaculis urna id volutpat lacus laoreet non',
      author: 'Jane Doe',
      authorImageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      category: 'Miscellaneous',
      imageUrl: 'https://example.com/image2.jpg',
      views: '150',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Article(
      id: '8',
      title: 'Donec commodo gravida sapien',
      subtitle: 'In fermentum odio eu feugiat',
      body: 'Fusce ut placerat orci nulla pellentesque dignissim enim sit amet venenatis',
      author: 'Alice Smith',
      authorImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      category: 'Miscellaneous',
      imageUrl: 'https://example.com/image3.jpg',
      views: '200',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      )
  ];
  @override
  List<Object?> get props => [id];

  static String _randomDateInRange(DateTime start, DateTime end) {
    final random = Random();
    final day = random.nextInt(end.difference(start).inDays) + 1;
    final date = start.add(Duration(days: day));
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
}
