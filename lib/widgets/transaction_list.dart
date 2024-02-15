import 'package:expenses_flutter_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    Column image = Column(
      children: [
        Text(
          'Nenhuma transação cadastrada',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          height: 300,
          padding: const EdgeInsets.only(top: 50),
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );

    ListView list = ListView.builder(
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
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  'R\$${transaction.value.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.title,
                      style: Theme.of(context).textTheme.titleSmall
                      // style: const TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 16,
                      // ),
                      ),
                  Text(
                    DateFormat('d MMM y').format(transaction.date),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    Widget child = transactions.isEmpty ? image : list;
    return SizedBox(height: 500, child: child);
  }
}
