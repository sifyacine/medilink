import 'package:flutter/material.dart';
import 'package:medilink/features/main_pages/screens/clinic_details/widgets/about_tab.dart';
import 'package:medilink/features/main_pages/screens/clinic_details/widgets/clinic_details_header.dart';
import 'package:medilink/features/main_pages/screens/clinic_details/widgets/gallery_tab.dart';
import 'package:medilink/features/main_pages/screens/clinic_details/widgets/review_tab.dart';
import 'package:medilink/features/main_pages/screens/clinic_details/widgets/sliver_tab_bar.dart';
import 'package:medilink/utils/constants/colors.dart';
import 'package:medilink/utils/helpers/helper_functions.dart';
import '../../models/clinic_model.dart';

class ClinicDetailsPage extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailsPage({Key? key, required this.clinic}) : super(key: key);

  double get averageRating {
    if (clinic.reviews.isEmpty) return 0.0;
    return clinic.reviews
        .map((r) => r.rating)
        .reduce((a, b) => a + b) /
        clinic.reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: isDark ? TColors.dark : Colors.white,
              expandedHeight: 360,
              pinned: true,
              iconTheme: IconThemeData(
                  color: isDark ? Colors.white : Colors.black),
              flexibleSpace: FlexibleSpaceBar(
                background: ClinicHeader(
                  clinic: clinic,
                  averageRating: averageRating,
                  isDark: isDark,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverTabBar(
                TabBar(
                  indicatorColor: TColors.primary,
                  labelColor: TColors.primary,
                  unselectedLabelColor:
                  isDark ? Colors.grey[400] : Colors.grey,
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Gallery'),
                    Tab(text: 'Review'),
                  ],
                ),
                background: isDark ? TColors.dark : Colors.white,
              ),
            ),
          ],
          body: TabBarView(
            children: [
              ClinicAboutTab(clinic: clinic),
              ClinicGalleryTab(clinic: clinic),
              ClinicReviewTab(clinic: clinic),
            ],
          ),
        ),
      ),
    );
  }
}
