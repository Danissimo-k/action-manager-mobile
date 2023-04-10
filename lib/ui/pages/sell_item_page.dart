import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/buy_item_controller.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/currency.dart';
import '../../models/stock.dart';
import '../../utils/hex_color.dart';

class SellItemPage extends StatelessWidget {
  SellItemPage({Key? key}) : super(key: key);

  final _buyItemController = BuyItemController.instance;
  final _portfolioController = PortfolioController.instance;

  @override
  Widget build(BuildContext context) {
    print(_buyItemController.figi ?? "");
    return Obx(() => _buyItemController.item.value == null
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      appBar: AppBar(
        title: const Text("Продажа"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 35, right: 35),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8), // Border width
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(60), // Image radius
                  child: const FlutterLogo(),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              _buyItemController.item.value!.name,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Container(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Ваш баланс: ${_portfolioController.balance}₽",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Container(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Цена за лот: ${_buyItemController.item.value!.faceValue}₽",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    if(_buyItemController.counter.value == 0) return;

                    _buyItemController.textCounterController.text =
                    "${_buyItemController.counter.value - 1}";
                    _buyItemController.counter.value--;
                  },
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.remove),
                  splashRadius: 1,
                ),
                Flexible(
                  child: TextField(
                    controller: _buyItemController.textCounterController,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      _buyItemController.counter.value =
                          int.tryParse(text) ?? 0;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if(_buyItemController.counter.value == _buyItemController.itemQuantity) return;

                    _buyItemController.textCounterController.text = "${_buyItemController.counter.value + 1}";
                    _buyItemController.counter.value++;
                  },
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.add_outlined),
                  splashRadius: 1,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Доступно для продажи: ${_buyItemController.itemQuantity}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: HexColor.fromHex("#686777"),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 10,
              child: ElevatedButton(
                onPressed: () async {
                  if (_buyItemController.counter.value == 0 || _buyItemController.counter.value > _buyItemController.itemQuantity) {
                    Get.snackbar(
                      "Ошибка",
                      "Выберите корректное количество для продажи",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red.withOpacity(0.1),
                      colorText: Colors.red,
                    );
                    return;
                  }
                  print('type: ${_buyItemController.type}');
                  try {
                    if (_buyItemController.type == "stock") {
                      await _portfolioController.buyOrSellStock(
                          (_buyItemController.item.value as StockModel).figi,
                          _buyItemController.itemQuantity - _buyItemController.counter.value,
                          (_portfolioController.balance +_buyItemController.counter.value *_buyItemController.item.value!.faceValue)

                      );
                    } else if (_buyItemController.type == "currency") {
                      await _portfolioController.buyOrSellCurrency(
                        (_buyItemController.item.value as CurrencyModel).ticker,
                        _buyItemController.itemQuantity - _buyItemController.counter.value,
                        (_portfolioController.balance + _buyItemController.counter.value * _buyItemController.item.value!.faceValue),
                      );
                    }
                    Get.back();
                    Get.snackbar(
                      "Успех",
                      "Продажа успешно завершена",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green.withOpacity(0.1),
                      colorText: Colors.green,
                    );
                  } catch (e) {
                    print(e);
                    Get.snackbar(
                      "Ошибка",
                      "Что-то пошло не так, свяжитесь с разработчиком",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withOpacity(0.1),
                      colorText: Colors.red,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(),
                child: Text(
                    "Продать ${_buyItemController.counter.value * _buyItemController.item.value!.faceValue}₽"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}