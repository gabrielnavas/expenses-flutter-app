import 'package:expenses_flutter_app/widgets/transaction_user.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas pessoais'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: const Card(
                  elevation: 5,
                  child: Text('Gráfico'),
                ),
              ),
              TransactionUser(),
            ],
          ),
        ));
  }
}
