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
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration: const  Duration(seconds: 5),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
          ),
        ),
    );
  }

 

  @override
  Widget build(context){
      Widget mainContent = const Center(
                  child: Text('No expenses found. Start adding some!'),
       );

        if(_registeredExpenses.isNotEmpty){
               mainContent =  ExpensesList(expenses: _registeredExpenses,onRemoveExpense: _removeExpense,);
          }
    
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
           child: mainContent,
           ), 
        ],
      ),
    );
  }
}