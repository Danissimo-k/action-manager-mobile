import 'package:flutter/material.dart';

import '../ui/pages/profile_page.dart';

class ProfileTabRoutes {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(builder: (_) => ProfilePage());
    }
  }
}
