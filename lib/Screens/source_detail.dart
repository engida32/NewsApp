import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_source_news_bloc.dart';
import 'package:newsapp/model/source.dart';
import 'package:newsapp/style/theme.dart' as Style;

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
          Expanded(child: )
        ],
      ),
    );
  }
}
