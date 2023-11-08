// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:transaction_app/actions/actions.dart';
import 'package:transaction_app/app_state.dart';
import 'package:transaction_app/core/firestore_worker.dart';
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
    return StoreConnector(
        converter: (Store<AppState> store) => store.state.transactions,
        builder: (BuildContext context, List<TransactionModel> transactions) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () => _removeTransaction(context),
              child: const Icon(Icons.delete),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Transaction Detail"),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(transaction!.date),
                        Text('№ ${transaction!.id}')
                      ],
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
        });
  }

  _removeTransaction(BuildContext context) async {
    FirestoreWorker.removeTransaction(transactionId: transaction!.id);
    StoreProvider.of<AppState>(context).dispatch(
        LoadTransactionsAction(await FirestoreWorker.getTransactionData()));
    Navigator.pop(context);
  }
}
