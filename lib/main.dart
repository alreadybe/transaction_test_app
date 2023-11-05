import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:transaction_app/app.dart';
import 'package:transaction_app/app_state.dart';
import 'package:transaction_app/core/firebase_options.dart';
import 'package:transaction_app/core/locator/locator.dart';
import 'package:transaction_app/reducers/app_reducer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey[900],
    statusBarColor: Colors.grey[900],
  ));
  await locator.allReady();

  final store = Store<AppState>(
    appReducer,
    initialState: AppState(isLogin: false, transactions: List.empty()),
  );

  runApp(StoreProvider(store: store, child: const App()));
}
