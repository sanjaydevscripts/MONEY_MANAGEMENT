import 'package:money_manager_flutter/models/category/category_mode.dart';
import 'package:hive_flutter/adapters.dart';

const CATEGORY_DB_NAME = 'category-database';
 
abstract class CategoryDbFunctions{
  Future<List<CategoryModel>>getCategories();
  Future<void>insertCategory(CategoryModel value);
}
class CategoryDB implements CategoryDbFunctions { 
  
  
  
   @override
  Future<void> insertCategory(CategoryModel value) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }
}
