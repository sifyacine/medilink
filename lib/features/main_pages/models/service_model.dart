
class Service {
  final String name;
  final String description;
  final String range; // You can update the type if needed (e.g., double or a custom Range type).
  final double price;
  final bool isAvailable;
  final List<String> images; // List of image URLs

  Service({
    required this.name,
    required this.description,
    required this.range,
    required this.price,
    required this.isAvailable,
    required this.images,
  });
}
