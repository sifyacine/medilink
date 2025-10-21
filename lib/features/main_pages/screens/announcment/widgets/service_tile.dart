import 'package:flutter/material.dart';
import 'package:medilink/utils/constants/colors.dart';



class ServiceTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ServiceTile(
      {Key? key,
        required this.title,
        required this.description,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: TColors.primary,

      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}