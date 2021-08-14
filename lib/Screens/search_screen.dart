import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Screens/news_detail.dart';
import 'package:newsapp/bloc/search_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/article_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchBloc..search("");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(22),
          child: TextFormField(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            controller: _searchController,
            onChanged: (changed) {
              searchBloc..search(_searchController.text);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey.shade200,
              suffixIcon: _searchController.text.length> 0?
               IconButton(
               icon: Icon(EvaIcons.backspaceOutline),
               onPressed: () {
                 setState(() {
                   FocusScope.of(context).requestFocus(FocusNode());
                   _searchController.clear();
                   searchBloc..search(_searchController.text);

                 });
               },):Icon(EvaIcons.searchOutline,color: Colors.grey.shade500,size:20),
               enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(
                   color: Colors.grey.shade100.withOpacity(0.3)
                 ),
                 borderRadius: BorderRadius.circular(30)
               ),
               focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(30)
               ),
               contentPadding: EdgeInsets.only(
                 left:15,
                 right: 10,
               ),
               labelText: "Search News ....",
               hintStyle: TextStyle(
                 fontSize:14,
                 color: Colors.grey,
                 fontWeight: FontWeight.w500
               ),
               labelStyle: TextStyle(
                 fontSize:14,
                 color: Colors.grey,
                 fontWeight: FontWeight.w500
               )
            ),
            autocorrect: false,
            autovalidateMode:AutovalidateMode.always,

          ),
        ),
        Expanded(
          
          child:StreamBuilder<ArticleResponse>(
      stream: searchBloc.subject.stream,
      builder: (BuildContext context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildSearchNews (snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    ) )
      ],
    );
  }
   Widget _buildSearchNews(ArticleResponse data) {
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