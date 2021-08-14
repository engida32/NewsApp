import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/bloc/search_bloc.dart';

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
          padding: EdgeInsets.all(19),
          child: TextFormField(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black12,
            ),
            controller: _searchController,
            onChanged: (changed) {
              searchBloc..search(_searchController.text);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey,
              suffixIcon: _searchController.text.length> 0?
               IconButton(
               icon: Icon(EvaIcons.backspaceOutline),
               onPressed: () {
                 setState(() {
                   FocusScope.of(context).requestFocus(FocusNode());
                   _searchController.clear();
                   searchBloc..search(_searchController.text);

                 });
               },):Icon(EvaIcons.searchOutline,color: Colors.grey)
            ),
          ),
        )
      ],
    );
  }
}
