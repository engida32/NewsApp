import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_hotnews_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/article_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class HotNews extends StatefulWidget {
  const HotNews({Key? key}) : super(key: key);

  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    getHotnewsBloc..getHotNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getHotnewsBloc.subject.stream,
      builder: (BuildContext context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return buildHotNewsWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildHotNewsWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    if (articles.length < 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              " No More HotNews",
              style: TextStyle(color: Colors.black12),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: articles.length / 2 * 210,
        padding: EdgeInsets.all(5),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.85),
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 1),
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(1, 1),
                            )
                          ]),
                      child: Column(
                        children: [
                          AspectRatio(
                              aspectRatio: 16 / 9,
                              child:
                                  // Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.only(
                                  //     topLeft: Radius.circular(5),
                                  //     topRight: Radius.circular(5),

                                  //   ),
                                  //   // image: DecorationImage(
                                  //   //   image:NetworkImage(articles[index].urlToImage),
                                  //   //   fit: BoxFit.cover,

                                  //   // )

                                  // )
                                  FadeInImage(
                                fadeInCurve: Curves.bounceInOut,
                                fit: BoxFit.cover,
                                image: NetworkImage(articles[index].urlToImage),
                                placeholder:
                                    AssetImage("assets/img/placeholder.jpg"),
                                imageErrorBuilder:
                                    (context, error, stacktrace) {
                                  return Image.asset(
                                      "assets/img/placeholder.jpg");
                                      
                                },
                                
                              )),
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 15),
                            child: Text(
                              articles[index].title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                height: 1.3,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                color: Colors.black12,
                              ),
                              Container(
                                width: 30,
                                height: 3,
                                color: Color(0xfff6511d),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    articles[index].source.name,
                                    style: TextStyle(
                                      color: Color(0xfff6511d),
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    timeUtil(DateTime.parse(
                                        articles[index].publishedAt)),
                                    style: TextStyle(
                                      color: Color(0xfff6511d),
                                      fontSize: 10,
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                    )),
              );
            }),
      );
    }
  }

  String timeUtil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
