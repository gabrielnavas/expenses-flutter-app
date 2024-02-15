import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/transaction_form.dart';
import 'package:expenses_flutter_app/widgets/transaction_list.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    });
    FocusManager.instance.primaryFocus?.unfocus(); // close keyboard
    Navigator.of(context).pop(); // close modal
  }

  void _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TransactionForm(_addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () => _openTransactionForm(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              elevation: 5,
              child: Text('Gráfico'),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionForm(context),
      ),
    );
  }
}
