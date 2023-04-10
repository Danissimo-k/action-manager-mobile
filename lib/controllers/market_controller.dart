import 'package:action_manager/models/currency.dart';
import 'package:action_manager/models/stock.dart';
import 'package:action_manager/repository/market_repository.dart';
import 'package:get/get.dart';

class MarketController {
  static MarketController get instance => Get.find();

  List<StockModel> get stocks => MarketRepository.instance.stocks.value;
  List<CurrencyModel> get currencies => MarketRepository.instance.currencies.value;


  Future<void> getStocks() async {
    return MarketRepository.instance.getStocks();
  }


  Future<void> getCurrencies() async {
    return MarketRepository.instance.getCurrencies();
  }

}