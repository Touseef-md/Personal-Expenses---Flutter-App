import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const availableColors = [
      Colors.black54,
      Colors.amberAccent,
      Colors.deepOrangeAccent,
      Colors.purpleAccent
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    //No need to call set state because build will execute after the init state.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      elevation: 3,
      child: (ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
            child: Text(
              '₹${widget.transaction.money}',
            ),
          ),
          backgroundColor: _bgColor,
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context)
              .appBarTheme
              .titleTextStyle!
              .copyWith(fontSize: 18),
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.transaction.date),
        ),
        trailing: (MediaQuery.of(context).size.width > 400)
            ? TextButton.icon(
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
              ),
      )),
    );
  }
}
