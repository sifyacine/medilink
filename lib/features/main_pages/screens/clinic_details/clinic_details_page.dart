import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/clinic_model.dart';

class ClinicDetailsPage extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailsPage({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use your helper function to detect dark mode.
    final bool isDark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 5, // 5 tabs: Services, Details, Doctors, Nurses, Photos
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            clinic.clinicName,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          backgroundColor: isDark ? TColors.dark : Colors.white,
          iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        ),
        body: Column(
          children: [
            ClinicHeader(clinic: clinic),
            Container(
              color: isDark ? TColors.dark : Colors.white,
              child: TabBar(
                labelStyle: const TextStyle(fontSize: 12), // Adjust font size for selected tabs
                unselectedLabelStyle: const TextStyle(fontSize: 10), // Adjust font size for unselected tabs
                labelColor: TColors.primary,
                unselectedLabelColor: isDark ? Colors.grey[300] : Colors.grey,
                indicatorColor: TColors.primary,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.miscellaneous_services),
                    text: 'Services',
                  ),
                  Tab(
                    icon: Icon(Icons.info),
                    text: 'Details',
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: 'Doctors',
                  ),
                  Tab(
                    icon: Icon(Icons.local_hospital),
                    text: 'Nurses',
                  ),
                  Tab(
                    icon: Icon(Icons.photo),
                    text: 'Photos',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ServicesTab(),
                  DetailsTab(description: clinic.description),
                  DoctorsTab(),
                  NursesTab(),
                  PhotosTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Header widget with the clinic image and a row displaying
/// the clinic’s name, description, and a call icon.
class ClinicHeader extends StatelessWidget {
  final Clinic clinic;

  const ClinicHeader({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top image.
        Image.asset(
          clinic.clinicPic,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        // Row with clinic name, description and call icon.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Clinic name and description.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),
                    Text(
                      clinic.clinicName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      clinic.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Call icon button.
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  // Implement your call action here.
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 24,)
      ],
    );
  }
}

/// Tab: Services – a list of available services.
class ServicesTab extends StatelessWidget {
  ServicesTab({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> mockServices = [
    {"name": "Baby Care", "price": 30.0},
    {"name": "Baby Health Checkup", "price": 80.0},
    {"name": "Baby Foods", "price": 850.0},
    {"name": "Born Baby", "price": 560.0},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockServices.length,
      itemBuilder: (context, index) {
        final service = mockServices[index];
        return ServiceItem(
          serviceName: service["name"],
          price: service["price"],
        );
      },
    );
  }
}

/// Reusable widget for a service item.
class ServiceItem extends StatelessWidget {
  final String serviceName;
  final double price;

  const ServiceItem({Key? key, required this.serviceName, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(serviceName),
        subtitle: Text("${price.toStringAsFixed(2)} Rs"),
        trailing: ElevatedButton(
          onPressed: () {
            // Add your "Add" action here.
          },
          child: const Text("Add"),
        ),
      ),
    );
  }
}

/// Tab: Details – displays the clinic’s full description.
class DetailsTab extends StatelessWidget {
  final String description;

  const DetailsTab({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Text(
        description,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

/// Tab: Doctors – displays a list of doctors.
class DoctorsTab extends StatelessWidget {
  const DoctorsTab({Key? key}) : super(key: key);

  final List<Map<String, String>> mockDoctors = const [
    {"name": "Dr. John Doe", "specialty": "Cardiology"},
    {"name": "Dr. Jane Smith", "specialty": "Pediatrics"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockDoctors.length,
      itemBuilder: (context, index) {
        final doctor = mockDoctors[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person),
            ),
            title: Text(doctor["name"]!),
            subtitle: Text(doctor["specialty"]!),
          ),
        );
      },
    );
  }
}

/// Tab: Nurses – displays a list of nurses.
class NursesTab extends StatelessWidget {
  const NursesTab({Key? key}) : super(key: key);

  final List<Map<String, String>> mockNurses = const [
    {"name": "Nurse Anna", "specialty": "Pediatrics"},
    {"name": "Nurse Brian", "specialty": "Emergency"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockNurses.length,
      itemBuilder: (context, index) {
        final nurse = mockNurses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person),
            ),
            title: Text(nurse["name"]!),
            subtitle: Text(nurse["specialty"]!),
          ),
        );
      },
    );
  }
}

/// Tab: Photos – displays a grid of photos.
class PhotosTab extends StatelessWidget {
  const PhotosTab({Key? key}) : super(key: key);

  final List<String> mockPhotos = const [
    "assets/images/clinic_sample_1.jpg",
    "assets/images/clinic_sample_2.jpg",
    "assets/images/clinic_sample_3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockPhotos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            mockPhotos[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
