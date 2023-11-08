import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:transaction_app/models/transacton_model.dart';

class FirestoreWorker {
  static Future<bool> login(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      EasyLoading.showToast('Please set email and password');
      return false;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        EasyLoading.showToast('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        EasyLoading.showToast('Wrong password provided for that user.');
        return false;
      }
    }
    return true;
  }

  static Future<List<TransactionModel>> getTransactionData() async {
    final CollectionReference transactionCollection =
        FirebaseFirestore.instance.collection('transactions');
    final snapshot = await transactionCollection.get();
    final data = snapshot.docs
        .map((event) =>
            TransactionModel.fromJson(event.data() as Map<String, dynamic>))
        .toList();

    return data;
  }

  static Future<void> removeTransaction({required String transactionId}) async {
    final transactionCollections =
        FirebaseFirestore.instance.collection('transactions');
    final query = await transactionCollections
        .where('id', isEqualTo: transactionId)
        .get();
    final itemId = query.docs.first.id;

    transactionCollections
        .doc(itemId)
        .delete()
        .catchError((error) => EasyLoading.showToast('Something went wrong'));
  }
}
