import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState(){
    return _ExpensesState();
  }
}


class _ExpensesState extends State<Expenses>{


  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter course', 
      amount: 19.99,
      date: DateTime.now(), 
      category: Category.work,
      ),
      Expense(
      title: 'Cinema', 
      amount: 15.69,
      date: DateTime.now(), 
      category: Category.leisure,
      ),
  ];


  //invoking the function will enable the overlay 
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx)=> NewExpense(onAddExpense: _addExpense,),//as it is the named parameter
      );
  }

  //creating the function that will updated the _registeredExpenses list and update the rendered UI 
  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //functino to remove the swippedout expense details
  void _removeExpense(Expense expense){
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(context){
    return Scaffold(
          //to have the button displayed on the top of your screen we can use appBar parameter under 'Scaffold' 
          appBar: AppBar(
            //for the title 
            title: const Text('Flutter Expense Tracker'),
            actions: [
              //the button will then invoke a function that will enable the modal overlay using showModalBottomsheet function
               IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add))
            ],
          ),
      body:  Column(
        children: [
           const Text('The chart'),
           Expanded(
           child: ExpensesList(expenses: _registeredExpenses,onRemoveExpense: _removeExpense,),
           ), 
        ],
      ),
    );
  }
}