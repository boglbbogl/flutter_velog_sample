class PiscumPhotoModel {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  PiscumPhotoModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });
  // PiscumPhotoModel.fromJson(Map<String, dynamic> json)
  //     : id = json["id"],
  //       author = json["author"],
  //       width = json["width"],
  //       height = json["height"],
  //       url = json["url"],
  //       downloadUrl = json["download_url"];

  factory PiscumPhotoModel.fromJson(Map<String, dynamic> json) {
    return PiscumPhotoModel(
      id: json["id"],
      author: json["author"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
      downloadUrl: json["download_url"],
    );
  }
}
