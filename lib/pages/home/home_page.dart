import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/drawer.dart';
import 'package:flutter_app/components/expense_summary.dart';
import 'package:flutter_app/components/expense_tile.dart';
import 'package:flutter_app/data/expense_data.dart';
import 'package:flutter_app/models/expense_item.dart';
import 'package:flutter_app/pages/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExpenseData>(context,listen: false).preparData();
  }

  @override
  Widget build(BuildContext context) {

    //Consumer allows you to change data in the widget whenever its changed in the class ExpenseData
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'BudgetWise',
              style: TextStyle(
                fontSize: 24, // Adjust the font size
                fontWeight: FontWeight.bold, // Make it bold
              ),
            ),
            actions: [
              IconButton(
                onPressed: signUserOut,
                icon: Icon(Icons.logout, color: Colors.grey[700]),
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              // Weekly summary
              ExpenseSummary(startOfWeek: value.startOfWeekDate()),
              // Expense list
              SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Expenses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) => Dismissible(
                    key: Key(value.getAllExpenseList()[index].name),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      delete(value.getAllExpenseList()[index]);
                    },
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          value.getAllExpenseList()[index].name,
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          'Amount: ${value.getAllExpenseList()[index].amount}DH',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Text(
                          '${value.getAllExpenseList()[index].dateTime.day}/${value.getAllExpenseList()[index].dateTime.month}',
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          // Add onTap logic if needed
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).highlightColor,
          ),
        );
      },
    );
  }


  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void addNewExpense() {
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text('Add new expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: newExpenseNameController,
            decoration: const InputDecoration(
              hintText: "Expense name",
            ),
          ),
          TextField(
            controller: newExpenseAmountController,
            decoration: const InputDecoration(
              hintText: "Amount",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ],
      ),
      actions: [
        //save button
        MaterialButton(
          onPressed: save,
          child: Text('Save') ,
        ),
        MaterialButton(
          onPressed: cancel,
          child: Text('Cancel') ,
        ),

        //cancel button
      ],

    ));
  }
  void delete(ExpenseItem expense){
    Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }
  void save() {
    //create expense item
   if(newExpenseAmountController.text.isNotEmpty && newExpenseNameController.text.isNotEmpty){
     ExpenseItem newExpense = ExpenseItem(
         name: newExpenseNameController.text,
         amount: newExpenseAmountController.text,
         dateTime: DateTime.now()
     );
     //add new Expense
     Provider.of<ExpenseData>(context,listen: false).addNewExpense(newExpense);
   }
    Navigator.pop(context);
    clear();
  }
  void cancel() {
    Navigator.pop(context);
    clear();

  }
  void clear(){
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }
}
