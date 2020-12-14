import 'package:ExpenseTracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  gethieght(context) {
    double height = MediaQuery.of(context).size.height;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: gethieght(context)- 250,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet!',
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: gethieght(context) - 450,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\u20B9${transactions[index].amount}')),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    title: Text(
                      transactions[index].title,
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(transactions[index].dateTime)),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id)),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
