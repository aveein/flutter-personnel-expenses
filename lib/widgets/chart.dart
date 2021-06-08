import 'package:flutter/material.dart';
import 'package:personel_expenses/models/transaction.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTrasactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      }; // e shortcut for Day M
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTrasactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    }); //fold allows us to change the list to another type
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTrasactionValues.map((data) {
          return Flexible( //takes the fit arguement
     
              fit: FlexFit.tight,
                    child: ChartBar(
              data['day'],
              data['amount'],
              totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
            ),
          );
        }).toList()),
      ),
    );
  }
}
