// --------------------------
// About Tab
// --------------------------

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../models/clinic_model.dart';
import 'contact_row.dart';
import 'info_item.dart';

class ClinicAboutTab extends StatelessWidget {
  final Clinic clinic;
  const ClinicAboutTab({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hours = clinic.openingHours.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoItem(icon: Icons.bed, label: '${clinic.beds} Beds'),
              InfoItem(
                  icon: Iconsax.user, label: '${clinic.doctors.length} Docs'),
              InfoItem(
                  icon: Iconsax.user_tag,
                  label: '${clinic.nurses.length} Nurses'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              InfoItem(
                  icon: Iconsax.category,
                  label: '${clinic.services.length} Services'),
              if (clinic.onlineAppointments)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: InfoItem(
                      icon: Iconsax.video, label: 'Online Appt'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          InfoItem(
              icon: Iconsax.shield_tick,
              label:
              '${clinic.insuranceAccepted.length} Insurances'),
          const SizedBox(height: 16),
          const Text('Specialties',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: clinic.clinicSpecialty
                .map((s) => Chip(label: Text(s)))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('Opening Hours',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(hours),
          const SizedBox(height: 16),
          const Text('Contact',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ContactRow(icon: Icons.call, value: clinic.phoneNumbers.join(', ')),
          const SizedBox(height: 4),
          ContactRow(icon: Icons.web, value: clinic.website),
          const SizedBox(height: 4),
          ContactRow(icon: Icons.email, value: clinic.email),
          const SizedBox(height: 16),
          const Text('About',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(clinic.description),
        ],
      ),
    );
  }
}

