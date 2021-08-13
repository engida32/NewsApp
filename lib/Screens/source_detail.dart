import 'package:flutter/material.dart';
import 'package:newsapp/bloc/get_source_news_bloc.dart';
import 'package:newsapp/model/source.dart';

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
dispose(){
  getSourcesNewsBloc.drainStream();
    super.dispose();

}
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
