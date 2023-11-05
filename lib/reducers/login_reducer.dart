import 'package:redux/redux.dart';
import 'package:transaction_app/actions/actions.dart';

final loginReducer = TypedReducer<bool, LoginAction>(_loginActionReducer);

bool _loginActionReducer(bool state, LoginAction action) {
  return action.isLogin;
}
