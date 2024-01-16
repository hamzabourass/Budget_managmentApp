import 'package:hive/hive.dart';

import '../models/expense_item.dart';

class HiveDataBase{

  //refrence our box
  final _myBox = Hive.box("expense_database");

  //write data
  void saveData(List<ExpenseItem> allExepense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExepense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    // Store it in the database
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  //read data
  List<ExpenseItem> readData(){
    //convert data into expense item reverse of save
    List savedExpenses = _myBox.get(("ALL_EXPENSES"))?? [];
    List<ExpenseItem> allExpenses = [];

    for(int i=0; i<savedExpenses.length; i++){
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      //create exense item

      ExpenseItem expense = ExpenseItem(
          name: name,
          amount: amount,
          dateTime: dateTime
      );
      // add expenses to overall list
      allExpenses.add(expense);
    }
    return allExpenses;
  }

}
