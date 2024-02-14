import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas pessoais'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Card(
                child: Text('Gráfico'),
                elevation: 5,
              ),
            ),
            Column(
              children: _transactions
                  .map((transaction) => Card(
                        child: Row(
                          children: [
                            Container(
                              child: Text(transaction.value.toString()),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(transaction.title),
                                Text(transaction.date.toIso8601String()),
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ));
  }
}
