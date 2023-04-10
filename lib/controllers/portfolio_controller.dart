import 'package:action_manager/repository/portfolio_repository.dart';
import 'package:get/get.dart';

import '../constants/currencies.dart';

class PortfolioController {
  static PortfolioController get instance => Get.find();

  Map<String, num> get stocks => PortfolioRepository.instance.stocks.value;
  Map<String, num> get currencies => PortfolioRepository.instance.currencies.value;

  num get balance => currencies[CurrenciesConstants.rubTicker] ?? 0;

  Future<void> buyOrSellCurrency(String currencyName, num newQuantity, num rubQuantity) async {
    return PortfolioRepository.instance.buyOrSellCurrency(currencyName, newQuantity, rubQuantity);
  }


  Future<void> buyOrSellStock(String stockName, num newQuantity, num rubQuantity) async {
    return PortfolioRepository.instance.buyOrSellStock(stockName, newQuantity, rubQuantity);
  }

}