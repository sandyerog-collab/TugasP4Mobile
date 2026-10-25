class Article {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? url;
  final String? sourceName;
  final DateTime? publishedAt;

  Article({
    required this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.sourceName,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final image = json['urlToImage'];
    final articleUrl = json['url'];
    final source = json['source'];
    final published = json['publishedAt'];

    return Article(
      title: json['title'] is String &&
              (json['title'] as String).trim().isNotEmpty
          ? json['title'] as String
          : 'Tanpa Judul',
      description: json['description'] is String
          ? json['description'] as String
          : null,
      urlToImage: image is String &&
              image.trim().isNotEmpty &&
              Uri.tryParse(image)?.hasAbsolutePath == true &&
              (Uri.tryParse(image)?.scheme == 'https' ||
                  Uri.tryParse(image)?.scheme == 'http')
          ? image
          : null,
      url: articleUrl is String ? articleUrl : null,
      sourceName: source is Map<String, dynamic>
          ? source['name'] as String?
          : null,
      publishedAt: published is String
          ? DateTime.tryParse(published)
          : null,
    );
  }
}