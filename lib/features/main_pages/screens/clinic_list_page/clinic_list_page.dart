import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/clinic_controller.dart';
import '../../models/clinic_model.dart';
import '../clinic_details/clinic_details_page.dart';

class ClinicListPage extends StatelessWidget {
  final ClinicController clinicController = Get.put(ClinicController());

  ClinicListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClinicListAppBar(),
      body: ClinicListView(clinicController: clinicController),
    );
  }
}

/// Reusable AppBar widget with a search field in the title and a filter icon.
class ClinicListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController = TextEditingController();

  ClinicListAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: "Search clinics...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (query) {
          // Add your search logic here, e.g. update the controller's clinic list.
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // Add your filter action here.
          },
        )
      ],
    );
  }
}

/// Reusable widget that builds the list view of clinics.
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

/// Reusable widget that represents a single clinic card.
class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({Key? key, required this.clinic}) : super(key: key);

  double get averageRating {
    if (clinic.reviews.isEmpty) return 0.0;
    return clinic.reviews
        .map((r) => r.rating)
        .reduce((a, b) => a + b) /
        clinic.reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ClinicDetailsPage(clinic: clinic));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Clinic image at the top.
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(
                clinic.clinicPic,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Clinic details.
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with clinic name and rating.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          clinic.clinicName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            averageRating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 4),
                          StarRating(rating: averageRating),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // A short description or address.
                  Text(
                    "${clinic.city}, ${clinic.address}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable widget for displaying a row of star icons based on rating.
class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int fullStars = rating.floor();
    final bool halfStar = (rating - fullStars) >= 0.5;
    final int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star, color: Colors.orange, size: 16),
        if (halfStar)
          const Icon(Icons.star_half, color: Colors.orange, size: 16),
        for (int i = 0; i < emptyStars; i++)
          const Icon(Icons.star_border, color: Colors.orange, size: 16),
      ],
    );
  }
}
