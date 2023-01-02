import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final double amount;
  final double percentamount;
  final double totalamount;
  final String day;

  ChartBar({
    super.key,
    required this.amount,
    required this.percentamount,
    required this.totalamount,
    required this.day,
  });
  @override
  Widget build(BuildContext context) {
    print(percentamount);
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text('₹${amount.toStringAsFixed(0)}')),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
              // color: Colors.amber,
              height: constraint.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                      ),
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // print(percentamount)
                  FractionallySizedBox(
                    heightFactor: percentamount,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
                height: constraint.maxHeight * 0.15,
                child: FittedBox(child: Text('${day}'))),
            // DateFormat()
          ],
        );
      },
      //   child:
    );
  }
}
