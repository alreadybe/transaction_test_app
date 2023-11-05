// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:transaction_app/actions/actions.dart';
import 'package:transaction_app/app_state.dart';
import 'package:transaction_app/features/main_page/widgets/transaction_item.dart';
import 'package:transaction_app/models/transaction_type_model.dart';
import 'package:transaction_app/models/transacton_model.dart';

class MainPage extends StatefulWidget {
  static String routeName = 'main';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        converter: (Store<AppState> store) => store.state.transactions,
        builder: (BuildContext context, List<TransactionModel> transactions) {
          _getData(context);

          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  onTap: (value) => setState(() {
                        index = value;
                      }),
                  currentIndex: index,
                  items: const [
                    BottomNavigationBarItem(
                        label: 'Transaction', icon: Icon(Icons.list)),
                    BottomNavigationBarItem(
                        label: 'Diagramm', icon: Icon(Icons.data_saver_off)),
                  ]),
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Transaction App'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(children: [
                      const Icon(
                        Icons.line_weight,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(transactions.length.toString())
                    ]),
                  )
                ],
              ),
              body: index == 0
                  ? SingleChildScrollView(
                      child: Column(
                          children: transactions
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    child: TransactionItem(transaction: e),
                                  ))
                              .toList()))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          child: Stack(
                            children: [
                              PieChart(
                                PieChartData(
                                  startDegreeOffset: 250,
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 100,
                                  sections: [
                                    PieChartSectionData(
                                      value: transactions
                                          .where((element) =>
                                              element.type ==
                                              TransactionType.refill)
                                          .toList()
                                          .length
                                          .toDouble(),
                                      color: Colors.greenAccent,
                                      radius: 30,
                                      showTitle: false,
                                    ),
                                    PieChartSectionData(
                                      value: transactions
                                          .where((element) =>
                                              element.type ==
                                              TransactionType.transfer)
                                          .toList()
                                          .length
                                          .toDouble(),
                                      color: Colors.blueAccent,
                                      radius: 25,
                                      showTitle: false,
                                    ),
                                    PieChartSectionData(
                                      value: transactions
                                          .where((element) =>
                                              element.type ==
                                              TransactionType.withdrawal)
                                          .toList()
                                          .length
                                          .toDouble(),
                                      color: Colors.redAccent,
                                      radius: 20,
                                      showTitle: false,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.white,
                                      child: Center(
                                        child: Text(
                                          transactions.length.toString(),
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: Colors.greenAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('Refill'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('Withdrawal'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('Transfer'),
                          ],
                        ),
                      ],
                    ));
        });
  }

  _getData(BuildContext context) async {
    final CollectionReference transactionCollection =
        FirebaseFirestore.instance.collection('transactions');
    final snapshot = await transactionCollection.get();
    final data = snapshot.docs
        .map((event) =>
            TransactionModel.fromJson(event.data() as Map<String, dynamic>))
        .toList();
    StoreProvider.of<AppState>(context).dispatch(LoadTransactionsAction(data));
  }
}
