import 'package:flutter/material.dart';
import 'package:money_manager_flutter/models/category/category_mode.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';


ValueNotifier<CategoryType>selectedCategoryNotifier = ValueNotifier(CategoryType.income);

Future<void>showCategoryAddPopup(BuildContext context)async{
 showDialog(
   context: context, 
   builder: (ctx){
     return SimpleDialog (
      title:const Text('Add Category'),
      children: [
        Padding (
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration:const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Category Name',
            ),
          ),
        ),
        const  Padding  (
          padding:  EdgeInsets.all(8.0),
          child:  Row(children: [
              RadioButton(type: CategoryType.income, title: 'Income'),
              RadioButton(type: CategoryType.expense, title: 'Expense')
          ],)
          ),


        Padding(
          padding: const EdgeInsets.all(8.0),
          child:ElevatedButton(
            onPressed: (){},
             child:const Text('Add'))
        ),
        
      ],
     );
   });

}