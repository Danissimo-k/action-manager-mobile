import 'package:action_manager/navigation/portfolio_tab_routes.dart';
import 'package:action_manager/navigation/profile_tab_routes.dart';
import 'package:action_manager/utils/hex_color.dart';
import 'package:flutter/material.dart';

import '../../navigation/map_tab_routes.dart';
import '../../navigation/marketplace_tab_routes.dart';
import '../../navigation/navigator_keys.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _tabIndex = 0;

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
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabPages.elementAt(_tabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: "Portfolio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: "Market",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _tabIndex,
        onTap: _tabItemTapped,
        selectedItemColor: HexColor.fromHex("#554AF0"),
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}