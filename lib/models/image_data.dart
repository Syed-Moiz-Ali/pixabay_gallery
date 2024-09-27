/// Model class for image data.
class ImageData {
  final String url; // Image URL
  final int likes; // Number of likes
  final int views; // Number of views

  ImageData({required this.url, required this.likes, required this.views});

  /// Factory method to create an ImageData instance from JSON.
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      url: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }
}
