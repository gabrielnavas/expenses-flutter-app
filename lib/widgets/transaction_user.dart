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

  _addTransaction(Transaction newTransaction) {
    setState(() {
      _transactions.insert(0, newTransaction);
      FocusManager.instance.primaryFocus?.unfocus(); // close keyboard
    });
  }

  final List<Widget> content = [];

  @override
  Widget build(BuildContext context) {
    content.insert(0, TransactionForm(_addTransaction));
    content.add(TransactionList(_transactions));
    return Column(children: content);
  }
}
