// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:transaction_app/actions/actions.dart';
import 'package:transaction_app/app_state.dart';
import 'package:transaction_app/features/main_page/view/main_page.dart';

class LoginPage extends StatelessWidget {
  static String routeName = 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                ElevatedButton(
                    onPressed: () async {
                      String email = loginController.text.trim();
                      String password = passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        EasyLoading.showToast('Please set email and password');
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email, password: password);
                      } on FirebaseException catch (e) {
                        if (e.code == 'user-not-found' ||
                            e.code == 'invalid-email') {
                          EasyLoading.showToast(
                              'No user found for that email.');
                          return;
                        } else if (e.code == 'wrong-password') {
                          EasyLoading.showToast(
                              'Wrong password provided for that user.');
                          return;
                        }
                      }
                      StoreProvider.of<AppState>(context)
                          .dispatch(LoginAction(true));
                      Navigator.pushNamedAndRemoveUntil(
                          context, MainPage.routeName, (route) => false);
                    },
                    child: const Text('Log In'))
              ],
            ),
          ));
        },
      ),
    );
  }
}
