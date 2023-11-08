import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:transaction_app/features/details_page/view/details_page.dart';
import 'package:transaction_app/features/login_page/view/login_page.dart';
import 'package:transaction_app/features/main_page/view/main_page.dart';
import 'package:transaction_app/features/not_found_page/not_found_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routeName,
      routes: <String, WidgetBuilder>{
        MainPage.routeName: (context) => const MainPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        DetailsPage.routeName: (context) => const DetailsPage()
      },
      onUnknownRoute: (rs) =>
          MaterialPageRoute(builder: (context) => const NotFoundPage()),
      theme: ThemeData(primaryColor: Colors.grey[800]),
    );
  }
}
