import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        gradient: new LinearGradient(
            colors: [Colors.red.shade200, Colors.cyan.shade900],
            begin: Alignment.center,
            end: new Alignment(-1.0, -1.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //CUSTOM ERROR MESSAGE
          Center(
            child: Text("ERROR LOADING.....",
                style: TextStyle(
                  fontSize: 33,
                  color: Colors.blueGrey,
                  inherit: true,
                  fontWeight: FontWeight.w200,
                )),
          )
        ],
      ));
}
