import 'package:flutter/material.dart';
import 'package:money_manager_flutter/models/category/category_mode.dart';
//import 'package:money_manager_flutter/db/category/category_db.dart';
//import 'package:money_manager_flutter/models/category/category_mode.dart';
import 'package:money_manager_flutter/screens/category/category_add_popup.dart';
import 'package:money_manager_flutter/screens/category/screen_category.dart';
import 'package:money_manager_flutter/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager_flutter/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int>selectedIndexNotifier = ValueNotifier(0);
   
  final _pages = const[
    ScreenTransacton(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title:const Text('MONEY MANAGER'),centerTitle: true,backgroundColor: Colors.blue,),
        bottomNavigationBar:const MoneyManagerBottomNavigation(),
        body: SafeArea(
          child:ValueListenableBuilder(valueListenable:selectedIndexNotifier , builder: (BuildContext context,int updatedIndex, _){
            return _pages[updatedIndex];
          }
          
          )
           ),
           floatingActionButton:FloatingActionButton(onPressed: (){
            if (selectedIndexNotifier.value ==0) {
              print('add transaction');
            }
            else{
            print('add category');

            showCategoryAddPopup(context);
            // final _sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(), 
            //   name: 'Travel', 
            //   type: CategoryType.expense,);
            // CategoryDB().insertCategory(_sample);
            }
           },
           child:const Icon(Icons.add),
           ) ,
      ),
    );
  }
}


class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  
  const RadioButton({super.key,
  required this.type, required this.title,
  });

  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      ValueListenableBuilder(
        valueListenable: selectedCategoryNotifier,
         builder: (BuildContext ctx, CategoryType newCategory, Widget? _){
          return   Radio<CategoryType>(
          value: type,
          groupValue:newCategory ,
          onChanged: (value){
            if(value==null)
            {
              return;
            }
            selectedCategoryNotifier.value = value;
            selectedCategoryNotifier.notifyListeners;
          },
          );
         },
         
         ),
        Text(title),
      ],
    );
  }
}