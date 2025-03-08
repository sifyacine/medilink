import 'package:flutter/material.dart';
import 'package:midilink/common/widgets/appbar/appbar.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Doctor details"),
        centerTitle: true,
        showBackArrow: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
