import 'dart:math';

import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/transaction_form.dart';
import 'package:expenses_flutter_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transaction> _transactions = [
    Transaction(
        id: '1', title: 'Tenis novo', value: 300.50, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Camiseta nova', value: 70.50, date: DateTime.now()),
    Transaction(
        id: '3', title: 'Camiseta nova', value: 70.50, date: DateTime.now()),
    Transaction(
        id: '4', title: 'Camiseta nova', value: 70.50, date: DateTime.now()),
    Transaction(
        id: '5', title: 'Camiseta nova', value: 70.50, date: DateTime.now()),
    Transaction(
        id: '6', title: 'Camiseta nova', value: 70.50, date: DateTime.now()),
    Transaction(
        id: '7', title: 'Camiseta nova', value: 70.50, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    setState(() {
      var newTransaction = Transaction(
          id: (Random().nextDouble() + _transactions.length + 1).toString(),
          title: title,
          value: value,
          date: DateTime.now());
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransactionForm(_addTransaction),
      TransactionList(_transactions),
    ]);
  }
}
