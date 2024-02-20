import 'dart:io';

import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(Transaction transaction) _onRemoveTransaction;

  const TransactionList(this.transactions, this._onRemoveTransaction,
      {super.key});

  void _confirmRemoveTransaction(
      BuildContext context, Transaction transaction) {
    _onRemoveTransaction(transaction);
    _closedModal(context);
  }

  void _closedModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    LayoutBuilder imageListEmpty =
        LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * .10,
            alignment: Alignment.center,
            child: Text(
              'Nenhuma transação cadastrada',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.65,
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    });

    ListView list = ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final Transaction transaction = transactions[index];
        return Card(
          elevation: 2,
          child: ListTile(
            leading: _getLeading(transaction.value),
            title: _getTitle(transaction.title, context),
            subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
            trailing: _getTrailing(context, transaction),
          ),
        );
      },
    );

    Widget child = transactions.isEmpty ? imageListEmpty : list;

    return Container(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  Widget _getTrailing(BuildContext context, Transaction transaction) {
    final double width = MediaQuery.of(context).size.width;
    int portraitPhoneWidth = 480;
    IconData icon = Platform.isIOS ? CupertinoIcons.delete : Icons.delete;

    if (width <= portraitPhoneWidth) {
      return IconButton(
        onPressed: () => _showRemoveTransactionShield(context, transaction),
        icon: Icon(
          icon,
          color: Colors.redAccent,
        ),
      );
    }

    return TextButton.icon(
      onPressed: () => _showRemoveTransactionShield(context, transaction),
      icon: Icon(
        icon,
        color: Colors.redAccent,
      ),
      label: const Text('Excluir',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget _getTitle(String title, BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleSmall);
  }

  Widget _getLeading(double value) {
    String valueFormated = 'R\$${value.toStringAsFixed(2).toString()}';
    if (value >= 1000.00) {
      valueFormated = 'R\$1k+';
    } else if (value >= 10000.00) {
      valueFormated = 'R\$10k+';
    } else if (value >= 100000.00) {
      valueFormated = 'R\$100k+';
    } else if (value >= 1000000.00) {
      valueFormated = 'R\$1kk+';
    }
    return CircleAvatar(
      radius: 30,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              valueFormated,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRemoveTransactionShield(
    BuildContext context,
    Transaction transaction,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        children: [
          Container(
            height: 67,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Tem certeza disso?',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  onPressed: () =>
                      _confirmRemoveTransaction(context, transaction),
                  child: const Text(
                    'Sim, quero deletar!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () => _closedModal(context), // close modal,
                child: const Text('Não!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87)),
              )
            ],
          )
        ],
      ),
    );
  }
}
