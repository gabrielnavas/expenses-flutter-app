import 'package:expenses_flutter_app/widgets/transaction_user.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              child: Text('Gráfico'),
            ),
            TransactionUser(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
