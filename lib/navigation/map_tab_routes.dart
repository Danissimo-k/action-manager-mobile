import 'package:action_manager/ui/pages/map_page.dart';
import 'package:flutter/material.dart';

class MapTabRoutes {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => MapPage());
      default:
        return MaterialPageRoute(builder: (_) => MapPage());
    }
  }
}