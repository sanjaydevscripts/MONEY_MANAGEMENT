import 'package:flutter/material.dart';
import 'package:money_manager_flutter/models/category/category_mode.dart';
import 'package:hive_flutter/adapters.dart';

const CATEGORY_DB_NAME = 'category-database';
 
abstract class CategoryDbFunctions{
  Future<List<CategoryModel>>getCategories();
  Future<void>insertCategory(CategoryModel value);
  Future<void>deleteCategory(String categoryID);
}
class CategoryDB implements CategoryDbFunctions { 

  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB(){
    return instance;
  }
  
  
  ValueNotifier<List<CategoryModel>>incomeCategoryListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>>expenseCategoryListListener = ValueNotifier([]);
   @override
  Future<void> insertCategory(CategoryModel value) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();

  }
  Future<void>refreshUI() async{
    final _allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
   await Future.forEach(_allCategories, (CategoryModel category){
        if(category.type == CategoryType.income){
          incomeCategoryListListener.value.add(category);
        }
        else{
          expenseCategoryListListener.value.add(category);
        }
    }
    );
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryID)async {
    final _CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _CategoryDB.delete(categoryID);
    refreshUI();
  }
}