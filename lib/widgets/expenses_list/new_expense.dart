import 'package:flutter/material.dart';


class NewExpense extends StatefulWidget{
  //since we need to work on the state and update the rendered UI
  const NewExpense({super.key});


  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}



class _NewExpenseState extends State<NewExpense>{
  //inorder to save the text user input into the text field we can use TextEditingController()
  final _titleController = TextEditingController();
  final _amountContoller = TextEditingController();

  //so TextEditingController() allocates the space in the memory so it is necessary to dispose it otherwise it will be taking the space forever untill it is deleted form ti 
  @override
  void dispose(){
    //firstly tell which controller to be dispose i.e. the controller that you are using 
    _titleController.dispose();
    _amountContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(context){
    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            //we need to specify the controller and if we are using multiple controller then all controller should be specified
            controller: _titleController,
            maxLength: 50,
            decoration:const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _amountContoller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$',
              label: Text('Amount')),
          ),
          Row(
            children: [
              TextButton(
                onPressed: (){}, 
                child: const Text('Cancel')),
              ElevatedButton(
                onPressed: (){
                  print(_titleController.text);
                   print(_amountContoller.text);
                }, 
                child: const Text('Save Expense'),
                ),
            ],
          ),
        ],
      ),

      );
  }
}