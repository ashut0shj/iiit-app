import 'package:flutter/material.dart';


class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min
            children: [
              Container(
                padding: const EdgeInsets.all(4.0), // Adjust padding as needed
                child: const Icon(
                  Icons.home,
                  size: 50.0, // Adjust icon size as needed
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 20.0), // Adding gap between icon and text
              const Text(
                'admin roles',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          const SizedBox(height: 10.0), // Adding gap between icon and rectangle
          Container(
            width: 200.0, // Adjust width of the rectangle as needed
            height: 50.0, // Adjust height of the rectangle as needed
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(0.0), // Adjust border radius as needed
            ),
          ),
        ],
      ),
    );
  }
}