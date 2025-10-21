// lib/features/main_pages/screens/announcment/widgets/user_announcement_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../features/main_pages/models/announcment_model.dart';

class UserAnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const UserAnnouncementCard({
    super.key,
    required this.announcement,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Format data from Announcement model
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final startDateStr = dateFormat.format(announcement.startDate);
    final startTimeStr = timeFormat.format(
      DateTime(2023, 1, 1, announcement.startTime.hour, announcement.startTime.minute),
    );
    final endTimeStr = timeFormat.format(
      DateTime(2023, 1, 1, announcement.endTime.hour, announcement.endTime.minute),
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    announcement.targetAudience[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Guarding Service",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${announcement.targetAudience} Care",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      Iconsax.clock,
                      color: _getStatusColor(announcement.status),
                      size: 20,
                    ),
                    Text(
                      announcement.status,
                      style: TextStyle(
                        color: _getStatusColor(announcement.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date and Time
            Row(
              children: [
                Icon(Iconsax.calendar, color: Colors.grey[600], size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "$startDateStr • $startTimeStr - $endTimeStr",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Location
            Row(
              children: [
                Icon(Iconsax.location, color: Colors.grey[600], size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${announcement.city}, ${announcement.state}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Notes Preview
            if (announcement.additionalNotes.isNotEmpty) ...[
              Text(
                "Notes: ${_truncateText(announcement.additionalNotes, 80)}",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
            ],

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Iconsax.edit,
                  label: 'Edit',
                  color: Colors.blue,
                  onPressed: announcement.status == 'Pending' ||
                      announcement.status == 'Active' ? onEdit : null,
                ),
                _buildActionButton(
                  icon: Iconsax.trash,
                  label: 'Delete',
                  color: Colors.red,
                  onPressed: onDelete,
                ),
                _buildActionButton(
                  icon: Iconsax.eye,
                  label: '${announcement.views}',
                  color: Colors.grey,
                  onPressed: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    final isEnabled = onPressed != null;
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isEnabled ? color.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isEnabled ? color : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isEnabled ? color : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return "${text.substring(0, maxLength)}...";
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}