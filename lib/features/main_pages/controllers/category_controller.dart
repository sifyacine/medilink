import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/loaders/loaders.dart';

import '../../../data/category_repository/category_repository.dart';
import '../models/category_model.dart';


class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // -- Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firebase, API, etc.)
      final categories = await categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(5).toList());


      // Filter featured categories
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}