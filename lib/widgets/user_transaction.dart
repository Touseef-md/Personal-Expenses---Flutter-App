import './new_transaction.dart';
import './transaction_list.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() {
    return (_UserTransactionState());
  }
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "1",
      title: "Chai ",
      money: 15.59,
      date: DateTime.now(),
    ),
    Transaction(
      id: "2",
      title: "Momos",
      money: 50.5,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    final tx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        money: amount,
        date: DateTime.now());

    setState(() {
      _transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        NewTransaction(addTx: _addNewTransaction),
        // TransactionList(
        //   transactions: _transactions,
        // ),
      ],
    ));
  }
}
