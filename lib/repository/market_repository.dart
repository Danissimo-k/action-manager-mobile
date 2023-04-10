import 'package:action_manager/constants/currencies.dart';
import 'package:action_manager/models/currency.dart';
import 'package:action_manager/models/stock.dart';
import 'package:get/get.dart';
import 'package:tinkoff_invest/tinkoff_invest.dart';

class MarketRepository extends GetxController {
  static MarketRepository get instance => Get.find();

  RxList<StockModel> stocks = <StockModel>[].obs;
  RxBool stocksLoading = true.obs;

  RxList<CurrencyModel> currencies = <CurrencyModel>[].obs;
  RxBool currenciesLoading = true.obs;

  static const _token =
      't.tWJhkMyT6F3ZEE_9uuHvUQjV1MyJJxqiRRcqJ60mBR7ZqvydrLcSwaOA7qM3UD4YHLkIrHwYTxm3t2U0un-u2w';
  // 't.UhadWo1HuBBkDFHW2CIrTvP3nJp_dRwjf6CzlNbcyIlQQp2NfZ0otpzfQbHXdu08Bk6b4eSC-B6dHXKS-hyRgQ';


  static const sandboxMode = true;

  final api = TinkoffInvestApi(_token, sandboxMode: sandboxMode);

  @override
  void onReady() {
    getStocks();
    getCurrencies();
  }

  Future<void> getStocks() async {
    stocksLoading(true);
    final response = await api.market.stocks();
    final stocksData = response.asValue!.value.payload.instruments
        .take(10)
        .map((e) {
          print(e);
          return e;
        })
        .map((instrument) => StockModel.fromInstrument(instrument))
        .toList();
    stocks(stocksData);
    stocksLoading(false);
  }

  Future<void> getCurrencies() async {
    currenciesLoading(true);
    final response = await api.market.currencies();

    // Init rub
    final rub = await api.market.searchByTicker(CurrenciesConstants.rubTicker);

    currencies([
      CurrencyModel.fromInstrument(
          rub.asValue!.value.payload.instruments.first),
      ...response.asValue!.value.payload.instruments
          .take(10)
          .map((e) => CurrencyModel.fromInstrument(e))
          .toList()
    ]);
    currenciesLoading(false);
  }
}
