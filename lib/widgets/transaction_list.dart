import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  TransactionList(this._userTransactions);

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
                 Container(height: 200,child: Image.asset('android/assets/images/waiting.png',fit: BoxFit.cover,))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${_userTransactions[index].amount.toStringAsFixed(2)}', //string intrepretor syntax
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          _userTransactions[index].title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          DateFormat.yMMMd()
                              .format(_userTransactions[index].date),
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
