import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/utils/constants/colors.dart';

import '../../../controllers/nurse_controller.dart';
import 'filter_from_bottom.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final NurseController controller;
  final String hintText;

  const SearchBarWidget({
    Key? key,
    required this.searchController,
    required this.controller,
    this.hintText = 'Search for nurses...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color iconColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;
    final Color hintColor = isDark ? Colors.grey[500]! : Colors.grey[500]!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Search Bar
          Expanded(
            child: Container(
              height: 52.0,
              decoration: BoxDecoration(
                color: isDark ? TColors.dark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(Icons.search, color: iconColor, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: hintColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      cursorColor: TColors.primary,
                      // onChanged is handled by listener in controller
                    ),
                  ),
                  // Clear button with smooth animation
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: searchController.text.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            searchController.clear();
                            controller.updateSearchQuery('');
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.clear,
                              color: iconColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(width: 8),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Filter Button
          Material(
            borderRadius: BorderRadius.circular(16),
            color: TColors.primary,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (context) => const FilterBottomSheet(),
                );
              },
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: TColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.filter_list_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}