import 'dart:io';

import 'package:expenses_flutter_app/widgets/adaptative_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime dateSelected;
  final void Function(DateTime?) onSelectedDate;
  final int curretYearLess;

  const AdaptativeDatePicker(
      {required this.dateSelected,
      required this.onSelectedDate,
      required this.curretYearLess,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(curretYearLess),
              maximumYear: DateTime.now().year,
              onDateTimeChanged: onSelectedDate,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                      'Data selecionada: ${DateFormat('d MMM y').format(dateSelected)}'),
                ),
                AdaptativeButton(
                  onPressed: () => onSelectedDate(null),
                  child: const Text(
                    'Alterar a data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
