import 'package:flutter/material.dart';
import 'package:newsapp/Screens/news_detail.dart';
import 'package:newsapp/bloc/get_source_news_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/article_response.dart';
import 'package:newsapp/model/source.dart';
import 'package:newsapp/style/theme.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class SourceDetail extends StatefulWidget {
  final SourceModel source;
  const SourceDetail({Key? key, required this.source}) : super(key: key);

  @override
  _SourceDetailState createState() => _SourceDetailState(source);
}

class _SourceDetailState extends State<SourceDetail> {
  late final SourceModel source;
  _SourceDetailState(this.source);
  @override
  void initState() {
    super.initState();
    getSourceNewsBloc..getSourceNews(source.id);
  }

  @override
  dispose() {
    super.dispose();
    getSourceNewsBloc.drainStreams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          backgroundColor: Style.Colors.mainColor,
          iconTheme: IconThemeData(
            color: Color(0xFF1261C8),
          ),
          title: Text(""),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 15,
            ),
            color: Style.Colors.mainColor,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Hero(
                tag: source.id,
                child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/logos/${source.id}.png"),
                              fit: BoxFit.cover,
                            )))),
              ),
              SizedBox(height: 5),
              Text(
                source.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Center(
                child: Text(
                  source.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              )
            ]),
          ),
          Expanded(
              child: StreamBuilder<ArticleResponse>(
            stream: getSourceNewsBloc.subject.stream,
            builder: (BuildContext context,
                AsyncSnapshot<ArticleResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error.length > 0) {
                  return buildErrorWidget(snapshot.data!.error);
                }
                return _buildSourceNews(snapshot.data!);
              } else if (snapshot.hasError) {
                return buildErrorWidget(snapshot.data!.error);
              } else {
                return buildLoadingWidget();
              }
            },
          ))
        ],
      ),
    );
  }

  Widget _buildSourceNews(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(" NO ARTICLES")],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetail(
                            article: articles[index],
                          )));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  color: Colors.white,
                ),
                height: 150,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(articles[index].title,
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17.0)),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                        timeUtil(DateTime.parse(
                                            articles[index].publishedAt)),
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0))
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10.0),
                        width: MediaQuery.of(context).size.width * 2 / 5,
                        height: 130,
                        child: FadeInImage.assetNetwork(
                            alignment: Alignment.topCenter,
                            placeholder: 'assets/img/placeholder.jpg',
                            image: articles[index].urlToImage,
                            imageErrorBuilder: (context, error, stacktrace) {
                              return Image.asset("assets/img/placeholder.jpg");
                            },
                            fit: BoxFit.fitHeight,
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height * 1 / 3))
                  ],
                ),
              ),
            );
          });
    }
  }
}

String timeUtil(DateTime date) {
  return timeago.format(date, allowFromNow: true, locale: 'en');
}
