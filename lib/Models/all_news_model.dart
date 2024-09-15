class AllNewsModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  AllNewsModel({this.status, this.totalResults, this.articles});

  factory AllNewsModel.fromJson(Map<String, dynamic> json) => AllNewsModel(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: (json['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json['source'] != null ? Source.fromJson(json['source']) : null,
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'] != null
            ? DateTime.parse(json['publishedAt'])
            : null,
        content: json['content'],
      );
}

class Source {
  String? name;

  Source({this.name});

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json['name'],
      );
}
