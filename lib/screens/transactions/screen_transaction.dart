import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_flutter/db/transactions/transaction_db.dart';
import 'package:money_manager_flutter/models/category/category_mode.dart';
import 'package:money_manager_flutter/models/transaction/transaction_model.dart';

class ScreenTransacton extends StatelessWidget {
  const ScreenTransacton({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier, 
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _){
        return ListView.separated(
      padding:const EdgeInsets.all(10) ,
                  //values
                    itemBuilder: (ctx, index){
                      final _value =newList[index];
                      return  Slidable(
                        key: Key(_value.id!),
                        startActionPane: ActionPane(
                          motion:const ScrollMotion() ,
                           children: [
                            SlidableAction(
                              onPressed: (ctx)async{
                                await TransactionDB.instance.deleteTransactions(_value.id!);
                                
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              ),
                           ],

                           ),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                                          radius:50, 
                                          child:Text(
                                            parseDate(_value.date),
                                            textAlign: TextAlign.center,),
                                          backgroundColor: _value.type == CategoryType.income? Color.fromARGB(255, 118, 244, 123):Colors.red,
                                         ),
                            title: Text('RS ${_value.amount}'),
                            subtitle: Text(_value.category.name),
                          ),
                        ),
                      );
                    } , 
                    separatorBuilder:(ctx,index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount: newList.length,
                    );
      }
      );
  }

  String parseDate(DateTime date){

    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    //return '${date.day}\n${date.month}';
  }
}
