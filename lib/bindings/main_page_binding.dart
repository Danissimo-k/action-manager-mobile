import 'package:action_manager/controllers/map_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_page_controller.dart';
import '../controllers/market_controller.dart';
import '../controllers/portfolio_controller.dart';
import '../repository/market_repository.dart';
import '../repository/portfolio_repository.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
    Get.lazyPut(() => MarketRepository());
    Get.lazyPut(() => MarketController());
    Get.lazyPut(() => PortfolioRepository());
    Get.lazyPut(() => PortfolioController());
    Get.lazyPut(() => MapController());
  }
}