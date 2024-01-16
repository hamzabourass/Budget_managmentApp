
import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/hive_database.dart';
import 'package:flutter_app/datetime/date_time_helper.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  //list of all expenses
  List<ExpenseItem> overallExenseList=[];

  // get expense list
  List<ExpenseItem> getAllExpenseList(){
    return overallExenseList;
  }
  //prepare data to display
  final db = HiveDataBase();
  void preparData(){
    //if there exists data
    if(db.readData().isNotEmpty){
      overallExenseList = db.readData();
    }
  }


  // add new expense
  void addNewExpense(ExpenseItem newExpense){
    overallExenseList.add(newExpense);
    notifyListeners();

    db.saveData(overallExenseList);

  }

  //delete expense
  void deleteExpense(ExpenseItem expense){
    overallExenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExenseList);


  }

  //get weekday (mon,tuesday,..) from dateTime object
  String getDayName(DateTime dateTime){
    switch(dateTime.weekday){
      case 1 :
        return 'Mon';
      case 2 :
        return 'Tue';
      case 3 :
        return 'Wed';
      case 4 :
        return 'Thur';
      case 5 :
        return 'Fri';
      case 6 :
        return 'Sat';
      case 7 :
        return 'Sun';
      default:
        return '';
    }
  }

  // get the date for the start of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
        break; // break the loop once Sunday is found
      }
    }
    // If no Sunday was found in the last 7 days, default to the current date
    startOfWeek ??= today;
    return startOfWeek;
  }


  // Summary of the day
   Map<String,double> calculateDailyExpenseSummary(){
    Map<String,double> dailyExpenseSummary = {};
    for(var expense in overallExenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }else{
        dailyExpenseSummary.addAll({date:amount});
      }
    }
    return dailyExpenseSummary;

   }

}