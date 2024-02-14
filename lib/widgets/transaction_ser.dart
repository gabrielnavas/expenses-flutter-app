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
        id: '3', title: 'Mouse novo', value: 150.50, date: DateTime.now()),
    Transaction(
        id: '4', title: 'Teclado nova', value: 200.50, date: DateTime.now()),
    Transaction(
        id: '5', title: 'Monitor novo', value: 700.50, date: DateTime.now()),
    Transaction(
        id: '6',
        title: 'Ar-condicionado',
        value: 1500.50,
        date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransactionList(_transactions),
      TransactionForm(),
    ]);
  }
}
