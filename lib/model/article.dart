import 'package:newsapp/model/source.dart';

class ArticleModel {
  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String img;
  final String date;
  final String content;

  ArticleModel(this.author, this.title, this.description, this.url, this.img,
      this.date, this.content, this.source);
  ArticleModel.fromJson(Map<String, dynamic> json)
      : author = json["author"],
        title = json["title"],
        description = json["description"],
        url = json["url"],
        img = json["img"],
        date = json["date"],
        content = json["content"],
        source =SourceModel.fromJson(json["source"]);
}
