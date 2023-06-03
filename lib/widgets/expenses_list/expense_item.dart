import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';


class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense,{super.key});

  final Expense expense;

  @override
  Widget build(context){
    return Card(
      child: Column(
        children: [
          Text(expense.title),
          const SizedBox(height: 5,),
          Row(
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8,),
                  Text(expense.formattedDate),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}