// views/nurse_details_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/models/nurse_model.dart';
import '../../controllers/nurse_details_controller.dart';

class NurseDetailsPage extends StatelessWidget {
  final String? nurseId;
  final NurseModel? nurse;

  // Constructor when you have the nurse object
  NurseDetailsPage({Key? key, required this.nurse})
      : nurseId = nurse?.id,
        super(key: key);



  @override
  Widget build(BuildContext context) {
    // If we already have the nurse object, use it directly
    if (nurse != null) {
      return Scaffold(
        body: _NurseDetailsContent(
            nurse: nurse!,
            isDark: THelperFunctions.isDarkMode(context)
        ),
      );
    }

    // Otherwise, use the controller to fetch by ID
    final controller = Get.put(NurseDetailsController());

    // Fetch data when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (nurseId != null) {
        controller.fetchNurseDetails(nurseId!);
      }
    });

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${controller.error.value}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchNurseDetails(nurseId!),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final nurse = controller.nurse.value;
        return _NurseDetailsContent(
            nurse: nurse,
            isDark: THelperFunctions.isDarkMode(context)
        );
      }),
    );
  }
}
class _NurseDetailsContent extends StatelessWidget {
  final NurseModel nurse;
  final bool isDark;

  const _NurseDetailsContent({
    required this.nurse,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header Section with Image and Basic Info
        SliverAppBar(
          expandedHeight: 300,
          flexibleSpace: _NurseHeaderSection(nurse: nurse, isDark: isDark),
          pinned: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => _shareNurseProfile(nurse),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () => _toggleFavorite(nurse),
            ),
          ],
        ),

        // Main Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Stats Row
                _QuickStatsSection(nurse: nurse, isDark: isDark),
                const SizedBox(height: 24),

                // About Section
                if (nurse.bio != null && nurse.bio!.isNotEmpty) ...[
                  _SectionTitle(title: 'About', icon: Icons.person),
                  const SizedBox(height: 12),
                  _AboutSection(bio: nurse.bio!),
                  const SizedBox(height: 24),
                ],

                // Professional Information
                _SectionTitle(title: 'Professional Information', icon: Icons.work),
                const SizedBox(height: 12),
                _ProfessionalInfoSection(nurse: nurse, isDark: isDark),
                const SizedBox(height: 24),

                // Contact & Location
                _SectionTitle(title: 'Contact & Location', icon: Icons.location_on),
                const SizedBox(height: 12),
                _ContactLocationSection(nurse: nurse, isDark: isDark),
                const SizedBox(height: 24),

                // Services & Specializations
                if (nurse.servicesOffered != null && nurse.servicesOffered!.isNotEmpty) ...[
                  _SectionTitle(title: 'Services Offered', icon: Icons.medical_services),
                  const SizedBox(height: 12),
                  _ServicesSection(services: nurse.servicesOffered!),
                  const SizedBox(height: 24),
                ],

                // Certifications & Languages
                if ((nurse.certifications != null && nurse.certifications!.isNotEmpty) ||
                    (nurse.languages != null && nurse.languages!.isNotEmpty)) ...[
                  _SectionTitle(title: 'Qualifications', icon: Icons.school),
                  const SizedBox(height: 12),
                  _QualificationsSection(nurse: nurse),
                  const SizedBox(height: 24),
                ],

                // Availability
                _SectionTitle(title: 'Availability', icon: Icons.calendar_today),
                const SizedBox(height: 12),
                _AvailabilitySection(nurse: nurse),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _shareNurseProfile(NurseModel nurse) {
    // Implement share functionality
    Get.snackbar('Share', 'Share ${nurse.fullName}\'s profile');
  }

  void _toggleFavorite(NurseModel nurse) {
    // Implement favorite functionality
    Get.snackbar('Favorite', 'Added ${nurse.fullName} to favorites');
  }
}

// Header Section
class _NurseHeaderSection extends StatelessWidget {
  final NurseModel nurse;
  final bool isDark;

  const _NurseHeaderSection({required this.nurse, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final ImageProvider avatarImage = nurse.profilePicUrl != null && nurse.profilePicUrl!.isNotEmpty
        ? NetworkImage(nurse.profilePicUrl!)
        : const AssetImage(TImages.user) as ImageProvider;

    return FlexibleSpaceBar(

      background: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image/Color
          Container(
            color: TColors.primary.withOpacity(0.1),
          ),

          // Profile Content
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Profile Avatar
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: CircleAvatar(
                        backgroundImage: avatarImage,
                        backgroundColor: TColors.primary.withOpacity(0.1),
                      ),
                    ),
                    // Online Status
                    if (nurse.isActive)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Name and Specialization
                Text(
                  nurse.fullName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: TColors.dark,
                  ),
                ),
                const SizedBox(height: 8),

                if (nurse.specialization != null && nurse.specialization!.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      nurse.specialization!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                const SizedBox(height: 8),

                // Rating and Verified Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (nurse.rating != null) ...[
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${nurse.rating!.toStringAsFixed(1)} (${nurse.reviewCount ?? 0} reviews)',
                        style: TextStyle(
                          color: TColors.dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (nurse.isVerified)
                      Row(
                        children: [
                          Icon(Icons.verified, color: Colors.blue, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Quick Stats Section
class _QuickStatsSection extends StatelessWidget {
  final NurseModel nurse;
  final bool isDark;

  const _QuickStatsSection({required this.nurse, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseDetailsController());

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            value: nurse.age?.toString() ?? 'N/A',
            label: 'Age',
            icon: Icons.cake,
          ),
          _StatItem(
            value: controller.experience,
            label: 'Experience',
            icon: Icons.work_history,
          ),
          _StatItem(
            value: nurse.isActive ? 'Online' : 'Offline',
            label: 'Status',
            icon: Icons.circle,
            color: nurse.isActive ? Colors.green : Colors.grey,
          ),
          _StatItem(
            value: controller.availabilityStatus,
            label: 'Availability',
            icon: Icons.event_available,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color ?? TColors.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

// About Section
class _AboutSection extends StatelessWidget {
  final String bio;

  const _AboutSection({required this.bio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        bio,
        style: const TextStyle(
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }
}

// Professional Information Section
class _ProfessionalInfoSection extends StatelessWidget {
  final NurseModel nurse;
  final bool isDark;

  const _ProfessionalInfoSection({required this.nurse, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.medical_services,
            label: 'License Number',
            value: nurse.licenseNumber ?? 'Not specified',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.work,
            label: 'Workplace',
            value: nurse.workplace ?? 'Not specified',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.school,
            label: 'Specialization',
            value: nurse.specialization ?? 'Not specified',
          ),
          if (nurse.createdAt != null) ...[
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.calendar_today,
              label: 'Member Since',
              value: '${nurse.createdAt.year}',
            ),
          ],
        ],
      ),
    );
  }
}

// Contact & Location Section
class _ContactLocationSection extends StatelessWidget {
  final NurseModel nurse;
  final bool isDark;

  const _ContactLocationSection({required this.nurse, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.email,
            label: 'Email',
            value: nurse.email,
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.phone,
            label: 'Phone',
            value: nurse.formattedPhoneNo,
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.location_on,
            label: 'Location',
            value: nurse.city != null && nurse.state != null
                ? '${nurse.city}, ${nurse.state}'
                : nurse.city ?? nurse.state ?? 'Not specified',
          ),
          if (nurse.address != null && nurse.address!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.home,
              label: 'Address',
              value: nurse.address!,
            ),
          ],
        ],
      ),
    );
  }
}

// Services Section
class _ServicesSection extends StatelessWidget {
  final List<String> services;

  const _ServicesSection({required this.services});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: services.map((service) => Chip(
        label: Text(service),
        backgroundColor: TColors.primary.withOpacity(0.1),
        labelStyle: const TextStyle(color: TColors.primary),
      )).toList(),
    );
  }
}

// Qualifications Section
class _QualificationsSection extends StatelessWidget {
  final NurseModel nurse;

  const _QualificationsSection({required this.nurse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (nurse.certifications != null && nurse.certifications!.isNotEmpty) ...[
          const Text(
            'Certifications:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: nurse.certifications!.map((cert) => Chip(
              label: Text(cert),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              labelStyle: const TextStyle(fontSize: 12),
            )).toList(),
          ),
          const SizedBox(height: 16),
        ],

        if (nurse.languages != null && nurse.languages!.isNotEmpty) ...[
          const Text(
            'Languages:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: nurse.languages!.map((lang) => Chip(
              label: Text(lang),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              labelStyle: const TextStyle(fontSize: 12),
            )).toList(),
          ),
        ],
      ],
    );
  }
}

// Availability Section
class _AvailabilitySection extends StatelessWidget {
  final NurseModel nurse;

  const _AvailabilitySection({required this.nurse});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NurseDetailsController());

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.availabilityStatus,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          if (nurse.availability != null && nurse.availability!.isNotEmpty)
            ..._buildAvailabilitySchedule(nurse.availability!)
          else
            const Text(
              'Availability schedule not set',
              style: TextStyle(color: Colors.grey),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildAvailabilitySchedule(Map<String, dynamic> availability) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return days.map((day) {
      final dayIndex = (days.indexOf(day) + 1).toString();
      final daySchedule = availability[dayIndex];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            if (daySchedule != null && daySchedule is Map && daySchedule['available'] == true)
              Text(
                '${daySchedule['start'] ?? 'N/A'} - ${daySchedule['end'] ?? 'N/A'}',
                style: const TextStyle(color: Colors.green),
              )
            else
              const Text(
                'Not Available',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      );
    }).toList();
  }
}

// Reusable Components
class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: TColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: TColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}