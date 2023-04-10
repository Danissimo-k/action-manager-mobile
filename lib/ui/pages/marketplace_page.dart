import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/market_controller.dart';
import '../../repository/market_repository.dart';
import '../widgets/card.dart';
import '../widgets/column_with_title.dart';

class Marketplace extends StatelessWidget {
  Marketplace({Key? key}) : super(key: key);

  final MarketController _marketController = MarketController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() => MarketRepository.instance.currenciesLoading.value ==
                true ||
            MarketRepository.instance.stocksLoading.value == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Маркет"),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 16, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ColumnWithTitle(
                      title: "Акции",
                      children: <Widget>[
                        ..._marketController.stocks.map((item) =>
                            ColumnItemCard(
                                itemType: ItemType.stock,
                                imageLink: "",
                                itemName: item.name,
                                icon: Icons.add,
                                sumPrice: item.faceValue.toDouble(),
                                functionHandler: (BuildContext context,
                                    TapDownDetails details) {
                                  final parameters = <String, String>{
                                    'type': 'stock',
                                    'figi': item.figi,
                                  };
                                  Get.toNamed('/buy', parameters: parameters);
                                }))
                      ],
                    ),
                    ColumnWithTitle(
                      title: "Валюты",
                      children: <Widget>[
                        ..._marketController.currencies
                            .map((item) => ColumnItemCard(
                                  itemType: ItemType.currency,
                                  imageLink: "",
                                  itemName: item.name,
                                  icon: Icons.add,
                                  sumPrice: item.faceValue.toDouble(),
                                  functionHandler: (BuildContext context,
                                      TapDownDetails details) {
                                    final parameters = <String, String>{
                                      'type': 'currency',
                                      'figi': item.figi,
                                    };
                                    Get.toNamed('/buy', parameters: parameters);
                                  },
                                )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
  }
}
