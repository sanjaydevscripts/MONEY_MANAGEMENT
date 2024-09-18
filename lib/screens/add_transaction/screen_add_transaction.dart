import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/db/transactions/transaction_db.dart';
import 'package:money_manager_flutter/models/category/category_mode.dart';
import 'package:money_manager_flutter/models/transaction/transaction_model.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransaction({super.key});

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;

  String ? _categoryID; //first it become null

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();

    CategoryDB().refreshUI(); 
  }


/*

Purpose
Date
Amount
Income/Expense
CategoryType

*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Purspose
          TextFormField(
            controller: _purposeTextEditingController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'Purpose'),
          ),
          //Amount
          TextFormField(
            controller: _amountTextEditingController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Amount'),
          ),
          //Date

          
          TextButton.icon(
            onPressed: () async{
              final _selectedDateTemp = await showDatePicker(
                context: context,
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                lastDate: DateTime.now(),
                );
                if(_selectedDateTemp == null)
                {
                  return;
                }
                else{
                  print(_selectedDateTemp.toString());
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
            },
            icon:const Icon(Icons.calendar_today),
            label:Text(_selectedDate == null ? 'SELECTED DATE' :  _selectedDate.toString()),
            ),
              
           

          //Income/Expense
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value:  CategoryType.income, 
                      groupValue: _selectedCategorytype, 
                      onChanged: (newValue){
                        setState(() {
                          _selectedCategorytype =CategoryType.income;
                          _categoryID = null;
                        });
                      }
                    ),
                    Text('Income',style: TextStyle(fontWeight: FontWeight.bold), ),
                
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value:  CategoryType.expense, 
                      groupValue: _selectedCategorytype, 
                      onChanged: (newValue){
                       setState(() {
                          _selectedCategorytype =CategoryType.expense;
                          _categoryID = null;
                       });
                      }
                    ),
                    Text('Expense',style: TextStyle(fontWeight: FontWeight.bold), ),
                
                  ],
                ),
              ],
            ),
          //Category Type Dropdown
          // DropdownButton<String>(
          //   hint: Text('Select Category'),
          //   value: _categoryID,
          //   items:(_selectedCategorytype == CategoryType.income? CategoryDB().incomeCategoryListListener : CategoryDB(). expenseCategoryListListener).value.map((e){
          //       return DropdownMenuItem(
          //         value: e.id,
          //         child: Text(e.name,),
          //       );
          //   }).toList() ,
          //    onChanged: (selectedValue){
          //     print(selectedValue);
          //     setState(() {
          //       _categoryID = selectedValue;
          //     });
          //    },
          //    ),

          // Changed: Wrap the dropdown in a ValueListenableBuilder to wait for the data to load
              ValueListenableBuilder(
                valueListenable: _selectedCategorytype == CategoryType.income
                    ? CategoryDB().incomeCategoryListListener // Listen for income categories
                    : CategoryDB().expenseCategoryListListener, // Listen for expense categories
                builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
                  return DropdownButton<String>(
                    hint: const Text('Select Category'),
                    value: _categoryID,
                    items: newList.map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                        onTap: (){
                          _selectedCategoryModel = e ;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      print(selectedValue);
                      setState(() {
                        _categoryID = selectedValue;
                      });
                    },
                  );
                },
              ),
          //submit
          ElevatedButton(
            onPressed: (){}, 
            child: Text('Submit',)
            ),
        ],
      ),
    )));
  }

  Future<void>addTransaction() async {
      final _purposeText = _purposeTextEditingController.text;
      final _amountText = _amountTextEditingController.text;
      if(_purposeText.isEmpty){
        return;
      }
      if(_amountText.isEmpty){
        return;
      }

      if(_categoryID == null){
        return;
      }
      if(_selectedDate == null){
        return;
      }
      final _parsedamount = double.tryParse(_amountText); //tryparse number anel mathram true
      if(_parsedamount == null){
        return;
      }

      if(_selectedCategoryModel == null){
        return;
      }
      //_selectedDate
      //_selectedCategorytype
      //_categoryID
      final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parsedamount,
        date: _selectedDate!, //null vrillann urapullond ! kodukam
        type:_selectedCategorytype!,
        category: _selectedCategoryModel!,
      );

      TransactionDB.instance.addTransaction(_model);
  }
}
