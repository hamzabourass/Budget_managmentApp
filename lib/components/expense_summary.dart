import 'package:flutter/cupertino.dart';
import 'package:flutter_app/bargraph/bar_graph.dart';
import 'package:flutter_app/data/expense_data.dart';
import 'package:flutter_app/datetime/date_time_helper.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {

  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});
  // Calculate total amount for the week
  double calculateWeekTotal(Map<String, double> dailySummary) {
    double weekTotal = dailySummary.values.fold(0, (sum, amount) => sum + amount);
    return weekTotal;
  }



  // calculate max  amount

  @override
  Widget build(BuildContext context) {

    //get date of each  day of the week
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days:0)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days:1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(Duration(days:2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(Duration(days:3)));
    String thursday = convertDateTimeToString(startOfWeek.add(Duration(days:4)));
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days:5)));
    String saturday = convertDateTimeToString(startOfWeek.add(Duration(days:6)));


    //listen to changes in ExpenseData
    return Consumer<ExpenseData>(builder: (context, value, child) {
      Map<String, double> dailySummary = value.calculateDailyExpenseSummary() ?? {};
      // Calculate the max amount dynamically with a buffer
      double maxAmount = dailySummary.values.fold(0, (max, amount) => amount > max ? amount : max);
      double calculatedMaxY = maxAmount * 1.2;
      double maxY = calculatedMaxY > 5000 ? calculatedMaxY : 5000;

      return Column(
        children: [
          //weeks total
          Padding(padding: EdgeInsets.all(25.0),
          child: Row(
            children: [
              Text('Total:',style: TextStyle(fontWeight: FontWeight.bold,),),
              Text(' ${calculateWeekTotal(dailySummary)} DH')
            ],
          ),
          ),
          // bar graph
          SizedBox(
            height: 250,
            child: MyBarGraph(
              maxY: maxY,
              sunAmount: dailySummary[sunday] ?? 0,
              monAmount: dailySummary[monday] ?? 0,
              tueAmount: dailySummary[tuesday] ?? 0,
              wedAmount: dailySummary[wednesday] ?? 0,
              thurAmount: dailySummary[thursday] ?? 0,
              friAmount: dailySummary[friday] ?? 0,
              satAmount: dailySummary[saturday] ?? 0,
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    });

  }
}
