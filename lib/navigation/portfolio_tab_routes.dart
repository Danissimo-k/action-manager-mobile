import 'package:action_manager/ui/pages/buy_item_page.dart';
import 'package:action_manager/ui/pages/portfolio.dart';
import 'package:action_manager/ui/pages/sell_item_page.dart';
import 'package:flutter/material.dart';

class PortfolioTabRoutes {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const Portfolio());
      case "/sell":
        return MaterialPageRoute(builder: (_) => const SellItemPage());
      case "/buy":
        return MaterialPageRoute(builder: (_) => const BuyItemPage());
      default:
        return MaterialPageRoute(builder: (_) => const Portfolio());
    }
  }
}
