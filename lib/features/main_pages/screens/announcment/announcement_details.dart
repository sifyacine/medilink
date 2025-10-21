import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_strings.dart';
import 'map_screen.dart';

class AnnouncementDetailsPage extends StatefulWidget {
  @override
  _AnnouncementDetailsPageState createState() =>
      _AnnouncementDetailsPageState();
}

class _AnnouncementDetailsPageState extends State<AnnouncementDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcement Details"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: "Details"),
            const Tab(text: "Offers"),
            const Tab(text: "History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AnnouncementDetailsTab(),
          OffersTab(),
          HistoryTab(),
        ],
      ),
    );
  }
}

class AnnouncementDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture and Name
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    TImages.user5), // Replace with actual URL
              ),
              const SizedBox(width: 10),
              Text(
                "Sif Yacine",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Date and Time
          const DetailRow(label: "Date:", value: "2024-11-25"),
          const DetailRow(label: "Hours:", value: "10:00 AM - 2:00 PM"),

          const SizedBox(height: 16),

          // Map Placeholder
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: Center(
              child: RouteMapScreen(),
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            "Description:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            "This is the description of the announcement. It contains all the necessary details about the services required.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),

          // Children List
          Text(
            "Children:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ...["Alice (5 years old)", "Bob (3 years old)"].map((child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "- $child",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
          const SizedBox(height: 16),

          // Rating Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(

              onPressed: () {
                // Show parent rating
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Parent Rating 4.5 "),
                  Icon(Iconsax.star, size: 18.0,),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Parent Join Date
          const DetailRow(label: "Joined:", value: "2023-01-15"),
          const SizedBox(height: 16),

          // Status
          const DetailRow(label: "Status:", value: "Pending"),
        ],
      ),
    );
  }
}

class OffersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("History of previous announcements will appear here."),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}