import 'package:flutter/material.dart';

/// Widget for displaying a single star rating with numeric value.
class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: Colors.orange, size: 18),
      ],
    );
  }
}
