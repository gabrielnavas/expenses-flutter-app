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
              child: const Card(
                elevation: 5,
                child: Text('Gráfico'),
              ),
            ),
            Column(
              children: _transactions
                  .map((transaction) => Card(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                transaction.value.toString(),
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  transaction.date.toIso8601String(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
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
