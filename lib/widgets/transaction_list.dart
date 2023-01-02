import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

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
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  elevation: 3,
                  child: (ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(
                          '₹${transactions[index].money}',
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColorDark,
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle!
                          .copyWith(fontSize: 18),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                    ),
                    trailing: (MediaQuery.of(context).size.width > 400)
                        ? TextButton.icon(
                            onPressed: () {
                              deleteTransaction(transactions[index].id);
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
                              deleteTransaction(transactions[index].id);
                            },
                          ),
                  )),
                );
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
              },
              itemCount: transactions.length,
            ),
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
