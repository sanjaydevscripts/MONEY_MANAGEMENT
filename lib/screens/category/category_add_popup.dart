import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/models/category/category_mode.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';


ValueNotifier<CategoryType>selectedCategoryNotifier = ValueNotifier(CategoryType.income);

Future<void>showCategoryAddPopup(BuildContext context)async{

 final _nameEditingController = TextEditingController();

 showDialog(
   context: context, 
   builder: (ctx){
     return SimpleDialog (
      title:const Text('Add Category'),
      children: [
        Padding (
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nameEditingController,
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
            onPressed: (){
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty)
                  {
                    return;
                  }
                  final _type = selectedCategoryNotifier.value;

                 final _category = CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: _name, type: _type);
               
                CategoryDB.instance.insertCategory(_category);
                Navigator.of(ctx).pop();

            },
             child:const Text('Add'))
        ),
        
      ],
     );
   });

}