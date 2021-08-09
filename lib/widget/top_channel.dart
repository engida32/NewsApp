import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_source_bloc.dart';
import 'package:newsapp/model/source.dart';
import 'package:newsapp/model/source_response.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';

class TopChannel extends StatefulWidget {
  const TopChannel({Key? key}) : super(key: key);

  @override
  _TopChannelState createState() => _TopChannelState();
}

class _TopChannelState extends State<TopChannel> {
  @override
  void initState() {
    super.initState();
    getSourcesBloc.getSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourcesBloc.subject.stream,
      builder: (BuildContext context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return buildTopChannel(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildTopChannel(SourceResponse data) {
    List<SourceModel> sources = data.sources;
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text("No Source"),
          ],
        ),
      );
    } else {
      return Container(
        height: 115,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.only(
                    top: 80,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: sources[index].id,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                )
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/logos/${sources[index].id}.png"))),
                        ),
                      ),
                      SizedBox(height: 10),

                    Text(sources[index].name),
                    maxLines:2,
                    textAlign:TextAlign.center,
                    style:TextStyle(
                      height:1.4,
                      color:Colors.black,
                      fontWeight:FontWeight.bold,
                      fontSize:10,
                    )

                    ],

                  ));
            }),
      );
    }
  }
}
