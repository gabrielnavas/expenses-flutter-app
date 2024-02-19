import 'package:expenses_flutter_app/models/chart_recent.dart';
import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/chart.dart';
import 'package:expenses_flutter_app/widgets/transaction_form_add.dart';
import 'package:expenses_flutter_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(fontFamily: 'Quicksand');
    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleMedium: const TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            titleTextStyle: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            actionsIconTheme: IconThemeData(color: Colors.white)),
      ),
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
    Transaction(id: '1', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
    Transaction(id: '2', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
    Transaction(id: '3', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
    Transaction(id: '4', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
    Transaction(id: '5', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
    Transaction(id: '6', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
    Transaction(id: '7', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
    Transaction(id: '8', date: DateTime.now(), title: 'Almoço 1', value: 25.22),
  ];

  _addTransaction(Transaction newTransaction) {
    setState(() {
      _transactions.insert(0, newTransaction);
    });
    FocusManager.instance.primaryFocus?.unfocus(); // close keyboard
    Navigator.of(context).pop(); // close modal
  }

  void _removeTransaction(Transaction transactionTarget) {
    setState(() {
      _transactions
          .removeWhere((transaction) => transaction.id == transactionTarget.id);
    });
  }

  void _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TransactionFormAdd(_addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text('Despesas pessoais'),
      actions: [
        IconButton(
          onPressed: () => _openTransactionForm(context),
          icon: const Icon(Icons.add),
        )
      ],
    );

    final double paddingTop = MediaQuery.of(context).padding.top;
    final double screenSize = MediaQuery.of(context).size.height;
    final double availableHeight =
        screenSize - paddingTop - appBar.preferredSize.height;

    ChartRecent chartRecent = ChartRecent(7, _transactions);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: availableHeight * 0.30,
              child: Chart(chartRecent),
            ),
            Container(
              height: availableHeight * 0.70,
              child: TransactionList(_transactions, _removeTransaction),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionForm(context),
      ),
    );
  }
}
