import 'package:action_manager/controllers/main_page_controller.dart';
import 'package:action_manager/navigation/portfolio_tab_routes.dart';
import 'package:action_manager/navigation/profile_tab_routes.dart';
import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation/map_tab_routes.dart';
import '../../navigation/marketplace_tab_routes.dart';
import '../../navigation/navigator_keys.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final mainPageController = MainPageController.instance;

  static final List<Widget> _tabPages = <Widget>[
    Navigator(
      key: NavigatorKeys.portfolio,
      initialRoute: "/",
      onGenerateRoute: PortfolioTabRoutes.generate,
    ),
    Navigator(
      key: NavigatorKeys.marketplace,
      initialRoute: "/",
      onGenerateRoute: MarketplaceTabRoutes.generate,
    ),
    Navigator(
      key: NavigatorKeys.map,
      initialRoute: "/",
      onGenerateRoute: MapTabRoutes.generate,
    ),
    Navigator(
      key: NavigatorKeys.profile,
      initialRoute: "/",
      onGenerateRoute: ProfileTabRoutes.generate,
    ),

  ];

  void _tabItemTapped(int index) {
      mainPageController.tabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: _tabPages.elementAt(mainPageController.tabIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: "Портфолио",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: "Маркет",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: "Карта",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
        ],
        currentIndex: mainPageController.tabIndex.value,
        onTap: _tabItemTapped,
        selectedItemColor: HexColor.fromHex("#554AF0"),
        unselectedItemColor: Colors.black54,
      ),
    ));
  }

}

