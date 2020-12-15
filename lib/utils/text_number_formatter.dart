import 'package:flutter_money_formatter/flutter_money_formatter.dart';

String textNumberFormatter(double _amount) {
  FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
    amount: _amount,
    settings: MoneyFormatterSettings(
      thousandSeparator: '.',
      fractionDigits: 0
    )
  );

  return fmf.output.nonSymbol;
}

