import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/widgets/shimmer_nurse_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/widgets/nurse_card_widget.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/widgets/search_bar_widget.dart';
import '../../controllers/nurse_controller.dart';
import '../nurse_details_page/nurse_details_page.dart';

class NursePage extends StatelessWidget {
  const NursePage({Key? key}) : super(key: key);

  // Helper to determine grid crossAxisCount based on screen width
  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return 2;
    if (screenWidth < 900) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final nurseController = Get.put(NurseController());
    return Scaffold(
      appBar: TAppBar(
        title: const Text("Nurses"),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          nurseController.clearError();
          await nurseController.loadAllNurses();
        },
        child: Obx(() {
          if (nurseController.isLoading.value) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    child: Column(
                      children: [
                        // Shimmer Search Bar
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.grey[300]!),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(context),
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => const ShimmerNurseCard(),
                      childCount: 8, // Arbitrary number for loading placeholders
                    ),
                  ),
                ),
              ],
            );
          }

          if (nurseController.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      nurseController.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      nurseController.clearError();
                      nurseController.loadAllNurses();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final filteredNurses = nurseController.filteredNurses;
          if (filteredNurses.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text('No nurses found.', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                children: [
                  // Search Bar
                  SearchBarWidget(
                    searchController: nurseController.searchTextController,
                    controller: nurseController,
                  ),
                  const SizedBox(height: 8.0),

                  // Nurse Cards Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = _getCrossAxisCount(context);
                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: filteredNurses.length,
                        itemBuilder: (context, index) {
                          return NurseCard(
                            nurse: filteredNurses[index],
                            onCardTap: () {
                              Get.to(() => NurseDetailsPage(nurse: filteredNurses[index],));
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}