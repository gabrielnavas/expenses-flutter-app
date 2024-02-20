import 'package:expenses_flutter_app/models/chart_recent.dart';
import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/chart.dart';
import 'package:expenses_flutter_app/widgets/transaction_form_add.dart';
import 'package:expenses_flutter_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class PrincipalHome extends StatefulWidget {
  const PrincipalHome({super.key});

  @override
  State<PrincipalHome> createState() => _PrincipalHomeState();
}

class _PrincipalHomeState extends State<PrincipalHome> {
  bool _showChart = true;
  final List<Transaction> _transactions = [];

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
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    AppBar appBar = _renderAppBar(context);

    double availableHeight = _calculateAvailableHeight(context, appBar);

    ChartRecent chartRecent = ChartRecent(7, _transactions);

    Widget renderWidgetChild =
        _renderWidgetChild(isPortrait, availableHeight, chartRecent);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [renderWidgetChild],
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

  AppBar _renderAppBar(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text('Despesas pessoais'),
      actions: _renderActionsAppBar(context),
    );
    return appBar;
  }

  List<Widget> _renderActionsAppBar(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    List<Widget> widgets = [
      IconButton(
        onPressed: () => _openTransactionForm(context),
        icon: const Icon(Icons.add),
      ),
    ];

    if (!isPortrait) {
      IconData icon = _showChart ? Icons.list : Icons.bar_chart_outlined;
      Widget toggleChartOrTransactionList = Row(
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            color: Colors.blueAccent,
          ),
        ],
      );
      widgets.insert(0, toggleChartOrTransactionList);
    }

    return widgets;
  }

  Widget _renderWidgetChild(
      bool isPortrait, double availableHeight, ChartRecent chartRecent) {
    Widget chart = Container(
      height: isPortrait ? availableHeight * 0.30 : availableHeight,
      child: Chart(chartRecent),
    );

    Widget transactionList = Container(
      height: isPortrait ? availableHeight * 0.70 : availableHeight,
      child: TransactionList(_transactions, _removeTransaction),
    );

    if (isPortrait) {
      return Column(
        children: [
          chart,
          transactionList,
        ],
      );
    }

    if (_showChart) {
      return chart;
    }

    return transactionList;
  }

  double _calculateAvailableHeight(BuildContext context, AppBar appBar) {
    final double paddingTop = MediaQuery.of(context).padding.top;
    final double screenSize = MediaQuery.of(context).size.height;
    final double availableHeight =
        screenSize - paddingTop - appBar.preferredSize.height;
    return availableHeight;
  }
}
