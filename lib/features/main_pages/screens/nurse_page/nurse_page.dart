import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/common/widgets/appbar/appbar.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/widgets/nurse_card_widget.dart';
import 'package:medilink/features/main_pages/screens/nurse_page/widgets/search_bar_widget.dart';
import '../../controllers/nurse_controller.dart';
import '../nurse_details_page/nurse_details_page.dart';


class NursePage extends StatelessWidget {
  NursePage({Key? key}) : super(key: key);

  final nurseController = Get.put(NurseController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Nurses"),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
            children: [
              // Search Bar
              SearchBarWidget(
                searchController: searchController,
                controller: nurseController,
              ),
              const SizedBox(height: 8.0),
      
              // Nurse Cards Grid
              Obx(() {
                final filteredNurses = nurseController.filteredNurses;
                return GridView.builder(
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
                      nurse: filteredNurses[index],
                      onCardTap: () {
                        // Navigate to NurseDetailsPage with data
                        Get.to(
                              () => NurseDetailsPage(nurse: filteredNurses[index]),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
