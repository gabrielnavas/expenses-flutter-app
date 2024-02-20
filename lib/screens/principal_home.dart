import 'dart:io';

import 'package:expenses_flutter_app/models/chart_recent.dart';
import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/chart.dart';
import 'package:expenses_flutter_app/widgets/transaction_form_add.dart';
import 'package:expenses_flutter_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
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
    bool isPortrait = _isPortrait(context);

    if (isPortrait) {
      showModalBottomSheet(
        context: context,
        builder: (_) => TransactionFormAdd(_addTransaction),
      );
    } else {
      showDialog(
          context: context,
          builder: (_) => TransactionFormAdd(_addTransaction));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = _isPortrait(context);

    PreferredSizeWidget appBar = _renderAppBar(context);

    double availableHeight = _calculateAvailableHeight(context, appBar);

    ChartRecent chartRecent = ChartRecent(7, _transactions);

    Widget renderWidgetChild =
        _renderWidgetChild(isPortrait, availableHeight, chartRecent);

    Widget bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [renderWidgetChild],
        ),
      ),
    );

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBar as ObstructingPreferredSizeWidget,
        child: bodyPage,
      );
    }
    return Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionForm(context),
      ),
    );
  }

  bool _isPortrait(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait;
  }

  PreferredSizeWidget _renderAppBar(BuildContext context) {
    Text text = const Text('Despesas pessoais');
    var actions = _renderActionsAppBar(context);

    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: text,
        trailing: Row(
          children: actions,
        ),
      );
    }
    return AppBar(
      title: text,
      actions: actions,
    );
  }

  List<Widget> _renderActionsAppBar(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    IconData iconAdd = Platform.isIOS ? CupertinoIcons.add : Icons.add;
    List<Widget> widgets = [
      IconButton(
        onPressed: () => _openTransactionForm(context),
        icon: Icon(iconAdd),
      ),
    ];

    if (!isPortrait) {
      IconData iconAndroid = _showChart ? Icons.list : Icons.bar_chart_outlined;
      IconData iconIos =
          _showChart ? CupertinoIcons.list_bullet : Icons.bar_chart_outlined;
      IconData icon = Platform.isIOS ? iconIos : iconAndroid;
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
    Widget chart = SizedBox(
      height: isPortrait ? availableHeight * 0.30 : availableHeight * 0.86,
      child: Chart(chartRecent),
    );

    Widget transactionList = SizedBox(
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

  double _calculateAvailableHeight(
      BuildContext context, PreferredSizeWidget appBar) {
    final double paddingTop = MediaQuery.of(context).padding.top;
    final double screenSize = MediaQuery.of(context).size.height;
    final double availableHeight =
        screenSize - paddingTop - appBar.preferredSize.height;
    return availableHeight;
  }
}
