import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryManager {
  static Map<int, String>? categories;
  static Map<int, String>? subCategories;

  /// Loads categories and subcategories from JSON files specified in the .env file.
  static Future<void> loadCategories() async {
    String categoriesJsonPath = dotenv.env['CATEGORIES_JSON']!;
    String subCategoriesJsonPath = dotenv.env['SUBCATEGORIES_JSON']!;

    // Load and decode the categories JSON file.
    String categoriesData = await rootBundle.loadString(categoriesJsonPath);
    categories = (jsonDecode(categoriesData) as Map)
        .map((key, value) => MapEntry(int.parse(key), value.toString()));

    // Load and decode the subcategories JSON file.
    String subCategoriesData =
        await rootBundle.loadString(subCategoriesJsonPath);
    subCategories = (jsonDecode(subCategoriesData) as Map)
        .map((key, value) => MapEntry(int.parse(key), value.toString()));
  }

  /// Retrieves the category translation by ID.
  static String? getCategoryTranslation(int id) {
    return categories?[id];
  }

  /// Retrieves the subcategory translation by ID.
  static String? getSubCategoryTranslation(int id) {
    return subCategories?[id];
  }
}
