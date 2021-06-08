import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;
  TransactionList(this._userTransactions,this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transaction yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'android/assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                              child:
                                  Text('\$${_userTransactions[index].amount}')),
                        ),
                      ),
                      title: Text(
                        _userTransactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(_userTransactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => _deleteTransaction(_userTransactions[index].id),
                      )),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
