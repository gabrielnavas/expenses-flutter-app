import 'dart:math';

import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:expenses_flutter_app/widgets/adaptative_button.dart';
import 'package:expenses_flutter_app/widgets/adaptative_date_picker.dart';
import 'package:expenses_flutter_app/widgets/adaptative_text_field.dart';
import 'package:flutter/material.dart';

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
  int curretYearLess = 0;

  _TransactionFormAddState() {
    const int lessYears = 2;
    curretYearLess = DateTime.now().year - lessYears;
  }

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

  void _selectedDate(DateTime? datetimeSelected) async {
    DateTime? date = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(curretYearLess),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _dateSelected = date;
      });
      return;
    }

    if (datetimeSelected != null) {
      setState(() {
        _dateSelected = datetimeSelected;
      });
    }
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
              AdaptativeDatePicker(
                onSelectedDate: _selectedDate,
                dateSelected: _dateSelected,
                curretYearLess: curretYearLess,
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
