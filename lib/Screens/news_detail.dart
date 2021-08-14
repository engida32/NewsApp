import 'package:flutter/material.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/style/theme.dart' as Style;

class NewsDetail extends StatefulWidget {
  final ArticleModel article;
  const NewsDetail({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState(article);
}

class _NewsDetailState extends State<NewsDetail> {
  late final ArticleModel article;
  _NewsDetailState(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          article.title,
          style: TextStyle(
            fontSize:14,
            color: Colors.white,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      body: ListView(

        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/img/placeholder.jpg',
             image: article.urlToImage,
             fit:BoxFit.cover,

             ),
            
            ),
            Container(
              padding:EdgeInsets.all(10),
              
            )
        ],
      ),
    );
  }
}
