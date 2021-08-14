import 'package:flutter/material.dart';
import 'package:newsapp/Screens/source_detail.dart';
import 'package:newsapp/bloc/get_source_bloc.dart';
import 'package:newsapp/elements/error_element.dart';
import 'package:newsapp/elements/loading_element.dart';
import 'package:newsapp/model/source.dart';
import 'package:newsapp/model/source_response.dart';

class SourceScreen extends StatefulWidget {
  const SourceScreen({Key? key}) : super(key: key);

  @override
  _SourceScreenState createState() => _SourceScreenState();

}

class _SourceScreenState extends State<SourceScreen> {
    void initState() {
    super.initState();
    getSourcesBloc..getSources();
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
          return buildSource(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget("ERROR LOADING DATA FROM SOURCE");
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }
  Widget buildSource(SourceResponse data) {
    List<SourceModel> sources= data.sources;
    return GridView.builder(
      itemCount: sources.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      childAspectRatio: 0.86),
       itemBuilder: (context,index) {
         return Padding(padding: EdgeInsets.only(
           left: 5,
           right: 5,
           top: 10
         ),
         child: GestureDetector(
           onTap: (){
               Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SourceDetail(
                                    source: sources[index],
                                  )));
           },
           child: Container(
             width:100,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(5)),
               boxShadow:[
              BoxShadow( 
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(1, 1),
              
              )
               ] 

             ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: sources[index].id,
             child: Container(
               padding: EdgeInsets.only(
                 left: 10,
                 right: 10,
                 top: 15,
                 bottom: 15,
               ),
               child: Text(
                 sources[index].name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    
                  )
               ),
             ))
          ],
        ),

           ),
           ),
         );
       }
       
       );
  }
}
