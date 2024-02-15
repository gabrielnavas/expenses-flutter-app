import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final Transaction transaction = transactions[index];
          return Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  width: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    'R\$${transaction.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat('d MMM y').format(transaction.date),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
