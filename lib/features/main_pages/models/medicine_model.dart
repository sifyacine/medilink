class Medicine {
  final String medicineName;
  final String medicinePic;
  final double medicinePrice;
  final List<String> activeComponents;
  final String dosage;
  final String description;
  final int stock;
  final bool requiresPrescription;
  final String ageGroup;
  final DateTime expirationDate;
  final String manufacturer;
  final String category;

  Medicine({
    required this.medicineName,
    required this.medicinePic,
    required this.medicinePrice,
    required this.activeComponents,
    required this.dosage,
    required this.description,
    required this.stock,
    required this.requiresPrescription,
    required this.ageGroup,
    required this.expirationDate,
    required this.manufacturer,
    required this.category,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['medicine_name'],
      medicinePic: json['medicine_pic'],
      medicinePrice: json['medicine_price'],
      activeComponents: List<String>.from(json['active_components']),
      dosage: json['dosage'],
      description: json['description'],
      stock: json['stock'],
      requiresPrescription: json['requires_prescription'],
      ageGroup: json['age_group'],
      expirationDate: DateTime.parse(json['expiration_date']),
      manufacturer: json['manufacturer'],
      category: json['category'],
    );
  }
}
