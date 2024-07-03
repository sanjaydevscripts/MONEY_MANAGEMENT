import 'package:flutter/material.dart';
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
        appBar: AppBar(title: Text('MONEY MANAGER'),centerTitle: true,backgroundColor: Colors.blue,),
        bottomNavigationBar: MoneyManagerBottomNavigation(),
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
            else
            print('add category');
           },
           child: Icon(Icons.add),
           ) ,
      ),
    );
  }
}