import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/transaction_form.dart';
import 'package:expenses_flutter_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas pessoais'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: const Card(
                elevation: 5,
                child: Text('Gráfico'),
              ),
            ),
            TransactionList(_transactions),
            TransactionForm(),
          ],
        ));
  }
}
