 import 'package:flutter/material.dart';
import 'package:newsapp/widget/headline_slider.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({ Key? key }) : super(key: key);
 
   @override
   _HomeScreenState createState() => _HomeScreenState();
 }
 
 class _HomeScreenState extends State<HomeScreen> {
   @override
   Widget build(BuildContext context) {
     return ListView(
       children: [
         HeadLineSliderWidget(),
       ],
     );
   }
 }