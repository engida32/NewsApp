import 'dart:async';

enum NavBarItem { HOME, SOURCE, SEARCH }

class BottomNavBarBlock {
  final StreamController<NavBarItem> navBarController =
      StreamController<NavBarItem>.broadcast();
  NavBarItem defaultItem = NavBarItem.HOME;
  Stream<NavBarItem> get itemStream => navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        navBarController.sink.add(NavBarItem.SOURCE);
        break;
      case 2:
        navBarController.sink.add(NavBarItem.SEARCH);

        break;
    }
  }
  close(){
    navBarController.close();
  }
}
