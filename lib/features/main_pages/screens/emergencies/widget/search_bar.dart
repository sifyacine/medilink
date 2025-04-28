import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search location...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onSubmitted: (query) {
          // TODO: Integrate search functionality (e.g., Mapbox Geocoding API)
          print("Search query: $query");
        },
      ),
    );
  }
}
