// dummy_data.dart

// Import your models
import '../features/main_pages/models/clinic_model.dart';
import '../features/main_pages/models/doctor_model.dart';
import '../features/main_pages/models/medicine_model.dart';
import '../features/main_pages/models/pharmacy.dart';
import '../features/main_pages/models/reviews_model.dart';
import '../features/main_pages/models/nurse_model.dart';
import '../features/main_pages/models/service_model.dart';

//
// Dummy Reviews for Clinics
//

final product1 = Product(
  id: 'prod1',
  name: 'Posture Corrector Brace',
  imageUrl: 'assets/images/medicines/Posture Corrector Brace.jpg',
  price: 27.00,
  description: 'Adjustable posture brace to align shoulders and spine.',
  stock: 110,
  manufacturer: pharmacy1,
  category: 'Braces',
  size: 'Adjustable',
  material: 'Polyester',
  reductionPercentage: 10,
  isAvailable: true,
  addedDate: DateTime.now().subtract(Duration(days: 14)),
  ratings: [review1],
);

final product2 = Product(
  id: 'prod2',
  name: 'Compression Leg Stockings',
  imageUrl: 'assets/images/medicines/compression Leg Stockings.jpg',
  price: 34.50,
  description: 'Knee-high graduated compression stockings for circulation.',
  stock: 95,
  manufacturer: pharmacy2,
  category: 'Stockings',
  size: 'L',
  material: 'Spandex Blend',
  reductionPercentage: 5,
  isAvailable: true,
  addedDate: DateTime.now().subtract(Duration(days: 30)),
  ratings: [review3],
);

final product3 = Product(
  id: 'prod3',
  name: 'Cervical Neck Collar',
  imageUrl: 'assets/images/medicines/Adjustable Back Support Belt.jpg',
  price: 24.75,
  description: 'Soft foam collar for neck immobilization and relief.',
  stock: 80,
  manufacturer: pharmacy3,
  category: 'Collars',
  size: 'Universal',
  material: 'Foam',
  reductionPercentage: 8,
  isAvailable: true,
  addedDate: DateTime.now().subtract(Duration(days: 10)),
  ratings: [review5],
);

final product4 = Product(
  id: 'prod4',
  name: 'Wrist Support Wrap',
  imageUrl: 'assets/images/medicines/wrist_support_wrap.jpg',
  price: 14.49,
  description: 'Adjustable wrist wrap offering compression and protection.',
  stock: 120,
  manufacturer: pharmacy3,
  category: 'Supports',
  size: 'One Size',
  material: 'Elastic Fabric',
  reductionPercentage: 0,
  isAvailable: true,
  addedDate: DateTime.now().subtract(Duration(days: 5)),
  ratings: [review6],
);

final product5 = Product(
  id: 'prod5',
  name: 'Elastic Knee Brace',
  imageUrl: 'assets/images/medicines/Elastic Knee Brace.jpg',
  price: 19.99,
  description: 'Breathable knee sleeve with compression and joint stability.',
  stock: 200,
  manufacturer: pharmacy4,
  category: 'Braces',
  size: 'S-M',
  material: 'Nylon',
  reductionPercentage: 15,
  isAvailable: true,
  addedDate: DateTime.now().subtract(Duration(days: 25)),
  ratings: [review7],
);

final product6 = Product(
  id: 'prod6',
  name: 'Adjustable Back Support Belt',
  imageUrl: 'assets/images/medicines/Adjustable Back Support Belt.jpg',
  price: 29.99,
  description: 'Ergonomic lumbar belt with adjustable straps.',
  stock: 150,
  manufacturer: pharmacy4,
  category: 'Support Belts',
  size: 'M-L',
  material: 'Neoprene',
  reductionPercentage: 12,
  isAvailable: true,
  addedDate: DateTime.now().subtract(Duration(days: 20)),
  ratings: [review8],
);


final review2 = Review(
  id: 'r2',
  uid: 'u102',
  rating: 4.5,
  reviewTargetId: 'pharmacy1',
  title: 'Reliable and fast',
  comment: 'Delivery arrived the same day. Definitely coming back!',
  createdAt: DateTime.now().subtract(Duration(days: 3)),
  updatedAt: DateTime.now().subtract(Duration(days: 3)),
);
final review3 = Review(
  id: 'r3',
  uid: 'u103',
  rating: 4.2,
  reviewTargetId: 'pharmacy2',
  title: 'Very efficient',
  comment: 'They had the stockings in my size and were easy to order.',
  createdAt: DateTime.now().subtract(Duration(days: 10)),
  updatedAt: DateTime.now().subtract(Duration(days: 10)),
);

final review4 = Review(
  id: 'r4',
  uid: 'u104',
  rating: 3.9,
  reviewTargetId: 'pharmacy2',
  title: 'Could be faster',
  comment: 'Product quality was great, but delivery took 2 days.',
  createdAt: DateTime.now().subtract(Duration(days: 8)),
  updatedAt: DateTime.now().subtract(Duration(days: 8)),
);

final review5 = Review(
  id: 'r5',
  uid: 'u105',
  rating: 4.6,
  reviewTargetId: 'pharmacy3',
  title: 'Neck support helped a lot',
  comment: 'Cervical collar was soft and exactly what I needed for my injury.',
  createdAt: DateTime.now().subtract(Duration(days: 7)),
  updatedAt: DateTime.now().subtract(Duration(days: 7)),
);

final review6 = Review(
  id: 'r6',
  uid: 'u106',
  rating: 4.1,
  reviewTargetId: 'pharmacy3',
  title: 'Professional staff',
  comment: 'They explained how to use the product thoroughly. Loved that.',
  createdAt: DateTime.now().subtract(Duration(days: 4)),
  updatedAt: DateTime.now().subtract(Duration(days: 4)),
);
final review7 = Review(
  id: 'r7',
  uid: 'u107',
  rating: 4.9,
  reviewTargetId: 'pharmacy4',
  title: 'Top-notch products',
  comment: 'Posture corrector worked wonders. Highly recommend.',
  createdAt: DateTime.now().subtract(Duration(days: 6)),
  updatedAt: DateTime.now().subtract(Duration(days: 6)),
);

final review8 = Review(
  id: 'r8',
  uid: 'u108',
  rating: 4.3,
  reviewTargetId: 'pharmacy4',
  title: 'Great experience',
  comment: 'Easy to order, well-packaged, and quick customer service.',
  createdAt: DateTime.now().subtract(Duration(days: 2)),
  updatedAt: DateTime.now().subtract(Duration(days: 2)),
);

final review1 = Review(
  id: 'r1',
  uid: 'u101',
  rating: 4.8,
  reviewTargetId: 'pharmacy1',
  title: 'Great Service',
  comment: 'Staff was super helpful and the posture brace I got was top-notch.',
  createdAt: DateTime.now().subtract(Duration(days: 5)),
  updatedAt: DateTime.now().subtract(Duration(days: 5)),
);


final pharmacy1 = Pharmacy(
  id: 'pharmacy1',
  name: 'Healthy Life Pharmacy',
  logoUrl: 'https://example.com/logos/healthy_life.png',
  description: 'Trusted provider of ergonomic and orthopedic medical supplies.',
  specialties: ['Orthopedic Supplies', 'Rehabilitation', 'Compression Wear'],
  openingHours: {
    'mon': '08:00-18:00',
    'tue': '08:00-18:00',
    'wed': '08:00-18:00',
    'thu': '08:00-18:00',
    'fri': '08:00-17:00',
  },
  address: '123 Health St',
  city: 'Wellnessville',
  latitude: 37.7749,
  longitude: -122.4194,
  website: 'https://healthy-life.com',
  email: 'contact@healthy-life.com',
  phoneNumbers: ['+1234567890'],
  emergencyServices: false,
  insuranceAccepted: ['Medicare', 'PrivateCare'],
  onlineOrders: true,
  createdAt: DateTime.now().subtract(Duration(days: 90)),
  updatedAt: DateTime.now(),
  images: ['https://example.com/pharmacies/healthy_life_1.jpg'],
  reviews: [review1, review2],
);

final pharmacy2 = Pharmacy(
  id: 'pharmacy2',
  name: 'QuickMed Supplies',
  logoUrl: 'https://example.com/logos/quickmed.png',
  description: 'Fast delivery of medical support gear and more.',
  specialties: ['Compression Gear', 'Mobility Aids'],
  openingHours: {
    'mon': '09:00-17:00',
    'tue': '09:00-17:00',
    'wed': '09:00-17:00',
    'thu': '09:00-17:00',
    'fri': '09:00-16:00',
  },
  address: '45 Speed Ave',
  city: 'Medicton',
  latitude: 40.7128,
  longitude: -74.0060,
  website: 'https://quickmedsupplies.com',
  email: 'support@quickmed.com',
  phoneNumbers: ['+1987654321'],
  emergencyServices: false,
  insuranceAccepted: ['QuickHealth'],
  onlineOrders: true,
  createdAt: DateTime.now().subtract(Duration(days: 120)),
  updatedAt: DateTime.now(),
  images: ['https://example.com/pharmacies/quickmed_1.jpg'],
  reviews: [review3, review4],
);

final pharmacy3 = Pharmacy(
  id: 'pharmacy3',
  name: 'OrthoPlus Center',
  logoUrl: 'https://example.com/logos/orthoplus.png',
  description: 'Specialists in orthopedic recovery products.',
  specialties: ['Braces', 'Neck Supports', 'Wrist Wraps'],
  openingHours: {
    'mon': '10:00-18:00',
    'tue': '10:00-18:00',
    'wed': '10:00-18:00',
    'thu': '10:00-18:00',
    'fri': '10:00-18:00',
  },
  address: '88 Ortho Road',
  city: 'Boneville',
  latitude: 34.0522,
  longitude: -118.2437,
  website: 'https://orthoplus.com',
  email: 'hello@orthoplus.com',
  phoneNumbers: ['+1122334455'],
  emergencyServices: true,
  insuranceAccepted: ['Medicare', 'FlexiHealth'],
  onlineOrders: false,
  createdAt: DateTime.now().subtract(Duration(days: 60)),
  updatedAt: DateTime.now(),
  images: ['https://example.com/pharmacies/orthoplus_1.jpg'],
  reviews: [review5, review6],
);

final pharmacy4 = Pharmacy(
  id: 'pharmacy4',
  name: 'WellCare Pharmacy',
  logoUrl: 'https://example.com/logos/wellcare.png',
  description: 'Quality health care products and expert guidance.',
  specialties: ['Posture Gear', 'Supports', 'Belts'],
  openingHours: {
    'mon': '07:00-15:00',
    'tue': '07:00-15:00',
    'wed': '07:00-15:00',
    'thu': '07:00-15:00',
    'fri': '07:00-15:00',
  },
  address: '321 Spine St',
  city: 'Careton',
  latitude: 36.7783,
  longitude: -119.4179,
  website: 'https://wellcarepharmacy.com',
  email: 'info@wellcare.com',
  phoneNumbers: ['+1223344556'],
  emergencyServices: false,
  insuranceAccepted: ['LifeAssist'],
  onlineOrders: true,
  createdAt: DateTime.now().subtract(Duration(days: 150)),
  updatedAt: DateTime.now(),
  images: ['https://example.com/pharmacies/wellcare_1.jpg'],
  reviews: [review7, review8],
);


final clinicReview1 = Review(
  id: "clinic_review_1",
  uid: "user1",
  rating: 4.5,
  reviewTargetId: "clinic_1",
  title: "Great Service",
  comment: "The clinic provided excellent care and a friendly atmosphere.",
  createdAt: DateTime(2025, 1, 15),
  updatedAt: DateTime(2025, 1, 15),
);

final clinicReview2 = Review(
  id: "clinic_review_2",
  uid: "user2",
  rating: 4.0,
  reviewTargetId: "clinic_2",
  title: "Good Experience",
  comment: "Well organized and professional service.",
  createdAt: DateTime(2025, 1, 16),
  updatedAt: DateTime(2025, 1, 16),
);

final clinicReview3 = Review(
  id: "clinic_review_3",
  uid: "user3",
  rating: 3.8,
  reviewTargetId: "clinic_3",
  title: "Average Visit",
  comment: "The service was decent, but room for improvement.",
  createdAt: DateTime(2025, 1, 17),
  updatedAt: DateTime(2025, 1, 17),
);

final clinicReview4 = Review(
  id: "clinic_review_4",
  uid: "user4",
  rating: 5.0,
  reviewTargetId: "clinic_4",
  title: "Outstanding!",
  comment: "I highly recommend this clinic for its professional staff.",
  createdAt: DateTime(2025, 1, 18),
  updatedAt: DateTime(2025, 1, 18),
);

//
// Dummy Clinic Data (4 clinics)
//
final clinic1 = Clinic(
  beds: 120,
  email: "DowntownHealthClinic@gmail.com",
  clinicName: "Downtown Health Clinic",
  clinicPic: "assets/clinics/clinic1.jpg",
  nurses: [nurse7, nurse8],
  doctors: [doctor1, doctor2],
  // You can populate this later with Doctor objects if needed
  description: "Modern primary care with experienced physicians.",
  clinicSpecialty: ["Primary Care", "Family Medicine"],
  openingHours: {"Mon-Fri": "8:00-18:00", "Sat": "9:00-14:00"},
  address: "123 Main St",
  city: "Metropolis",
  latitude: 40.7128,
  longitude: -74.0060,
  website: "http://downtownclinic.com",
  phoneNumbers: ["+1234567890"],
  emergencyServices: true,
  insuranceAccepted: ["Insurance A", "Insurance B"],
  onlineAppointments: true,
  createdAt: DateTime(2025, 1, 1),
  updatedAt: DateTime(2025, 2, 1),
  reviews: [clinicReview1],
  services: [service1, service2, service3, service4, service6],
  images: ["assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic3.jpg", "assets/clinics/clinic2.jpg", "assets/clinics/clinic1.jpg"],
);

final clinic2 = Clinic(
  beds: 100,
  email: "UptownMedicalCenter@gmail.com",
  clinicName: "Uptown Medical Center",
  clinicPic: "assets/clinics/clinic2.jpg",
  doctors: [doctor3, doctor4],
  nurses: [nurse5, nurse6],
  description: "Comprehensive healthcare services in a comfortable setting.",
  clinicSpecialty: ["Pediatrics", "General Medicine"],
  openingHours: {"Mon-Fri": "9:00-17:00"},
  address: "456 Broad Ave",
  city: "Metropolis",
  latitude: 40.7138,
  longitude: -74.0050,
  website: "http://uptownmedcenter.com",
  phoneNumbers: ["+1234567891"],
  emergencyServices: false,
  insuranceAccepted: ["Insurance C", "Insurance D"],
  onlineAppointments: true,
  createdAt: DateTime(2025, 1, 2),
  updatedAt: DateTime(2025, 2, 2),
  reviews: [clinicReview2, clinicReview1],
  services: [service1, service2, service3, service4],
  images: ["assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic3.jpg", "assets/clinics/clinic2.jpg", "assets/clinics/clinic1.jpg"],
);

final clinic3 = Clinic(
  beds: 80,
  email: "SuburbanFamilyClinic@gmail.com",
  clinicName: "Suburban Family Clinic",
  clinicPic: "assets/clinics/clinic3.jpg",
  doctors: [doctor5, doctor6],
  nurses: [nurse3, nurse4],
  description: "Quality family care for all ages.",
  clinicSpecialty: ["Family Medicine"],
  openingHours: {"Mon-Fri": "8:30-17:30", "Sun": "10:00-14:00"},
  address: "789 Oak Dr",
  city: "Smallville",
  latitude: 41.0000,
  longitude: -75.0000,
  website: "http://suburbanclinic.com",
  phoneNumbers: ["+1234567892"],
  emergencyServices: false,
  insuranceAccepted: ["Insurance A", "Insurance E"],
  onlineAppointments: false,
  createdAt: DateTime(2025, 1, 3),
  updatedAt: DateTime(2025, 2, 3),
  reviews: [clinicReview3],
  services: [service1, service2, service3, service4, service5, service6],
  images: ["assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic3.jpg", "assets/clinics/clinic2.jpg", "assets/clinics/clinic1.jpg"],
);

final clinic4 = Clinic(
  beds: 75,
  clinicName: "City Center Clinic",
  clinicPic: "assets/clinics/clinic4.jpg",
  nurses: [nurse1, nurse2],
  doctors: [doctor7, doctor8],
  description: "Efficient and accessible care in the heart of the city.",
  clinicSpecialty: ["Emergency", "Walk-in"],
  openingHours: {"Mon-Sun": "24 hours"},
  address: "101 Center Plaza",
  city: "Metropolis",
  latitude: 40.7100,
  longitude: -74.0100,
  website: "http://citycenterclinic.com",
  phoneNumbers: ["+1234567893"],
  emergencyServices: true,
  insuranceAccepted: ["Insurance B", "Insurance F"],
  onlineAppointments: false,
  createdAt: DateTime(2025, 1, 4),
  updatedAt: DateTime(2025, 2, 4),
  reviews: [clinicReview4],
  email: 'CityCenterClinic@gmail.com',
  services: [service1, service2, service6],
  images: ["assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic4.jpg", "assets/clinics/clinic3.jpg", "assets/clinics/clinic2.jpg", "assets/clinics/clinic1.jpg"],
);

//
// Dummy Reviews for Doctors
//
final doctorReview1 = Review(
  id: "doctor_review_1",
  uid: "user5",
  rating: 4.8,
  reviewTargetId: "doctor_1",
  title: "Highly Recommend",
  comment: "Dr. John Smith is knowledgeable and caring.",
  createdAt: DateTime(2025, 1, 20),
  updatedAt: DateTime(2025, 1, 20),
);

final doctorReview2 = Review(
  id: "doctor_review_2",
  uid: "user6",
  rating: 4.2,
  reviewTargetId: "doctor_2",
  title: "Great Experience",
  comment: "Dr. Emily Brown made me feel at ease during my visit.",
  createdAt: DateTime(2025, 1, 21),
  updatedAt: DateTime(2025, 1, 21),
);

final doctorReview3 = Review(
  id: "doctor_review_3",
  uid: "user7",
  rating: 3.9,
  reviewTargetId: "doctor_3",
  title: "Good, but Room for Improvement",
  comment: "Overall satisfied with the consultation.",
  createdAt: DateTime(2025, 1, 22),
  updatedAt: DateTime(2025, 1, 22),
);

final doctorReview4 = Review(
  id: "doctor_review_4",
  uid: "user8",
  rating: 5.0,
  reviewTargetId: "doctor_4",
  title: "Excellent Doctor",
  comment: "Dr. Michael Lee is extremely professional.",
  createdAt: DateTime(2025, 1, 23),
  updatedAt: DateTime(2025, 1, 23),
);

final doctorReview5 = Review(
  id: "doctor_review_5",
  uid: "user9",
  rating: 4.7,
  reviewTargetId: "doctor_5",
  title: "Very Caring",
  comment: "Dr. Sarah Davis provided exceptional care.",
  createdAt: DateTime(2025, 1, 24),
  updatedAt: DateTime(2025, 1, 24),
);

final doctorReview6 = Review(
  id: "doctor_review_6",
  uid: "user10",
  rating: 4.3,
  reviewTargetId: "doctor_6",
  title: "Professional and Kind",
  comment: "Dr. Robert Wilson took the time to explain everything.",
  createdAt: DateTime(2025, 1, 25),
  updatedAt: DateTime(2025, 1, 25),
);

final doctorReview7 = Review(
  id: "doctor_review_7",
  uid: "user11",
  rating: 4.9,
  reviewTargetId: "doctor_7",
  title: "Outstanding!",
  comment: "Dr. Linda Taylor is one of the best I've seen.",
  createdAt: DateTime(2025, 1, 26),
  updatedAt: DateTime(2025, 1, 26),
);

final doctorReview8 = Review(
  id: "doctor_review_8",
  uid: "user12",
  rating: 4.0,
  reviewTargetId: "doctor_8",
  title: "Very Good",
  comment: "Dr. James Anderson was professional and attentive.",
  createdAt: DateTime(2025, 1, 27),
  updatedAt: DateTime(2025, 1, 27),
);

//
// Dummy Doctor Data (8 doctors)
//
final doctor1 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. John Smith",
  medicalSpecialty: ["Cardiology"],
  doctorPic: "assets/doctors/user1.webp",
  age: 50,
  address: "456 Elm St",
  city: "Metropolis",
  state: "NY",
  bio: "An experienced cardiologist with a passion for patient care.",
  createdAt: DateTime(2025, 1, 5),
  updatedAt: DateTime(2025, 2, 5),
  reviews: [doctorReview1],
);

final doctor2 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. Emily Brown",
  medicalSpecialty: ["Pediatrics"],
  doctorPic: "assets/doctors/user2.jpg",
  age: 38,
  address: "789 Pine St",
  city: "Metropolis",
  state: "NY",
  bio: "Dedicated to child healthcare and family wellness.",
  createdAt: DateTime(2025, 1, 6),
  updatedAt: DateTime(2025, 2, 6),
  reviews: [doctorReview2],
);

final doctor3 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. Michael Lee",
  medicalSpecialty: ["Orthopedics"],
  doctorPic: "assets/doctors/user3.jpg",
  age: 45,
  address: "321 Cedar Ave",
  city: "Smallville",
  state: "KS",
  bio: "Specialist in musculoskeletal injuries and joint replacement.",
  createdAt: DateTime(2025, 1, 7),
  updatedAt: DateTime(2025, 2, 7),
  reviews: [doctorReview3],
);

final doctor4 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. Sarah Davis",
  medicalSpecialty: ["Dermatology"],
  doctorPic: "assets/doctors/user4.jpg",
  age: 42,
  address: "654 Maple Rd",
  city: "Metropolis",
  state: "NY",
  bio: "Expert in skin conditions with a patient-first approach.",
  createdAt: DateTime(2025, 1, 8),
  updatedAt: DateTime(2025, 2, 8),
  reviews: [doctorReview4],
);

final doctor5 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. Robert Wilson",
  medicalSpecialty: ["Neurology"],
  doctorPic: "assets/doctors/user5.jpg",
  age: 55,
  address: "987 Birch Ln",
  city: "Metropolis",
  state: "NY",
  bio: "Specializing in neurological disorders with extensive experience.",
  createdAt: DateTime(2025, 1, 9),
  updatedAt: DateTime(2025, 2, 9),
  reviews: [doctorReview5],
);

final doctor6 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. Linda Taylor",
  medicalSpecialty: ["Gynecology"],
  doctorPic: "assets/doctors/user6.jpg",
  age: 47,
  address: "159 Walnut St",
  city: "Smallville",
  state: "KS",
  bio: "Committed to women’s health and comprehensive gynecological care.",
  createdAt: DateTime(2025, 1, 10),
  updatedAt: DateTime(2025, 2, 10),
  reviews: [doctorReview6],
);

final doctor7 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. James Anderson",
  medicalSpecialty: ["General Surgery"],
  doctorPic: "assets/doctors/user7.jpg",
  age: 52,
  address: "753 Spruce Dr",
  city: "Metropolis",
  state: "NY",
  bio: "Experienced in minimally invasive surgical techniques.",
  createdAt: DateTime(2025, 1, 11),
  updatedAt: DateTime(2025, 2, 11),
  reviews: [doctorReview7],
);

final doctor8 = Doctor(
  consultationFee: 2500.0,
  adminFee: 1500.0,
  fullName: "Dr. Karen Martinez",
  medicalSpecialty: ["Internal Medicine"],
  doctorPic: "assets/doctors/user8.jpg",
  age: 39,
  address: "246 Oak St",
  city: "Metropolis",
  state: "NY",
  bio: "Focused on preventive care and chronic disease management.",
  createdAt: DateTime(2025, 1, 12),
  updatedAt: DateTime(2025, 2, 12),
  reviews: [doctorReview8],
);

//
// Dummy Reviews for Nurses
//
final nurseReview1 = Review(
  id: "nurse_review_1",
  uid: "user13",
  rating: 4.5,
  reviewTargetId: "nurse_1",
  title: "Very Caring",
  comment: "The nurse was attentive and caring.",
  createdAt: DateTime(2025, 2, 1),
  updatedAt: DateTime(2025, 2, 1),
);

final nurseReview2 = Review(
  id: "nurse_review_2",
  uid: "user14",
  rating: 4.2,
  reviewTargetId: "nurse_2",
  title: "Professional",
  comment: "Handled my concerns professionally.",
  createdAt: DateTime(2025, 2, 2),
  updatedAt: DateTime(2025, 2, 2),
);

final nurseReview3 = Review(
  id: "nurse_review_3",
  uid: "user15",
  rating: 4.8,
  reviewTargetId: "nurse_3",
  title: "Excellent",
  comment: "Very efficient and friendly.",
  createdAt: DateTime(2025, 2, 3),
  updatedAt: DateTime(2025, 2, 3),
);

final nurseReview4 = Review(
  id: "nurse_review_4",
  uid: "user16",
  rating: 4.0,
  reviewTargetId: "nurse_4",
  title: "Good Care",
  comment: "Provided good care during my visit.",
  createdAt: DateTime(2025, 2, 4),
  updatedAt: DateTime(2025, 2, 4),
);

final nurseReview5 = Review(
  id: "nurse_review_5",
  uid: "user17",
  rating: 4.7,
  reviewTargetId: "nurse_5",
  title: "Very Friendly",
  comment: "The nurse was very friendly and knowledgeable.",
  createdAt: DateTime(2025, 2, 5),
  updatedAt: DateTime(2025, 2, 5),
);

final nurseReview6 = Review(
  id: "nurse_review_6",
  uid: "user18",
  rating: 4.3,
  reviewTargetId: "nurse_6",
  title: "Attentive",
  comment: "Took the time to explain everything clearly.",
  createdAt: DateTime(2025, 2, 6),
  updatedAt: DateTime(2025, 2, 6),
);

final nurseReview7 = Review(
  id: "nurse_review_7",
  uid: "user19",
  rating: 4.9,
  reviewTargetId: "nurse_7",
  title: "Outstanding Service",
  comment: "Provided outstanding service and care.",
  createdAt: DateTime(2025, 2, 7),
  updatedAt: DateTime(2025, 2, 7),
);

final nurseReview8 = Review(
  id: "nurse_review_8",
  uid: "user20",
  rating: 4.4,
  reviewTargetId: "nurse_8",
  title: "Very Professional",
  comment: "Exemplary professionalism throughout my visit.",
  createdAt: DateTime(2025, 2, 8),
  updatedAt: DateTime(2025, 2, 8),
);

//
// Dummy Nurse Data (8 nurses)
//
final nurse1 = Nurse(
  fullName: "Nurse Anna Johnson",
  nursingSpecialties: ["Pediatrics", "Neonatal"],
  nursePic: "assets/doctors/user1.webp",
  age: 30,
  address: "111 First Ave",
  city: "Metropolis",
  state: "NY",
  bio: "Dedicated pediatric nurse with a passion for newborn care.",
  yearsOfExperience: 8,
  certifications: ["BLS", "PALS"],
  languagesSpoken: ["English", "Spanish"],
  createdAt: DateTime(2025, 2, 1),
  updatedAt: DateTime(2025, 2, 1),
  reviews: [nurseReview1],
);

final nurse2 = Nurse(
  fullName: "Nurse Brian Lee",
  nursingSpecialties: ["Emergency", "Trauma"],
  nursePic: "assets/doctors/user2.jpg",
  age: 35,
  address: "222 Second St",
  city: "Metropolis",
  state: "NY",
  bio: "Experienced in high-pressure emergency situations.",
  yearsOfExperience: 10,
  certifications: ["ACLS", "BLS"],
  languagesSpoken: ["English"],
  createdAt: DateTime(2025, 2, 2),
  updatedAt: DateTime(2025, 2, 2),
  reviews: [nurseReview2],
);

final nurse3 = Nurse(
  fullName: "Nurse Catherine Smith",
  nursingSpecialties: ["Oncology", "Palliative Care"],
  nursePic: "assets/doctors/user3.jpg",
  age: 40,
  address: "333 Third Blvd",
  city: "Smallville",
  state: "KS",
  bio: "Compassionate nurse specializing in cancer care.",
  yearsOfExperience: 12,
  certifications: ["BLS", "Oncology Nursing Certification"],
  languagesSpoken: ["English", "French"],
  createdAt: DateTime(2025, 2, 3),
  updatedAt: DateTime(2025, 2, 3),
  reviews: [nurseReview3],
);

final nurse4 = Nurse(
  fullName: "Nurse David Kim",
  nursingSpecialties: ["Critical Care", "ICU"],
  nursePic: "assets/doctors/user4.jpg",
  age: 38,
  address: "444 Fourth Rd",
  city: "Metropolis",
  state: "NY",
  bio: "Expert in critical care with a focus on ICU patient management.",
  yearsOfExperience: 9,
  certifications: ["ACLS", "BLS", "CCRN"],
  languagesSpoken: ["English", "Korean"],
  createdAt: DateTime(2025, 2, 4),
  updatedAt: DateTime(2025, 2, 4),
  reviews: [nurseReview4],
);

final nurse5 = Nurse(
  fullName: "Nurse Emily Garcia",
  nursingSpecialties: ["Medical-Surgical", "General Care"],
  nursePic: "assets/doctors/user5.jpg",
  age: 32,
  address: "555 Fifth Ln",
  city: "Smallville",
  state: "KS",
  bio: "Provides excellent general care in busy hospital settings.",
  yearsOfExperience: 7,
  certifications: ["BLS", "Medical-Surgical Nursing Certification"],
  languagesSpoken: ["English", "Spanish"],
  createdAt: DateTime(2025, 2, 5),
  updatedAt: DateTime(2025, 2, 5),
  reviews: [nurseReview5],
);

final nurse6 = Nurse(
  fullName: "Nurse Frank Martinez",
  nursingSpecialties: ["Surgical", "Post-Op"],
  nursePic: "assets/doctors/user6.jpg",
  age: 36,
  address: "666 Sixth Ave",
  city: "Metropolis",
  state: "NY",
  bio: "Assists in surgeries and provides exceptional post-operative care.",
  yearsOfExperience: 11,
  certifications: ["BLS", "Surgical Nursing Certification"],
  languagesSpoken: ["English"],
  createdAt: DateTime(2025, 2, 6),
  updatedAt: DateTime(2025, 2, 6),
  reviews: [nurseReview6],
);

final nurse7 = Nurse(
  fullName: "Nurse Grace Patel",
  nursingSpecialties: ["Community Health", "Public Health"],
  nursePic: "assets/doctors/user7.jpg",
  age: 29,
  address: "777 Seventh St",
  city: "Metropolis",
  state: "NY",
  bio: "Focused on community health and preventive care.",
  yearsOfExperience: 5,
  certifications: ["BLS", "Community Health Nursing"],
  languagesSpoken: ["English", "Hindi"],
  createdAt: DateTime(2025, 2, 7),
  updatedAt: DateTime(2025, 2, 7),
  reviews: [nurseReview7],
);

final nurse8 = Nurse(
  fullName: "Nurse Henry Wilson",
  nursingSpecialties: ["Geriatric", "Rehabilitation"],
  nursePic: "assets/doctors/user8.jpg",
  age: 42,
  address: "888 Eighth Blvd",
  city: "Smallville",
  state: "KS",
  bio: "Experienced in caring for the elderly and rehabilitative patients.",
  yearsOfExperience: 14,
  certifications: ["BLS", "Geriatric Nursing Certification"],
  languagesSpoken: ["English", "German"],
  createdAt: DateTime(2025, 2, 8),
  updatedAt: DateTime(2025, 2, 8),
  reviews: [nurseReview8],
);

final service1 = Service(
  name: 'Pediatric Care',
  description: 'Specialized care for infants, children, and adolescents.',
  range: '1 hour',
  price: 90.0,
  isAvailable: true,
  images: ['https://example.com/images/pediatric_care.jpg'],
);
final service2 = Service(
  name: 'Physiotherapy Session',
  description: 'Personalized therapy sessions to aid recovery from injuries.',
  range: '1 hour',
  price: 70.0,
  isAvailable: true,
  images: ['https://example.com/images/physiotherapy.jpg'],
);
final service3 = Service(
  name: 'Nutrition Consultation',
  description: 'Expert advice to improve your diet and overall well-being.',
  range: '30 mins',
  price: 40.0,
  isAvailable: true,
  images: ['https://example.com/images/nutrition.jpg'],
);
final service4 = Service(
  name: 'Cardiology Checkup',
  description: 'Thorough examination of your heart and cardiovascular system.',
  range: '1 hour',
  price: 120.0,
  isAvailable: false,
  images: ['https://example.com/images/cardiology_checkup.jpg'],
);
final service5 = Service(
  name: 'Dental Cleaning',
  description: 'Professional cleaning of your teeth to maintain oral hygiene.',
  range: '45 mins',
  price: 80.0,
  isAvailable: true,
  images: [
    'https://example.com/images/dental_cleaning1.jpg',
    'https://example.com/images/dental_cleaning2.jpg',
  ],
);
final service6 = Service(
  name: 'General Consultation',
  description: 'A comprehensive check-up for your general health needs.',
  range: '30 mins',
  price: 50.0,
  isAvailable: true,
  images: [
    'https://example.com/images/general_consultation1.jpg',
    'https://example.com/images/general_consultation2.jpg',
  ],
);

//
// Aggregated Dummy Data Lists
//
final List<Clinic> dummyClinics = [clinic1, clinic2, clinic3, clinic4];
final List<Service> dummyServices = [
  service1,
  service2,
  service3,
  service4,
  service5,
  service6,
];
final List<Doctor> dummyDoctors = [
  doctor1,
  doctor2,
  doctor3,
  doctor4,
  doctor5,
  doctor6,
  doctor7,
  doctor8,
];
final List<Nurse> dummyNurses = [
  nurse1,
  nurse2,
  nurse3,
  nurse4,
  nurse5,
  nurse6,
  nurse7,
  nurse8,
];

final List<Pharmacy> dummyPharmacy = [
  pharmacy1,
  pharmacy2,
  pharmacy3,
  pharmacy4,
];

final List<Product> dummyProduct = [
  product1,
  product2,
  product3,
  product4,
  product5,
  product6,

];



