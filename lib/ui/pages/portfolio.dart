import 'package:action_manager/constants/currencies.dart';
import 'package:action_manager/controllers/market_controller.dart';
import 'package:action_manager/controllers/portfolio_controller.dart';
import 'package:action_manager/repository/market_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/card.dart';
import '../widgets/column_with_title.dart';

class Portfolio extends StatelessWidget {
  Portfolio({Key? key}) : super(key: key);

  final PortfolioController _portfolioController = PortfolioController.instance;
  final MarketController _marketController = MarketController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        MarketRepository.instance.currenciesLoading.value == true ||
                MarketRepository.instance.stocksLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text("Ваше портфолио"),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColumnWithTitle(
                          title: "Акции",
                          children: <Widget>[
                            ..._marketController.stocks
                                .where((element) =>
                                    _portfolioController.stocks[element.figi] !=
                                    null)
                                .toList()
                                .map((element) =>
                                ColumnItemCard(
                                      quantity: _portfolioController
                                          .stocks[element.figi]!
                                          .toInt(),
                                      itemType: ItemType.stock,
                                      imageLink: "",
                                      itemName: element.name,
                                      price: element.faceValue.toDouble(),
                                      icon: Icons.more_vert,
                                      functionHandler: (BuildContext context,
                                          TapDownDetails details) {
                                        _showPopUpMenuAtTap(
                                            context, details, <String, String>{
                                          'type': 'stock',
                                          'figi': element.figi
                                        });
                                      },
                                    )),
                          ],
                        ),
                        ColumnWithTitle(
                          title: "Валюты",
                          children: <Widget>[
                            ..._marketController.currencies
                                .where((element) =>
                                    _portfolioController
                                        .currencies[element.ticker] !=
                                    null)
                                .toList()
                                .map((element) => ColumnItemCard(
                                      quantity: _portfolioController
                                          .currencies[element.ticker]!
                                          .toInt(),
                                      itemType: ItemType.currency,
                                      imageLink: "",
                                      price: element.ticker != CurrenciesConstants.rubTicker ? element.faceValue.toDouble() : null,
                                      itemName: element.name,
                                      icon: Icons.more_vert,
                                      functionHandler: (BuildContext context,
                                          TapDownDetails details) {
                                        _showPopUpMenuAtTap(
                                            context, details, <String, String>{
                                          'type': 'currency',
                                          'figi': element.figi
                                        });
                                      },
                                    )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )));
  }

  void _showPopUpMenuAtTap(BuildContext context, TapDownDetails details,
      Map<String, String> parameters) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        const PopupMenuItem<String>(value: '1', child: Text('Sell')),
        const PopupMenuItem<String>(value: '2', child: Text('Buy')),
      ],
      // other code as above
    ).then((value) => {
          if (value == '1')
            {Get.toNamed('/sell', parameters: parameters)}
          else if (value == '2')
            {Get.toNamed('/buy', parameters: parameters)}
        });
  }
}
