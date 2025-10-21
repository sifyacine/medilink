import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/widgets/nurse_card_widget.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/widgets/search_bar_widget.dart';
import '../../controllers/nurse_controller.dart';
import '../nurse_details_page/nurse_details_page.dart';

class NursePage extends StatefulWidget {
  const NursePage({Key? key}) : super(key: key);

  @override
  State<NursePage> createState() => _NursePageState();
}

class _NursePageState extends State<NursePage> {
  final nurseController = Get.put(NurseController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ensure loading starts if not already
    nurseController.loadAllNurses();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text("Nurses"),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: Obx(() {
        if (nurseController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final filteredNurses = nurseController.filteredNurses;
        if (filteredNurses.isEmpty) {
          return const Center(
            child: Text('No nurses found.'),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Column(
              children: [
                // Search Bar
                SearchBarWidget(
                  searchController: searchController,
                  controller: nurseController,
                ),
                const SizedBox(height: 8.0),

                // Nurse Cards Grid
                GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: filteredNurses.length,
                  itemBuilder: (context, index) {
                    return NurseCard(
                      height: 900,
                      nurse: filteredNurses[index],
                      onCardTap: () {
                        // Navigate to NurseDetailsPage with data
                        Get.to(() => NurseDetailsPage(nurse: filteredNurses[index]));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}