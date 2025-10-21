import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/constants/colors.dart';

import '../../../controllers/nurse_controller.dart';
import 'filter_from_bottom.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final NurseController controller;

  const SearchBarWidget({
    Key? key,
    required this.searchController,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Search Bar Section
          Expanded(
            flex: 8,
            child: Container(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? TColors.dark : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search for nurses',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: controller.updateSearchQuery,
                    ),
                  ),
                  // Clear button (visible only when text is present)
                  if (searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        searchController.clear();
                        controller.updateSearchQuery('');
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8), // Spacing between search bar and filter button
          // Filter Button Section
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => const FilterBottomSheet(),
                );
              },
              child: Container(
                height: 48.0, // Match search bar height for consistency
                decoration: BoxDecoration(
                  color: TColors.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(Icons.filter_list, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}