class InfinityImageModel {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  InfinityImageModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });
  factory InfinityImageModel.fromJson(Map<String, dynamic> json) {
    return InfinityImageModel(
      id: json["id"],
      author: json["author"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
      downloadUrl: json["download_url"],
    );
  }
}
