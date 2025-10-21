import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:medilink/features/main_pages/models/announcment_model.dart';
import 'package:medilink/utils/helpers/helper_functions.dart'; // Import for THelperFunctions

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AnnouncementCard({
    Key? key,
    required this.announcement,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context); // Get dark mode status
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    final startDate = dateFormat.format(announcement.startDate);
    final startTime = timeFormat.format(
      DateTime(2023, 1, 1, announcement.startTime.hour, announcement.startTime.minute),
    );
    final endTime = timeFormat.format(
      DateTime(2023, 1, 1, announcement.endTime.hour, announcement.endTime.minute),
    );

    return Card(
      elevation: 3,
      shadowColor: isDarkMode ? Colors.black54 : Colors.grey.shade300, // Dynamic shadow color
      color: isDarkMode ? Colors.grey[850] : Colors.white, // Dynamic card background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: _getStatusColor(announcement.status, isDarkMode).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Service Type and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          _getServiceIcon(announcement.targetAudience),
                          color: isDarkMode ? Colors.green[300] : Colors.green, // Dynamic icon color
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Guarding ${announcement.targetAudience}",
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black87, // Dynamic text color
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (announcement.deplacementType != null)
                                Text(
                                  _getDeplacementTypeText(announcement.deplacementType!),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600], // Dynamic text color
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildStatusBadge(context, isDarkMode),
                ],
              ),
              const SizedBox(height: 12),

              // Date and Time
              Row(
                children: [
                  Icon(Iconsax.calendar, size: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      startDate,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Time Range
              Row(
                children: [
                  Icon(Iconsax.clock, size: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "$startTime - $endTime",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Location
              if (announcement.city.isNotEmpty || announcement.state.isNotEmpty)
                Row(
                  children: [
                    Icon(Iconsax.location, size: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${announcement.city}, ${announcement.state}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

              // Route (if available)
              if (announcement.startingPoint != null &&
                  announcement.startingPoint!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Icon(Iconsax.routing, size: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${announcement.startingPoint ?? ''} → ${announcement.endingPoint ?? ''}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 12),
              Divider(height: 1, color: isDarkMode ? Colors.grey[700] : Colors.grey[300]), // Dynamic divider color
              const SizedBox(height: 12),

              // Footer: Views and Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Views
                  Row(
                    children: [
                      Icon(Iconsax.eye, size: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        "${announcement.views} views",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Action Buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Active/Inactive Indicator
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: announcement.isActive
                              ? (isDarkMode ? Colors.green.shade900 : Colors.green.shade50)
                              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          announcement.isActive ? "Active" : "Inactive",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: announcement.isActive
                                ? (isDarkMode ? Colors.green[300] : Colors.green)
                                : (isDarkMode ? Colors.grey[400] : Colors.grey),
                          ),
                        ),
                      ),

                      if (onEdit != null || onDelete != null) ...[
                        const SizedBox(width: 8),
                        // Edit Button
                        if (onEdit != null &&
                            (announcement.status == 'Pending' ||
                                announcement.status == 'Active'))
                          IconButton(
                            icon: const Icon(Iconsax.edit, size: 18),
                            color: isDarkMode ? Colors.blue[300] : Colors.blue, // Dynamic button color
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: onEdit,
                            tooltip: "Edit",
                          ),

                        // Delete Button
                        if (onDelete != null)
                          IconButton(
                            icon: const Icon(Iconsax.trash, size: 18),
                            color: isDarkMode ? Colors.red[300] : Colors.red, // Dynamic button color
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: onDelete,
                            tooltip: "Delete",
                          ),
                      ],
                    ],
                  ),
                ],
              ),

              // Additional Notes Preview
              if (announcement.additionalNotes.isNotEmpty) ...[
                const SizedBox(height: 12),
                Divider(height: 1, color: isDarkMode ? Colors.grey[700] : Colors.grey[300]),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Iconsax.document_text, size: 16, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        announcement.additionalNotes,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(announcement.status, isDarkMode).withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(announcement.status, isDarkMode).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(announcement.status),
            size: 14,
            color: _getStatusColor(announcement.status, isDarkMode),
          ),
          const SizedBox(width: 4),
          Text(
            announcement.status.toUpperCase(),
            style: TextStyle(
              color: _getStatusColor(announcement.status, isDarkMode),
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status, bool isDarkMode) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
        return isDarkMode ? Colors.green[300]! : Colors.green;
      case 'pending':
        return isDarkMode ? Colors.orange[300]! : Colors.orange;
      case 'completed':
        return isDarkMode ? Colors.blue[300]! : Colors.blue;
      case 'cancelled':
      case 'rejected':
        return isDarkMode ? Colors.red[300]! : Colors.red;
      default:
        return isDarkMode ? Colors.grey[400]! : Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
        return Iconsax.tick_circle;
      case 'pending':
        return Iconsax.clock;
      case 'completed':
        return Iconsax.tick_square;
      case 'cancelled':
      case 'rejected':
        return Iconsax.close_circle;
      default:
        return Iconsax.info_circle;
    }
  }

  IconData _getServiceIcon(String targetAudience) {
    switch (targetAudience.toLowerCase()) {
      case 'children':
        return Iconsax.profile_2user;
      case 'elderly':
        return Iconsax.heart;
      case 'disabled':
        return Iconsax.health;
      case 'all':
        return Iconsax.people;
      default:
        return Iconsax.user;
    }
  }

  String _getDeplacementTypeText(DeplacementType type) {
    switch (type) {
      case DeplacementType.oneTime:
        return "One-Time";
      case DeplacementType.daily:
        return "Daily Service";
      case DeplacementType.weekly:
        return "Weekly Service";
      case DeplacementType.monthly:
        return "Monthly Service";
    }
  }
}