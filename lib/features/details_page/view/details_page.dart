// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:transaction_app/models/transaction_type_model.dart';
import 'package:transaction_app/models/transacton_model.dart';

class DetailsPage extends StatelessWidget {
  static String routeName = 'details';

  final TransactionModel? transaction;

  const DetailsPage({this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    String typeName;

    if (transaction!.type == TransactionType.refill) {
      typeName = "Refill";
    } else if (transaction!.type == TransactionType.transfer) {
      typeName = "Transfer";
    } else {
      typeName = "Withdrawal";
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          final transactionCollections =
              FirebaseFirestore.instance.collection('transactions');
          final query = await transactionCollections
              .where('id', isEqualTo: transaction!.id)
              .get();
          final itemId = query.docs.first.id;

          transactionCollections
              .doc(itemId) // <-- Doc ID to be deleted.
              .delete() // <-- Delete
              .catchError(
                  (error) => EasyLoading.showToast('Something went wrong'));
          Navigator.pop(context);
        },
        child: const Icon(Icons.delete),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Transaction Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(transaction!.date), Text('№ ${transaction!.id}')],
          ),
          Text(
            typeName,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 50),
          Text(
            'Amount: ${transaction!.amount}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Fee: ${transaction!.fee}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Total: ${transaction!.total}',
            style: const TextStyle(fontSize: 18),
          ),
        ]),
      ),
    );
  }
}
