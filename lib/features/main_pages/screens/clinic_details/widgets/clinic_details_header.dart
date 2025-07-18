import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../models/clinic_model.dart';
import '../../clinic_list_page/widgets/star_rating.dart';
import 'gallery_thumbnail.dart';

class ClinicHeader extends StatefulWidget {
  final Clinic clinic;
  final double averageRating;
  final bool isDark;

  const ClinicHeader({
    Key? key,
    required this.clinic,
    required this.averageRating,
    required this.isDark,
  }) : super(key: key);

  @override
  ClinicHeaderState createState() => ClinicHeaderState();
}

class ClinicHeaderState extends State<ClinicHeader> {
  late final PageController pageController;
  late final ScrollController thumbScrollController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    thumbScrollController = ScrollController();
  }

  @override
  void dispose() {
    pageController.dispose();
    thumbScrollController.dispose();
    super.dispose();
  }

  bool isVideo(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.avi');
  }

  void onPageChanged(int index) {
    setState(() => selectedIndex = index);
    // auto-scroll thumbnails so selected thumb is visible
    final scrollPos = index * 68.0; // 60px thumb + ~8px padding
    thumbScrollController.animateTo(
      scrollPos,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onThumbnailTap(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaList = widget.clinic.images;
    final currentPath = mediaList[selectedIndex];
    final open247 = widget.clinic.openingHours['Mon-Sun']
        ?.toLowerCase()
        .contains('24') ==
        true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Swipeable media carousel
        SizedBox(
          height: 260,
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemCount: mediaList.length,
                itemBuilder: (ctx, i) => InteractiveViewer(
                  child: Image.asset(
                    mediaList[i],
                    width: double.infinity,
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Back button
              Positioned(
                top: 36,
                left: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: BackButton(
                    color: TColors.primary,
                  ),
                ),
              ),

              // Share + Bookmark
              Positioned(
                top: 36,
                right: 8,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.ios_share_sharp,
                            color: TColors.primary),
                        onPressed: () {/* share logic */},
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon:
                        Icon(Iconsax.save_24, color: TColors.primary),
                        onPressed: () {/* bookmark logic */},
                      ),
                    ),
                  ],
                ),
              ),

              // Demo Video overlay when current is video
              if (isVideo(currentPath))
                Positioned.fill(
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // launch your video player
                      },
                      icon: const Icon(Icons.play_arrow, size: 20),
                      label: const Text('Demo Video'),
                    ),
                  ),
                ),

              // Thumbnails strip
              Positioned(
                bottom: 1,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    controller: thumbScrollController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: mediaList.length > 5
                        ? 5
                        : mediaList.length,
                    itemBuilder: (_, i) {
                      final thumb = GalleryThumbnail(
                        mediaList[i],
                        border: i == selectedIndex
                            ? Border.all(color: TColors.primary, width: 2)
                            : null,
                        onTap: () => onThumbnailTap(i),
                      );
                      final isOverflow = i == 4 &&
                          mediaList.length > 5;
                      return GestureDetector(
                        onTap: () => onThumbnailTap(i),
                        child: Stack(
                          children: [
                            thumb,
                            if (isOverflow)
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '+${mediaList.length - 4}',
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        // Chips + rating
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              if (widget.clinic.emergencyServices)
                const Chip(
                  label: Text(
                    'Emergency',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              if (open247)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Chip(
                    label: const Text(
                      '24/7',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: TColors.primary,
                  ),
                ),
              const Spacer(),
              StarRating(rating: widget.averageRating),
              const SizedBox(width: 4),
              Text(
                '(${widget.clinic.reviews.length})',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        // Name, address & call
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  child: Text(
                    widget.clinic.clinicName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      final lat = widget.clinic.latitude;
                      final lng = widget.clinic.longitude;
                      launchUrl(
                        Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
                        ),
                      );
                    },
                    child: Text(
                      '${widget.clinic.address}, ${widget.clinic.city}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => launchUrl(
                Uri(scheme: 'tel',
                    path: widget.clinic.phoneNumbers.first),
              ),
              icon: Icon(Iconsax.call, color: TColors.primary),
            ),
          ],
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
