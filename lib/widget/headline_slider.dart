import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Screens/news_detail.dart';
import 'package:newsapp/bloc/get_top_headlines_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/article_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadLineSliderWidget extends StatefulWidget {
  const HeadLineSliderWidget({Key? key}) : super(key: key);

  @override
  _HeadLineSliderWidgetState createState() => _HeadLineSliderWidgetState();
}

class _HeadLineSliderWidgetState extends State<HeadLineSliderWidget> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesBloc.getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (BuildContext context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildHeadLineSlider(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHeadLineSlider(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;

    return Container(
        padding: EdgeInsets.only(top:4),
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: false,
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayInterval:Duration(seconds: 5),
            height: 250,
          ),
          items: getSliderItem(articles),
        ));
  }

  getSliderItem(List<ArticleModel> articles) {
    // print(articles.publishedAt.toString());
    return articles
        .map(
          (article) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetail(
                            article: article,
                          )));
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
                bottom: 10,
              ),
              child: Stack(
                children: [
                  Container(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/img/placeholder.jpg',
                        image: article.urlToImage==null ? 'assets/img/placeholder.jpg' 
                        :article.urlToImage,
                       // image:  'https://www.industry.gov.au/sites/default/files/August%202018/image/news-placeholder-738.png',
                        imageErrorBuilder: (context, error, stacktrace) {
                          return Image.asset("assets/img/placeholder.jpg");
                        },
                      fit: BoxFit.cover,

                      ),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.all(Radius.circular(8)),
                      //   shape: BoxShape.rectangle,
                      //   image: new DecorationImage(
                      //       fit: BoxFit.cover,
                      //       image: NetworkImage(article.urlToImage)),
                      // )
                      ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.white.withOpacity(0),
                              ]))),
                  Positioned(
                      bottom: 30,
                      child: Container(
                        alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: 250,
                          child: Column(
                            
                            children: [
                              Text(article.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    
                                    height: 1.5,
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ))),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        timeUtil(DateTime.parse(article.publishedAt)),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ))
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String timeUtil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
