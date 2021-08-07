import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_top_headlines_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/article_response.dart';

class HeadLineSliderWidget extends StatefulWidget {
  const HeadLineSliderWidget({Key? key}) : super(key: key);

  @override
  _HeadLineSliderWidgetState createState() => _HeadLineSliderWidgetState();
}

class _HeadLineSliderWidgetState extends State<HeadLineSliderWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopHeadlinesBloc.getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (BuildContext context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildLinearSlider(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLinearSlider(ArticleResponse data) {
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
    return articles.map((article) => GestureDetector(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: 10,
        ))));
  }
}