// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:transaction_app/actions/actions.dart';
import 'package:transaction_app/app_state.dart';
import 'package:transaction_app/core/sp_worker.dart';
import 'package:transaction_app/features/main_page/view/main_page.dart';
import 'package:transaction_app/core/firestore_worker.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController loginController;
  late TextEditingController passwordController;

  @override
  void initState() {
    isLoggedCheck();

    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Login')),
      body: StoreConnector(
        converter: (Store<AppState> store) => store.state.isLogin,
        builder: (BuildContext context, bool isLogin) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Login'),
                  controller: loginController,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: login, child: const Text('Log In'))
              ],
            ),
          ));
        },
      ),
    );
  }

  isLoggedCheck() async {
    if (await SPWorker.isLoggedIn()) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainPage.routeName, (route) => false);
    }
  }

  login() async {
    String email = loginController.text.trim();
    String password = passwordController.text.trim();

    if (await FirestoreWorker.login(email: email, password: password)) {
      await SPWorker.saveLogin();
      StoreProvider.of<AppState>(context).dispatch(LoginAction(true));
      Navigator.pushNamedAndRemoveUntil(
          context, MainPage.routeName, (route) => false);
    }
  }
}
