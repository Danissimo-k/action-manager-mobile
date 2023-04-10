import 'package:action_manager/controllers/portfolio_controller.dart';
import 'package:action_manager/models/currency.dart';
import 'package:action_manager/models/market_item.dart';
import 'package:action_manager/models/stock.dart';
import 'package:action_manager/repository/market_repository.dart';
import 'package:action_manager/repository/portfolio_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyItemController extends GetxController {
  static BuyItemController get instance => Get.find();
  final counter = Rx<num>(0);
  final item = Rx<MarketItem?>(null);

  final textCounterController = TextEditingController(text: '0');

  String? get type => Get.parameters['type'];

  String? get figi => Get.parameters['figi'];

  num get itemQuantity {
    if(item.value == null) return 0;

    switch (type) {
      case 'stock':
        return PortfolioRepository.instance.stocks.value[(item.value as StockModel).figi] ?? 0;
      case 'currency':
        return PortfolioRepository.instance.currencies.value[(item.value as CurrencyModel).figi] ?? 0;
      default:
        return 0;
    }
  }

  @override
  void onReady() {
    var listOfItems = <MarketItem>[];
    switch (type) {
      case 'stock':
        listOfItems = MarketRepository.instance.stocks.value;
        break;
      case 'currency':
        listOfItems = MarketRepository.instance.currencies.value;
        break;
      default:
        listOfItems = [];
        break;
    }
    final filteredList = listOfItems.where((element) => element.figi == figi);
    item(filteredList.isNotEmpty ? filteredList.first : null);
    super.onReady();
  }
}
