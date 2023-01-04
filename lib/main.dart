import 'dart:ui';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Second App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'Quicksand',
          appBarTheme: const AppBarTheme(
            // textTheme: ThemeData.light().textTheme.copyWith(headline6: TextStyle(fontFamily: 'OpenSans'))
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
          // appBarTheme: AppBarTheme(
          //   toolbarTextStyle: TextStyle().copyWith(
          //     fontFamily: 'OpenSans',
          //   ),
          // ),
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: "1",
    //   title: "Chai ",
    //   money: 15.59,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "2",
    //   title: "Momos",
    //   money: 50.5,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "2",
    //   title: "Momos",
    //   money: 50.5,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "2",
    //   title: "Momos",
    //   money: 50.5,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "2",
    //   title: "Momos",
    //   money: 50.5,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "2",
    //   title: "Momos",
    //   money: 50.5,
    //   date: DateTime.now(),
    // ),
  ];

  var _showChart = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final tx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      money: amount,
      date: chosenDate,
    );

    setState(() {
      _transactions.add(tx);
    });
  }

  void startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: ((bctx) {
          return NewTransaction(addTx: _addNewTransaction);
        }));
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  List<Transaction> get _recenttransactions {
    return _transactions.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      // titleTextStyle: AppBarTheme.of(context).titleTextStyle,
      // titleTextStyle:
      //     Theme.of(context).textTheme.headline6.fontFamily('OpenSans'),
      title: const Text(
        "Expenses App",
        // style: TextStyle(
        //   fontFamily: 'Quicksand',
        // ),
      ),
      actions: [
        IconButton(
          onPressed: (() => {startAddTransaction(context)}),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );

    final orientation = MediaQuery.of(context).orientation;

    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.8,
      width: double.infinity,
      child: TransactionList(
        key: widget.key,
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
    // final chart=

    return (Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (orientation == Orientation.landscape)
                Switch(
                  value: _showChart,
                  onChanged: ((value) {
                    setState(() {
                      _showChart = value;
                    });
                  }),
                ),
              // UserTransaction(), Now no longer required this file
              // NewTransaction(),  We now use this in our show modal
              if (orientation == Orientation.landscape)
                (_showChart)
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            1,
                        child: Chart(recenttransactions: _recenttransactions),
                      )
                    : txList,
              if (orientation == Orientation.portrait)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(recenttransactions: _recenttransactions),
                ),
              if (orientation == Orientation.portrait) txList,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {startAddTransaction(context)},
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // backgroundColor: Colors.orange,
    ));
  }
}
