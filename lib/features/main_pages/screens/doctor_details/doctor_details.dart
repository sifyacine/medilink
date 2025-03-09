import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

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

  @override
  Widget build(BuildContext context) {
    // Safely get image path from doctor object. Use 'image' or fallback to 'imageUrl'
    final String imagePath = widget.doctor['image'] ?? widget.doctor['imageUrl'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: imagePath.isNotEmpty ? AssetImage(imagePath) : null,
                      child: imagePath.isEmpty ? Icon(Icons.person, size: 50) : null,
                    ),
                    const SizedBox(height: 10),
                    Text(widget.doctor['name'] ?? 'No name',
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text(widget.doctor['specialty'] ?? 'No specialty',
                        style: TextStyle(color: Colors.grey)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(widget.doctor['rating']?.toString() ?? 'N/A'),
                        const SizedBox(width: 10),
                        Icon(Icons.location_on, color: Colors.grey, size: 20),
                        Text(widget.doctor['distance'] ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('About', style: Theme.of(context).textTheme.titleSmall),
              Text(widget.doctor['bio'] ?? 'No bio available',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              Text('Select Date', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDateIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: EdgeInsets.only(right: 10),
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
              ),
              const SizedBox(height: 20),
              Text('Select Time', style: Theme.of(context).textTheme.titleSmall),
              SizedBox(
                height: 160,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2.5),
                  itemCount: times.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimeIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
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
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('Book Appointment',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
