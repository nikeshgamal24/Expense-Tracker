import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

void main(){
  runApp(
    MaterialApp(
    theme: ThemeData().copyWith(useMaterial3: true,),
    home: const Expenses(),
   ),
  );
}