import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // NewTransaction({this.super});

  final Function addTx;

  NewTransaction({super.key, required this.addTx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();

  var _selectedDate;

  void onSubmit() {
    if (_amountcontroller.text.isEmpty) {
      return;
    }
    final String title = _titlecontroller.text;
    final double amount =
        double.parse(double.parse(_amountcontroller.text).toStringAsFixed(2));

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1999),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        setState(() {
          _selectedDate = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titlecontroller,
                onSubmitted: (value) => {onSubmit()},
                // onChanged: (value) {
                // title = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) => {amount = value},
                controller: _amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => {onSubmit()},
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        child: Text(
                          (_selectedDate == null)
                              ? 'No Date Choosen'
                              : DateFormat.yMd().format(_selectedDate),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print("Hellwo");
                  print(_titlecontroller.text);
                  print(_amountcontroller.text);
                  onSubmit();
                  // addTx(_titlecontroller.text,
                  //     double.parse(_amountcontroller.text).toStringAsFixed(2));
                },
                child: Text(
                  'Add Transaction',
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
