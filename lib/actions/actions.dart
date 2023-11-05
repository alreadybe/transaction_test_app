import 'package:transaction_app/models/transacton_model.dart';

class LoadTransactionsAction {
  final List<TransactionModel> transactions;

  LoadTransactionsAction(this.transactions);
}

class LoginAction {
  final bool isLogin;

  LoginAction(this.isLogin);
}
