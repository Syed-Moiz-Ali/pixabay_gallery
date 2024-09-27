import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../services/api_service.dart';
import '../models/image_data.dart';
import '../widgets/image_tile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// The main gallery widget that fetches and displays images.
class ImageGallery extends StatefulWidget {
  const ImageGallery({Key? key}) : super(key: key);

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late ApiService _apiService; // API service instance
  List<ImageData> _images = []; // List to store fetched images
  int _page = 1; // Current page for pagination
  bool _loading = false; // Loading state
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _fetchImages();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Fetch images from the API.
  Future<void> _fetchImages() async {
    _apiService = ApiService(dotenv.env['PIXABAY_API_KEY']!);
    if (_loading) return;

    setState(() {
      _loading = true; // Set loading to true
    });

    try {
      List<ImageData> newImages = await _apiService.fetchImages(_page);
      setState(() {
        _images.addAll(newImages);
        _page++; // Increment page for next fetch
        _loading = false; // Reset loading state
      });
    } catch (e) {
      // Handle errors as needed
      setState(() {
        _loading = false; // Reset loading state
      });
    }
  }

  /// Listener for scroll events to trigger loading more images.
  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_loading) {
      _fetchImages(); // Fetch more images when scrolled to the bottom
    }
  }

  @override
  Widget build(BuildContext context) {
    int columns = (MediaQuery.of(context).size.width / 150).floor();
    return Scaffold(
      appBar: AppBar(title: const Text('Pixabay Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.builder(
          controller: _scrollController,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
          ),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return ImageTile(image: _images[index]); // Build image tile
          },
        ),
      ),
    );
  }
}
