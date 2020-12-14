import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final textholder = titleController.text;
    final amountholder = double.parse(amountController.text);
    if (textholder.isEmpty || amountholder < 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(
        titleController.text, double.parse(amountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime.now())
        .then((datepicked) {
      if (datepicked == null) {
        return;
      } else {
        setState(() {
          _selectedDate = datepicked;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  onSubmitted: (_) => submitData()),
              TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData()),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        // ignore: deprecated_member_use
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ]),
          ),
        ),
      ],
    );
  }
}
