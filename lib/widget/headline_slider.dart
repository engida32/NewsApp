import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
          if (snapshot.data!.error!= null && snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildHeadLineSlider(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
         return  buildLoadingWidget();
        }
     
      },
    );
  }

  Widget _buildHeadLineSlider(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: false,
        viewportFraction: 0.9,
        height: 200,
      ),
      items: getSliderItem(articles),
    ));
  }

  getSliderItem(List<ArticleModel> articles) {
    return articles
        .map((article) => GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
                bottom: 10,
              ),
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.cover, 
                        //image: NetworkImage(article.img)
                        image:AssetImage("assets/images/placeholder.jpg")

                        ),
                  )),
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
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: 250,
                          child: Column(
                            children: [
                              Text(article.title,
                                  style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ))),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      child: (Text(
                        timeAgo(DateTime.parse(article.date)),
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 9,
                        ),
                      )))
                ],
              ),
            )))
        .toList();
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
