import 'package:transaction_app/app_state.dart';
import 'package:transaction_app/reducers/login_reducer.dart';
import 'package:transaction_app/reducers/transactions_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      transactions: transactionReducer(state.transactions, action),
      isLogin: loginReducer(state.isLogin, action));
}
