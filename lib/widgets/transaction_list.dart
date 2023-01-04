import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    //------------------Using List View---------------------

    return Container(
        // height: 300,
        child: transactions.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: [
                      const Text(
                        'No transactions yet!!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        // print(constraints.maxHeight*0.5)/;
                        height: 20,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.5,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )
                      // Image(
                      //   image: AssetImage('assets/images/waiting.png'),
                      // )
                    ],
                  );
                },
              )
            : ListView(
                children: transactions.map(
                  (tx) {
                    return TransactionItem(
                        // key: UniqueKey(),
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTransaction: deleteTransaction);
                  },
                ).toList(),
              )
        //Using the List view builder
        // : ListView.builder(
        //     itemBuilder: (context, index) {
        //       return TransactionItem(key: key,
        //           transaction: transactions[index],
        //           deleteTransaction: deleteTransaction);
        //------------------------_This is the basic approach that we would take to make our transaction list, above is the another approach
        // return Card(
        //   // margin: EdgeInsets.all(8),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     // crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         width: 70,
        //         alignment: Alignment.center,
        //         margin: const EdgeInsets.symmetric(
        //             vertical: 10, horizontal: 11),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Theme.of(context).primaryColorDark,
        //             width: 2,
        //           ),
        //           // color: Colors.amber,
        //         ),
        //         padding: const EdgeInsets.symmetric(
        //             vertical: 10, horizontal: 5),
        //         // color: Colors.amber,
        //         child: Text(
        //           '₹${transactions[index].money}',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             color: Theme.of(context).primaryColorDark,
        //           ),
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             style: Theme.of(context)
        //                 .appBarTheme
        //                 .titleTextStyle!
        //                 .copyWith(fontSize: 18),
        //             transactions[index].title,
        //           ),
        //           Text(
        //             style: const TextStyle(
        //                 fontSize: 15, color: Colors.grey),
        //             DateFormat.yMMMMd()
        //                 .format(transactions[index].date),
        //           )
        //         ],
        //       ),
        //     ],
        //   ),
        // );
        // },
        //   itemCount: transactions.length,
        // ),
        );

    // ---------------------Using Normal things--------------
    // return Container(
    //   height: 300,
    //   child: Column(
    //     children: (transactions.map(
    //       (tx) {
    //         return Card(
    //           // margin: EdgeInsets.all(8),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             // crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Container(
    //                 width: 70,
    //                 alignment: Alignment.center,
    //                 margin: const EdgeInsets.symmetric(
    //                     vertical: 10, horizontal: 11),
    //                 decoration: BoxDecoration(
    //                   border: Border.all(
    //                     color: Colors.purple,
    //                     width: 2,
    //                   ),
    //                   // color: Colors.amber,
    //                 ),
    //                 padding:
    //                     const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    //                 // color: Colors.amber,
    //                 child: Text('₹${tx.money}',
    //                     style: const TextStyle(
    //                         fontWeight: FontWeight.bold, color: Colors.purple)),
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     style: const TextStyle(
    //                         fontSize: 18, fontWeight: FontWeight.bold),
    //                     tx.title,
    //                   ),
    //                   Text(
    //                     style:
    //                         const TextStyle(fontSize: 15, color: Colors.grey),
    //                     DateFormat.yMMMMd().format(tx.date),
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     )).toList(),
    //   ),
    // );
  }
}
