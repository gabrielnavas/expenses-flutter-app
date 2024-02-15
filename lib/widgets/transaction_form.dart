import 'dart:math';

import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(Transaction transaction) getNewTransaction;

  TransactionForm(this.getNewTransaction, {super.key});

  void _onPressedSubmitForm() {
    Transaction transaction = Transaction(
        id: Random().nextDouble().toString(),
        title: titleController.text,
        value: double.tryParse(valueController.text) ?? 0.00,
        date: DateTime.now());
    if (!transaction.valid()) {
      return;
    }
    getNewTransaction(transaction);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (String a) => _onPressedSubmitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _onPressedSubmitForm,
                child: const Text('Nova transação'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
