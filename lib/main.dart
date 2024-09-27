import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'galleries/image_gallery.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Load the environment variables
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixabay Gallery',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ImageGallery(),
    );
  }
}
