import 'package:equatable/equatable.dart';


class Clubs extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String category;
  final String imageUrl;

  const Clubs({
    required this.id,
    required this.title,
    required this.body,
    required this.subtitle,
    required this.category,
    required this.imageUrl,
  });

  static List<Clubs> clubs = [
    const Clubs(
      id: '1',
      title: 'MUN',
      subtitle: "Model Unied Nation",
      body:
          'Chalo chai peete hain. Apnon ke saath, haas-parihaas karte hain. Chalo aaj hum sab chai par charcha karte hain. Greetings everyone. The last tea you had didnt involve the flavor of new ideas through discussions, right? So, We MUN IIIT-NR warmly invite you to join for this captivating event. This is an excellent opportunity to engage with diverse perspectives, viewpoints, and issues related to politics, geopolitics, and daily life. Were gonna have an informal, unmoderated chat about all sorts of hot topics while sipping tea. Think of it like those chai gatherings on nukkads of our country. Well you might recall the previous tea session we had during Chai pe Charcha, which was filled with controversies ranging from pseudo headlines to the Amber Heard and Johnny Depp situation. So, why think? Fill this Form to register for the event - form link. Details of the event. Venue: Amphi Theatre Date: 9/10/2023 Time: 7.30 PM. Come and get aware of what is happening around you, how people put their thoughts differently, and share their perspective on political leaders, media & social media trends around them. Lets make it an unforgettable gathering filled with great conversations and lots of laughter. Because Discussion can bring the change.',
      category: 'Cultural',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/mun_logo.png?alt=media&token=92cb1b98-c8d0-4679-9d1d-77994911a631',
      // Random date in string format
    ),
    const Clubs(
      id: '2',
      title: 'TSoC',
      subtitle: "The Society Of Coders",
      body:
          'Chalo chai peete hain. Apnon ke saath, haas-parihaas karte hain. Chalo aaj hum sab chai par charcha karte hain. Greetings everyone. The last tea you had didnt involve the flavor of new ideas through discussions, right? So, We MUN IIIT-NR warmly invite you to join for this captivating event. This is an excellent opportunity to engage with diverse perspectives, viewpoints, and issues related to politics, geopolitics, and daily life. Were gonna have an informal, unmoderated chat about all sorts of hot topics while sipping tea. Think of it like those chai gatherings on nukkads of our country. Well you might recall the previous tea session we had during Chai pe Charcha, which was filled with controversies ranging from pseudo headlines to the Amber Heard and Johnny Depp situation. So, why think? Fill this Form to register for the event - form link. Details of the event. Venue: Amphi Theatre Date: 9/10/2023 Time: 7.30 PM. Come and get aware of what is happening around you, how people put their thoughts differently, and share their perspective on political leaders, media & social media trends around them. Lets make it an unforgettable gathering filled with great conversations and lots of laughter. Because Discussion can bring the change.',
      category: 'Technical',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/tsoc_logo.jpg?alt=media&token=653ffdf2-f4de-4e4c-90c7-1c4d97d19a57',
      // Random date in string format
    ),
    const Clubs(
      id: '3',
      title: 'AIML',
      subtitle: "AIML",
      body:
          'Chalo chai peete hain. Apnon ke saath, haas-parihaas karte hain. Chalo aaj hum sab chai par charcha karte hain. Greetings everyone. The last tea you had didnt involve the flavor of new ideas through discussions, right? So, We MUN IIIT-NR warmly invite you to join for this captivating event. This is an excellent opportunity to engage with diverse perspectives, viewpoints, and issues related to politics, geopolitics, and daily life. Were gonna have an informal, unmoderated chat about all sorts of hot topics while sipping tea. Think of it like those chai gatherings on nukkads of our country. Well you might recall the previous tea session we had during Chai pe Charcha, which was filled with controversies ranging from pseudo headlines to the Amber Heard and Johnny Depp situation. So, why think? Fill this Form to register for the event - form link. Details of the event. Venue: Amphi Theatre Date: 9/10/2023 Time: 7.30 PM. Come and get aware of what is happening around you, how people put their thoughts differently, and share their perspective on political leaders, media & social media trends around them. Lets make it an unforgettable gathering filled with great conversations and lots of laughter. Because Discussion can bring the change.',
      category: 'Technical',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/aiml_logo.a4c23a16.jpg?alt=media&token=97d889a2-910d-4a4b-bfda-929a8e4dbe4b',
      // Random date in string format
    ),
    const Clubs(
      id: '4',
      title: 'Indradhanush',
      subtitle: "Arts & Crafts",
      body:
          'Chalo chai peete hain. Apnon ke saath, haas-parihaas karte hain. Chalo aaj hum sab chai par charcha karte hain. Greetings everyone. The last tea you had didnt involve the flavor of new ideas through discussions, right? So, We MUN IIIT-NR warmly invite you to join for this captivating event. This is an excellent opportunity to engage with diverse perspectives, viewpoints, and issues related to politics, geopolitics, and daily life. Were gonna have an informal, unmoderated chat about all sorts of hot topics while sipping tea. Think of it like those chai gatherings on nukkads of our country. Well you might recall the previous tea session we had during Chai pe Charcha, which was filled with controversies ranging from pseudo headlines to the Amber Heard and Johnny Depp situation. So, why think? Fill this Form to register for the event - form link. Details of the event. Venue: Amphi Theatre Date: 9/10/2023 Time: 7.30 PM. Come and get aware of what is happening around you, how people put their thoughts differently, and share their perspective on political leaders, media & social media trends around them. Lets make it an unforgettable gathering filled with great conversations and lots of laughter. Because Discussion can bring the change.',
      category: 'Cultural',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/iiitapp.appspot.com/o/shutterbug_logo.651ea2c1.jpeg?alt=media&token=50a74a35-5d79-49d9-82c9-e1a1e714245e',
      // Random date in string format
    ),
  ];

  @override
  List<Object?> get props => [id];
}
