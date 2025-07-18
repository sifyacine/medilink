import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appointment_details/Appointment_page.dart';
import '../../models/doctor_model.dart';
import '../../models/reviews_model.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorDetailsScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  int selectedDateIndex = 1;
  int? selectedTimeIndex;

  final List<String> dates = ['Mon 21', 'Tue 22', 'Wed 23', 'Thu 24', 'Fri 25', 'Sat 26', 'Sun 27'];
  final List<String> times = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '07:00 PM',
    '08:00 PM'
  ];

  double _calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 4.5;
    final total = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return (total / reviews.length).clamp(0.0, 5.0);
  }

  @override
  Widget build(BuildContext context) {
    final rating = _calculateAverageRating(widget.doctor.reviews);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Profile Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(widget.doctor.doctorPic),
                      child: widget.doctor.doctorPic.isEmpty
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                    const SizedBox(height: 15),
                    Text(widget.doctor.fullName,
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text(widget.doctor.medicalSpecialty.join(', '),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600]
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(' ${rating.toStringAsFixed(1)}'),
                        const SizedBox(width: 20),
                        Icon(Icons.location_on, color: Colors.grey, size: 20),
                        Text(' 1 km'),
                        const SizedBox(width: 20),
                        Icon(Icons.medical_services, color: Colors.grey, size: 20),
                        Text(' ${widget.doctor.age} yrs exp'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Contact Information Section
              _buildSectionTitle('Contact Information'),
              _buildInfoRow(Icons.location_city, widget.doctor.address),
              _buildInfoRow(Icons.location_on,
                  '${widget.doctor.city}, ${widget.doctor.state}'),

              const SizedBox(height: 25),

              // About Section
              _buildSectionTitle('About Doctor'),
              Text(widget.doctor.bio,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      height: 1.5
                  )),

              const SizedBox(height: 25),

              // Reviews Section
              _buildSectionTitle('Patient Reviews'),
              ...widget.doctor.reviews.take(3).map((review) => _buildReviewTile(review)),

              const SizedBox(height: 25),

              // Appointment Scheduling
              _buildSectionTitle('Select Date'),
              _buildDateSelector(),

              const SizedBox(height: 25),

              _buildSectionTitle('Select Time'),
              _buildTimeGrid(),

              const SizedBox(height: 25),

              // Book Appointment Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => AppointmentPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Book Appointment',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.teal
          )),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildReviewTile(Review review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(review.id,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const Spacer(),
                ...List.generate(5, (index) => Icon(
                  index < review.rating.floor() ? Icons.star : Icons.star_border,
                  size: 16,
                  color: Colors.amber,
                )),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.comment,
                style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() => selectedDateIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: selectedDateIndex == index ? Colors.teal : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(dates[index],
                    style: TextStyle(
                        color: selectedDateIndex == index ? Colors.white : Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeGrid() {
    return SizedBox(
      height: 160,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2.5),
        itemCount: times.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() => selectedTimeIndex = index),
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: selectedTimeIndex == index ? Colors.teal : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(times[index],
                    style: TextStyle(
                        color: selectedTimeIndex == index ? Colors.white : Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }
}