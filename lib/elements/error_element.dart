import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return Container(
    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      //CUSTOM ERROR MESSAGE
      Center(
        child: Text("ERROR LOADING.....",
         style:TextStyle(
           fontSize:33,
           color: Colors.red,
           inherit: true,
           fontWeight: FontWeight.w200,
         )),
      )
    ],
    )

 
  );
}
