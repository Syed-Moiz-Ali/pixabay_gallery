import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_data.dart';

class ApiService {
  final String apiKey;

  ApiService(this.apiKey);

  /// Fetch images from the Pixabay API.
  Future<List<ImageData>> fetchImages(int page) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=$apiKey&image_type=photo&per_page=20&page=$page'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['hits'];
      return data.map((json) => ImageData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
