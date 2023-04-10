import 'package:action_manager/models/market_item.dart';
import 'package:flutter/material.dart';
import 'package:tinkoff_invest/tinkoff_invest.dart';

@immutable
class CurrencyModel extends MarketItem{
  final String ticker;

  CurrencyModel({
    required figi,
    required name,
    required num faceValue,
    required this.ticker,
    required int lot,
  }) : super(figi: figi, name: name, faceValue: faceValue, lot: lot);

  CurrencyModel.fromInstrument(MarketInstrument instrument) : this(
    figi: instrument.figi,
    name: instrument.name,
    ticker: instrument.ticker,
    faceValue: instrument.faceValue ?? 1000,
    lot: instrument.lot,
  );


}