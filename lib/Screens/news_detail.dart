import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/style/theme.dart' as Style;
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final ArticleModel article;
  const NewsDetail({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState(article);
}

class _NewsDetailState extends State<NewsDetail> {
  final ArticleModel article;
  _NewsDetailState(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launch(article.url);
        },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          color: Style.Colors.mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Read More",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:15
                  ))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        primary: false,
        elevation: 0,
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          article.title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        
        children: [
          
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/img/placeholder.jpg',
              image: article.urlToImage==null ? 'assets/img/placeholder.jpg' 
                        :article.urlToImage,
              //image:'https://eliaswondimu.com/wp-content/uploads/2020/01/placeholder.png' ,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stacktrace) {
                return Image.asset("assets/img/placeholder.jpg");
              },
            ),
          ),
          Container(
            
            padding: EdgeInsets.all(10),
            child: Column(
           mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SizedBox(
                  height: 10,
                ),
                Text(article.publishedAt.substring(0, 10),
                    style: TextStyle(
                      color: Style.Colors.mainColor,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(article.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 10,
                ),
                Html(data: article.content==null ? " ": article.content,
                renderNewlines: true,
                shrinkToFit: true,
                showImages: true,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
