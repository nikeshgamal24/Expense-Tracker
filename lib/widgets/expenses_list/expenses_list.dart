import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key,required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context){
    //when the list is too long so it is not ideal to use Column instead better to use Listview

    // itemCount will ensure the number of iteration that it holding equals to the value it is holding 
    return  ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        //Dismissible widget will give us the swipping effect
                key: ValueKey(expenses[index],), 
                //when we dismiss a expense then a function is to be invoked so that the expense details in _registeredLIst will be updated so that there won't be any mis-matched in the internal save values and rendered UI
                onDismissed: (direction){
                  onRemoveExpense(expenses[index]);
                },
                child: ExpenseItem(expenses[index]),
              ),
    );
  }
}