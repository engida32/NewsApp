import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Screens/search_screen.dart';
import 'package:newsapp/Screens/source_screen.dart';
import 'package:newsapp/bloc/bottom_navbar_bloc.dart';
import 'package:newsapp/style/theme.dart' as Style;
import 'package:newsapp/tab/home_screen.dart';

class MainSreen extends StatefulWidget {
  MainSreen({Key? key}) : super(key: key);

  @override
  _MainSreenState createState() => _MainSreenState();
}

class _MainSreenState extends State<MainSreen> {
  late BottomNavBarBlock _navBarController;
  @override
  void initState() {
    super.initState();
    _navBarController = BottomNavBarBlock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              titleSpacing:3,
              elevation: 13,
              bottomOpacity: 0,
              centerTitle: true,
                backgroundColor: Style.Colors.mainColor,
                toolbarOpacity: 1,
                title: Text("News App",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                    )))),
        body: SafeArea(
          child: StreamBuilder<NavBarItem>(
            stream: _navBarController.itemStream,
            initialData: _navBarController.defaultItem,
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              switch (snapshot.data!) {
                case NavBarItem.HOME:
                  return HomeScreen();
                case NavBarItem.SOURCE:
                  return SourceScreen();
                case NavBarItem.SEARCH:
                  return SearchScreen();
              }
            },
          ),
        ),
        bottomNavigationBar: StreamBuilder(
          stream: _navBarController.itemStream,
          initialData: _navBarController.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 19,
                    )
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  iconSize: 20,
                  unselectedItemColor: Colors.grey,
                  selectedFontSize: 12,
                  unselectedFontSize: 10,
                  type: BottomNavigationBarType.fixed,
                  onTap: _navBarController.pickItem,
                  fixedColor: Style.Colors.mainColor,
                  currentIndex: snapshot.data!.index,
                  items: [
                    BottomNavigationBarItem(
                        title: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text("Home")),
                        icon: Icon(EvaIcons.homeOutline),
                        activeIcon: Icon(EvaIcons.home)),
                    BottomNavigationBarItem(
                        title: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text("Category")),
                        icon: Icon(EvaIcons.homeOutline),
                        activeIcon: Icon(EvaIcons.home)),
                    BottomNavigationBarItem(
                        title: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text("Search")),
                        icon: Icon(EvaIcons.homeOutline),
                        activeIcon: Icon(EvaIcons.home))
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget testScreen() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(" Test Screen")],
      ),
    );
  }
}
