import 'package:newsapp/model/source.dart';

class ArticleModel {
  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String  publishedAt;
  final String content;

  ArticleModel(this.author, this.title, this.description, this.url, this.urlToImage,
      this.publishedAt, this.content, this.source);
  ArticleModel.fromJson(Map<String, dynamic> json)
      :        
       source =SourceModel.fromJson(json["source"]),
        author = json["author"],
        title = json["title"],
        description = json["description"],
        url = json["url"],
        urlToImage = json["urlToImage"],
        publishedAt = json["publishedAt"],
        content = json["content"];
}
