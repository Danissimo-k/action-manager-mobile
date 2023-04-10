import 'package:action_manager/controllers/auth_controller.dart';
import 'package:action_manager/repository/auth_repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/currencies.dart';

class PortfolioRepository extends GetxController {
  static PortfolioRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Rx<Map<String, num>> stocks = Rx<Map<String, num>>({});

  Rx<Map<String, num>> currencies = Rx<Map<String, num>>({});

  @override
  void onReady() {
    // _initState();
    stocks.bindStream(_streamStocks());
    currencies.bindStream(_streamCurrencies());
    ever(AuthRepository.instance.firebaseUser, (user) {
      if (user != null) {
        _initState();
      }
    });
  }

  void _initState() {
    if (AuthRepository.instance.firebaseUser.value != null) {
      _getStocks();
      _getCurrencies();
    }
  }

  Future<void> _getStocks() async {
    stocks.value = Map<String, num>.from(await _db
        .collection('users')
        .doc(AuthRepository.instance.firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()!['stocks'] ?? {};
    }).first);
  }

  Future<void> _getCurrencies() async {
    currencies.value = Map<String, num>.from(await _db
        .collection('users')
        .doc(AuthRepository.instance.firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()!['currencies'] ?? {};
    }).first);
  }

  Stream<Map<String, num>> _streamStocks() {
    return _db
        .collection('users')
        .doc(AuthRepository.instance.firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) { return Map<String, num>.from(snapshot.data()!['stocks'] ?? {});
    });
  }

  Stream<Map<String, num>> _streamCurrencies() {
    return _db
        .collection('users')
        .doc(AuthRepository.instance.firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) {
      return Map<String, num>.from(snapshot.data()!['currencies'] ?? {});
    });
  }

  Future<void> _updateCurrency(String currencyName, num newQuantity) {
    if(newQuantity == 0 && currencyName != CurrenciesConstants.rubTicker) {
      return _db
          .collection('users')
          .doc(AuthRepository.instance.firebaseUser.value!.uid)
          .update({'stocks.$currencyName': FieldValue.delete()});
    }
    return _db
        .collection('users')
        .doc(AuthRepository.instance.firebaseUser.value!.uid)
        .update({'currencies.$currencyName': newQuantity});
  }

  Future<void> _updateStock(String stockName, num newQuantity) {
    if(newQuantity == 0) {
      return _db
          .collection('users')
          .doc(AuthRepository.instance.firebaseUser.value!.uid)
          .update({'stocks.$stockName': FieldValue.delete()});
    }
    return _db
        .collection('users')
        .doc(AuthRepository.instance.firebaseUser.value!.uid)
        .update({'stocks.$stockName': newQuantity});
  }

  Future<void> buyOrSellCurrency(
      String currencyName, num newQuantity, num rubQuantity) async {
    await _updateCurrency(currencyName, newQuantity);
    await _updateCurrency(CurrenciesConstants.rubTicker, rubQuantity);
  }

  Future<void> buyOrSellStock(
      String stockName, num newQuantity, num rubQuantity) async {
    await _updateStock(stockName, newQuantity);
    await _updateCurrency(CurrenciesConstants.rubTicker, rubQuantity);
  }
}
