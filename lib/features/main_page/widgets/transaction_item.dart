import 'package:flutter/material.dart';
import 'package:transaction_app/features/details_page/view/details_page.dart';
import 'package:transaction_app/models/transaction_type_model.dart';
import 'package:transaction_app/models/transacton_model.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    String typeName;
    Color typeColor;

    if (transaction.type == TransactionType.refill) {
      typeName = "Refill";
      typeColor = Colors.greenAccent;
    } else if (transaction.type == TransactionType.transfer) {
      typeName = "Transfer";
      typeColor = Colors.blueAccent;
    } else {
      typeName = "Withdrawal";
      typeColor = Colors.redAccent;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(transaction: transaction))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: typeColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('№ ${transaction.id}'),
            Text(typeName),
            Text('${transaction.amount} BYN'),
          ],
        ),
      ),
    );
  }
}
