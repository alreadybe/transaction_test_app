import 'package:flutter/material.dart';
import 'package:transaction_app/models/transacton_model.dart';
export 'app_state.dart';

@immutable
class AppState {
  final List<TransactionModel> transactions;
  final bool isLogin;

  const AppState({
    required this.transactions,
    required this.isLogin,
  });
}
