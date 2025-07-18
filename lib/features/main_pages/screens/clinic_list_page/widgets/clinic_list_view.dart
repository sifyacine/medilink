import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink/features/main_pages/screens/clinic_list_page/widgets/clinic_card.dart';

import '../../../controllers/clinic_controller.dart';


/// Widget to display the list of clinics.
class ClinicListView extends StatelessWidget {
  final ClinicController clinicController;

  const ClinicListView({Key? key, required this.clinicController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final clinics = clinicController.clinics;
      return ListView.builder(
        itemCount: clinics.length,
        itemBuilder: (context, index) {
          return ClinicCard(clinic: clinics[index]);
        },
      );
    });
  }
}


