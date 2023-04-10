import 'package:action_manager/ui/pages/marketplace_page.dart';
import 'package:flutter/material.dart';

import '../ui/pages/buy_item_page.dart';

class MarketplaceTabRoutes {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Marketplace());
      case "/buy":
        return MaterialPageRoute(builder: (_) => BuyItemPage());
      default:
        return MaterialPageRoute(builder: (_) => Marketplace());
    }
  }
}
