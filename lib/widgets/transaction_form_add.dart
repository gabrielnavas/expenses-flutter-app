import 'dart:io';
import 'dart:math';

import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/adaptative_button.dart';
import 'package:expenses_flutter_app/widgets/adaptative_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFormAdd extends StatefulWidget {
  final void Function(Transaction transaction) onTransactionFinish;

  const TransactionFormAdd(
    this.onTransactionFinish, {
    super.key,
  });

  @override
  State<TransactionFormAdd> createState() => _TransactionFormAddState();
}

class _TransactionFormAddState extends State<TransactionFormAdd> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _dateSelected = DateTime.now();

  void _onPressedSubmitForm() {
    Transaction transaction = Transaction(
        id: Random().nextDouble().toString(),
        title: _titleController.text,
        value: double.tryParse(_valueController.text) ?? 0.00,
        date: _dateSelected);
    if (!transaction.valid()) {
      _showMessage('Alguma informação está incorreta');
      return;
    }
    widget.onTransactionFinish(transaction);
  }

  void _showMessage(String message) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 100,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  void _selectedDate() async {
    const int lessYears = 2;
    final curretYearLess = DateTime.now().year - lessYears;
    DateTime? date = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(curretYearLess),
      lastDate: DateTime.now(),
    );

    if (date == null) {
      return;
    }

    setState(() {
      _dateSelected = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: keyboardHeight + 50,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                textEditingController: _titleController,
                placeholder: 'Título',
              ),
              AdaptativeTextField(
                textEditingController: _valueController,
                placeholder: 'Valor (R\$)',
                onSubmitted: (_) => _onPressedSubmitForm(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Data selecionada: ${DateFormat('d MMM y').format(_dateSelected)}'),
                    ),
                    AdaptativeButton(
                      onPressed: _selectedDate,
                      child: const Text(
                        'Alterar a data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: AdaptativeButton(
                  onPressed: _onPressedSubmitForm,
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
