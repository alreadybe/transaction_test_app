import 'package:redux/redux.dart';
import 'package:transaction_app/actions/actions.dart';
import 'package:transaction_app/models/transacton_model.dart';

final transactionReducer =
    TypedReducer<List<TransactionModel>, LoadTransactionsAction>(
        _transactionActionReducer);

List<TransactionModel> _transactionActionReducer(
    List<TransactionModel> state, LoadTransactionsAction action) {
  return action.transactions;
}
