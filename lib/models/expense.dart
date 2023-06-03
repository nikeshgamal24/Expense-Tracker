import 'package:flutter/material.dart';
//we define the data structure

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
//here uuid is the object and has many methods among them .v4() is one that will help to generate the unique id string to each of the expense

final formatter = DateFormat.yMd();

//to have the custom type of expense we create custom type using '--eum--'
enum Category{food, travel, leisure, work}

const categoryIcons={
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work,

};


class Expense{
  //for id we create/ generate the string id and assign it separately using a third party package called  uuid() and assign the value using "initillzer list"

  //Initializer list is used to initialize the value to the class properties that has not received the values from the Constructor of the class 

  // As in this case the id does not receive the value from the constuctor of the class so using initializer list we assign the value to the id 
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  })  : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  //add category as we will take input it 
  final Category category;

  //settig a getter to format the dat in yMD() for that we use a third party package named 'intl'

  String get formattedDate{
    return formatter.format(date);
  }
}