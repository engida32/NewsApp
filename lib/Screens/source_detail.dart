import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_source_news_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/article_response.dart';
import 'package:newsapp/model/source.dart';
import 'package:newsapp/style/theme.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;


class _SourceDeState extends StatefulWidget {
  final SourceModel source;
  const _SourceDeState({Key? key, required this.source}) : super(key: key);

  @override
  __SourceDeStateState createState() => __SourceDeStateState(source);
}

class __SourceDeStateState extends State<_SourceDeState> {
  late final SourceModel source;
  __SourceDeStateState(this.source);
  @override
  void initState() {
    super.initState();
    getSourcesNewsBloc.getSourcesNewsBloc(source.id);
  }

  @override
  dispose() {
    super.dispose();
    getSourcesNewsBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
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
                              image: AssetImage("assets/logos/${source.id}"),
                              fit: BoxFit.cover,
                            )))
                            ),

              ),
     SizedBox(height:5),
          ]),
          ),
          Expanded(child:StreamBuilder<ArticleResponse>(
      stream: getSourcesNewsBloc.subject.stream,
      builder: (BuildContext context, AsyncSnapshot<ArticleResponse> snapshot) {
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
     )
          )],
      ),
    );
  }
 Widget  _buildSourceNews (ArticleResponse data){
   List<ArticleModel> articles = data.articles;
  if(articles.length==0){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(" NO ARTICLES")
        ],
      ),
    );
    
    }else{
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index){
          return GestureDetector(
          onTap:(){},
          child: Container(
            decoration:BoxDecoration( border:Border(
              top:BorderSide(
                color: Colors.grey,
                width:1,

              )),

           color: Colors.white,
            ),
            height:150,

                child: Row(
                 children: [
                   Container(
                     padding: EdgeInsets.all(10),
                       width:MediaQuery.of(context).size.width*3/5,
                    child:Column(
                      children: [
                        Text(
                          articles[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize:14,

                          )
                        ),
                        Expanded(child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Text(
                                timeUtil(DateTime.parse(articles[index].publishedAt),
                               ),style: TextStyle(
                                 color: Colors.black26,
                                 fontWeight: FontWeight.bold,
                                 fontSize:10,
                               )
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                   right:10,
                                ),
                                width:MediaQuery.of(context).size.width*2/5,
                                height: 35,
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/img/placeholder.jpg",
                                   image: articles[index].urlToImage,
                                    fit: BoxFit.fitHeight,
                                    width:double.maxFinite,
                                    height:MediaQuery.of(context).size.height,
                                   ),
                                  

                              )
                            ]
                          ),
                        ))
                      ]
                    )
                     
                   )
                 ], 
                )
                          ),
          
          );
        }
        
        );
    }
  }

 }

 String timeUtil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }