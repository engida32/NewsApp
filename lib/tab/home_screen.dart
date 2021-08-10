import 'package:flutter/material.dart';
import 'package:newsapp/widget/headline_slider.dart';
import 'package:newsapp/widget/hot_news.dart';
import 'package:newsapp/widget/top_channel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadLineSliderWidget(),
        Row(
          children: <Widget>[
            Text(
              "Top channels",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
          
          ],
        ),
        TopChannel(),
             Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
              children: <Widget>[
                Text("Hot news", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),),  
              ],
            ),
        ),
        HotNews(),
      ],
    );
  }
}
