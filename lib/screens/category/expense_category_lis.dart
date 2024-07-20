import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/models/category/category_mode.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel>newList, Widget? _) {
         return ListView.separated(
              itemBuilder: (ctx, index) {
                final category=newList[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing:
                        IconButton(onPressed: ()async{
                          await CategoryDB.instance.deleteCategory(category.id);
                        }, icon:const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 10);
              },
              itemCount: newList.length,
              );
        });
  }
}
