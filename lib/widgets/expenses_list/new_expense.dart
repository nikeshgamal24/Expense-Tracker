import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget{
  //since we need to work on the state and update the rendered UI
  const NewExpense({super.key, required this.onAddExpense});

  //creating a function that will receive a field values as an argument then pass it to the expenses.dart file and there we will be updateding the _registeredExpenses list and update the UI thorught setState()
  final void Function(Expense expense) onAddExpense;


  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}



class _NewExpenseState extends State<NewExpense>{
  //inorder to save the text user input into the text field we can use TextEditingController()
  final _titleController = TextEditingController();
  final _amountContoller = TextEditingController();
  Category _selectedCategory = Category.leisure;


  //so TextEditingController() allocates the space in the memory so it is necessary to dispose it otherwise it will be taking the space forever untill it is deleted form ti 
  @override
  void dispose(){
    //firstly tell which controller to be dispose i.e. the controller that you are using 
    _titleController.dispose();
    _amountContoller.dispose();
    super.dispose();
  }
  
   
  //making the instance variable 
  DateTime? _selectedDate;

  //to enable function to choose a date we use showDatePicker
  void _presentDatePicket() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1, now.month,now.day);

    final pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);

    setState(() {
      _selectedDate  = pickedDate;
    });
  }



  //validating the data that the user inputs
  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountContoller.text);
    // tryParse('Hello world')--> null  but  tryParse('1.23')-->true

    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if( _titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate==null){
      showDialog(
        context: context, 
        builder: (ctx)=>AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure a valid title, amount, date and category was entered...'),
          actions: [
            TextButton(
              onPressed: ()=>Navigator.pop(ctx), 
              child:const Text('Okay'))
          ],
        ));

        return;
        //if any validation error is there then the code will return from this line will not go further
    }

    //if code does have any validation error then the control will reach to this section
    //we need to pass the data/ inputs given by the user to the function as an argumnet as the updated _registeredExpenses lies on another Widget so we create a funcion and pass the value to that function

    //to have the access of the class property we use 'widget'
    widget.onAddExpense(
      Expense(
        title: _titleController.text.trim(), 
        amount: enteredAmount, 
        date: _selectedDate!, //_selectedDate and ! --> the variable _selectedDate is not null or can not be null
        category: _selectedCategory)
      );

      //to close the modal automatically after saving the new expense 
      Navigator.pop(context);
  }



  @override
  Widget build(context){
    return  Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
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
          Row(
              children:[
                 Expanded(
                  child: TextField(
                  controller: _amountContoller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount')),
                 ),
              ),
              const SizedBox(width: 16,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null? 'No Date Selected': formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _presentDatePicket, 
                        icon: const Icon(Icons.calendar_month),
                        )
                    ],
                  ),
                  ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category)=> DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.name.toUpperCase(),
                  ),
                   ),
                  ).toList(),
                onChanged: (value){
                  if(value == null){
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                ),
                Row(
                  children: [
                     TextButton(
                        onPressed: (){
                        Navigator.pop(context);
                      }, 
                       child: const Text('Cancel')
                    ),
                      ElevatedButton(
                         onPressed:_submitExpenseData, 
                         child: const Text('Save Expense'),
                   ),
                 ],
                )
            ]
          ),
        ],
      ),

      );
  }
}