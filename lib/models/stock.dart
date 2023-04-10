import 'package:action_manager/models/market_item.dart';
import 'package:flutter/material.dart';
import 'package:tinkoff_invest/tinkoff_invest.dart';

@immutable
class StockModel extends MarketItem {
  final String isin;

  StockModel({
    required figi,
    required name,
    required this.isin,
    required faceValue,
    required int lot,
  }): super(figi: figi, name: name, faceValue: faceValue, lot: lot);

  StockModel.fromInstrument(MarketInstrument instrument) : this(
    figi: instrument.figi,
    name: instrument.name,
    isin: instrument.isin!,
    faceValue: instrument.faceValue ?? 1000,
    lot: instrument.lot,
  );
}