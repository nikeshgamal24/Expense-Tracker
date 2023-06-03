import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key,required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(context){
    //when the list is too long so it is not ideal to use Column instead better to use Listview

    // itemCount will ensure the number of iteration that it holding equals to the value it is holding 
    return  ListView.builder(itemCount: expenses.length,itemBuilder: ((context, index) => ExpenseItem(expenses[index])));
  }
}