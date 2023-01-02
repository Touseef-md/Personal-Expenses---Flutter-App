import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransactions;
  var totalAmount = 0.0;
  Chart({super.key, required this.recenttransactions});

  List<Map<String, Object>> get getTransactionValues {
    return List.generate(
      7,
      (index) {
        var Amount = 0.0;
        final weekday = DateTime.now().subtract(Duration(days: index));

        for (var i = 0; i < recenttransactions.length; i++) {
          if (weekday.day == recenttransactions[i].date.day &&
              weekday.month == recenttransactions[i].date.month &&
              weekday.year == recenttransactions[i].date.year) {
            Amount += recenttransactions[i].money;
          }
        }
        totalAmount += Amount;
        // print(DateFormat.E().format(weekday));
        // print(Amount);
        return ({
          'day': DateFormat.E().format(weekday).substring(0, 1),
          'amount': Amount,
        });
      },
    ).reversed.toList();
  }

  double get maxSpending {
    return recenttransactions.fold(0.0, (sum, item) {
      return sum + item.money;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(maxSpending);
    print(getTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              // flex: 0,
              child: ChartBar(
                day: e['day'] as String,
                amount: e['amount'] as double,
                percentamount: (maxSpending == 0.0)
                    ? 0.0
                    : (e['amount'] as double) / maxSpending,
                totalamount: maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
