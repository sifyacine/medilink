import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/clinic_list_page/widgets/clinic_list_view.dart';
import 'package:medilink/utils/constants/colors.dart';
import '../../controllers/clinic_controller.dart';
import '../home/widgets/home_search_bar.dart' show TSearchContainer;



class ClinicListPage extends StatelessWidget {
  final ClinicController clinicController = Get.put(ClinicController());
  final TextEditingController searchController = TextEditingController();

  ClinicListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clinics"),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Search Field
                Expanded(
                  child: TSearchContainer(hintText: 'Search...'),
                ),
                // Filter Button
                IconButton(
                  icon: Icon(Icons.filter_alt_outlined, color: TColors.primary, size: 24,),
                  onPressed: () {
                    // Implement filter action.
                  },
                ),
              ],
            ),
          ),
          // Clinic List
          Expanded(child: ClinicListView(clinicController: clinicController)),
        ],
      ),
    );
  }
}
