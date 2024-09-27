import 'package:flutter/material.dart';
import '../models/image_data.dart';

/// Widget that represents a single image tile.
class ImageTile extends StatelessWidget {
  final ImageData image;

  const ImageTile({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${image.likes} Likes',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${image.views} Views'),
        ],
      ),
    );
  }
}
