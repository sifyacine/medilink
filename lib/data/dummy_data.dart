// dummy_data.dart

// Import your models
import '../features/main_pages/models/clinic_model.dart';
import '../features/main_pages/models/doctor_model.dart';
import '../features/main_pages/models/reviews_model.dart';
import '../features/main_pages/models/nurse_model.dart';

//
// Dummy Reviews for Clinics
//
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
  clinicName: "Downtown Health Clinic",
  clinicPic: "assets/clinics/clinic1.jpg",
  doctors: [], // You can populate this later with Doctor objects if needed
  description: "Modern primary care with experienced physicians.",
  clinicSpecialty: ["Primary Care", "Family Medicine"],
  openingHours: {"Mon-Fri": "8:00-18:00", "Sat": "9:00-14:00"},
  address: "123 Main St",
  city: "Metropolis",
  latitude: 40.7128,
  longitude: -74.0060,
  website: "http://downtownclinic.com",
  phoneNumber: "+1234567890",
  emergencyServices: true,
  insuranceAccepted: ["Insurance A", "Insurance B"],
  onlineAppointments: true,
  createdAt: DateTime(2025, 1, 1),
  updatedAt: DateTime(2025, 2, 1),
  reviews: [clinicReview1],
);

final clinic2 = Clinic(
  clinicName: "Uptown Medical Center",
  clinicPic: "assets/clinics/clinic2.jpg",
  doctors: [],
  description: "Comprehensive healthcare services in a comfortable setting.",
  clinicSpecialty: ["Pediatrics", "General Medicine"],
  openingHours: {"Mon-Fri": "9:00-17:00"},
  address: "456 Broad Ave",
  city: "Metropolis",
  latitude: 40.7138,
  longitude: -74.0050,
  website: "http://uptownmedcenter.com",
  phoneNumber: "+1234567891",
  emergencyServices: false,
  insuranceAccepted: ["Insurance C", "Insurance D"],
  onlineAppointments: true,
  createdAt: DateTime(2025, 1, 2),
  updatedAt: DateTime(2025, 2, 2),
  reviews: [clinicReview2],
);

final clinic3 = Clinic(
  clinicName: "Suburban Family Clinic",
  clinicPic: "assets/clinics/clinic3.jpg",
  doctors: [],
  description: "Quality family care for all ages.",
  clinicSpecialty: ["Family Medicine"],
  openingHours: {"Mon-Fri": "8:30-17:30", "Sun": "10:00-14:00"},
  address: "789 Oak Dr",
  city: "Smallville",
  latitude: 41.0000,
  longitude: -75.0000,
  website: "http://suburbanclinic.com",
  phoneNumber: "+1234567892",
  emergencyServices: false,
  insuranceAccepted: ["Insurance A", "Insurance E"],
  onlineAppointments: false,
  createdAt: DateTime(2025, 1, 3),
  updatedAt: DateTime(2025, 2, 3),
  reviews: [clinicReview3],
);

final clinic4 = Clinic(
  clinicName: "City Center Clinic",
  clinicPic: "assets/clinics/clinic4.jpg",
  doctors: [],
  description: "Efficient and accessible care in the heart of the city.",
  clinicSpecialty: ["Emergency", "Walk-in"],
  openingHours: {"Mon-Sun": "24 hours"},
  address: "101 Center Plaza",
  city: "Metropolis",
  latitude: 40.7100,
  longitude: -74.0100,
  website: "http://citycenterclinic.com",
  phoneNumber: "+1234567893",
  emergencyServices: true,
  insuranceAccepted: ["Insurance B", "Insurance F"],
  onlineAppointments: false,
  createdAt: DateTime(2025, 1, 4),
  updatedAt: DateTime(2025, 2, 4),
  reviews: [clinicReview4],
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
  fullName: "Dr. John Smith",
  medicalSpecialty: ["Cardiology"],
  doctorPic: "assets/images/doctor1.jpg",
  age: 50,
  address: "456 Elm St",
  city: "Metropolis",
  state: "NY",
  bio: "An experienced cardiologist with a passion for patient care.",
  affiliatedClinics: [clinic1, clinic2],
  createdAt: DateTime(2025, 1, 5),
  updatedAt: DateTime(2025, 2, 5),
  reviews: [doctorReview1],
);

final doctor2 = Doctor(
  fullName: "Dr. Emily Brown",
  medicalSpecialty: ["Pediatrics"],
  doctorPic: "assets/images/doctor2.jpg",
  age: 38,
  address: "789 Pine St",
  city: "Metropolis",
  state: "NY",
  bio: "Dedicated to child healthcare and family wellness.",
  affiliatedClinics: [clinic2],
  createdAt: DateTime(2025, 1, 6),
  updatedAt: DateTime(2025, 2, 6),
  reviews: [doctorReview2],
);

final doctor3 = Doctor(
  fullName: "Dr. Michael Lee",
  medicalSpecialty: ["Orthopedics"],
  doctorPic: "assets/images/doctor3.jpg",
  age: 45,
  address: "321 Cedar Ave",
  city: "Smallville",
  state: "KS",
  bio: "Specialist in musculoskeletal injuries and joint replacement.",
  affiliatedClinics: [clinic3],
  createdAt: DateTime(2025, 1, 7),
  updatedAt: DateTime(2025, 2, 7),
  reviews: [doctorReview3],
);

final doctor4 = Doctor(
  fullName: "Dr. Sarah Davis",
  medicalSpecialty: ["Dermatology"],
  doctorPic: "assets/images/doctor4.jpg",
  age: 42,
  address: "654 Maple Rd",
  city: "Metropolis",
  state: "NY",
  bio: "Expert in skin conditions with a patient-first approach.",
  affiliatedClinics: [clinic1, clinic4],
  createdAt: DateTime(2025, 1, 8),
  updatedAt: DateTime(2025, 2, 8),
  reviews: [doctorReview4],
);

final doctor5 = Doctor(
  fullName: "Dr. Robert Wilson",
  medicalSpecialty: ["Neurology"],
  doctorPic: "assets/images/doctor5.jpg",
  age: 55,
  address: "987 Birch Ln",
  city: "Metropolis",
  state: "NY",
  bio: "Specializing in neurological disorders with extensive experience.",
  affiliatedClinics: [clinic4],
  createdAt: DateTime(2025, 1, 9),
  updatedAt: DateTime(2025, 2, 9),
  reviews: [doctorReview5],
);

final doctor6 = Doctor(
  fullName: "Dr. Linda Taylor",
  medicalSpecialty: ["Gynecology"],
  doctorPic: "assets/images/doctor6.jpg",
  age: 47,
  address: "159 Walnut St",
  city: "Smallville",
  state: "KS",
  bio: "Committed to women’s health and comprehensive gynecological care.",
  affiliatedClinics: [clinic3],
  createdAt: DateTime(2025, 1, 10),
  updatedAt: DateTime(2025, 2, 10),
  reviews: [doctorReview6],
);

final doctor7 = Doctor(
  fullName: "Dr. James Anderson",
  medicalSpecialty: ["General Surgery"],
  doctorPic: "assets/images/doctor7.jpg",
  age: 52,
  address: "753 Spruce Dr",
  city: "Metropolis",
  state: "NY",
  bio: "Experienced in minimally invasive surgical techniques.",
  affiliatedClinics: [clinic1, clinic3],
  createdAt: DateTime(2025, 1, 11),
  updatedAt: DateTime(2025, 2, 11),
  reviews: [doctorReview7],
);

final doctor8 = Doctor(
  fullName: "Dr. Karen Martinez",
  medicalSpecialty: ["Internal Medicine"],
  doctorPic: "assets/images/doctor8.jpg",
  age: 39,
  address: "246 Oak St",
  city: "Metropolis",
  state: "NY",
  bio: "Focused on preventive care and chronic disease management.",
  affiliatedClinics: [clinic2, clinic4],
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
  nursePic: "assets/images/nurse1.jpg",
  age: 30,
  address: "111 First Ave",
  city: "Metropolis",
  state: "NY",
  bio: "Dedicated pediatric nurse with a passion for newborn care.",
  affiliatedClinics: [clinic1, clinic2],
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
  nursePic: "assets/images/nurse2.jpg",
  age: 35,
  address: "222 Second St",
  city: "Metropolis",
  state: "NY",
  bio: "Experienced in high-pressure emergency situations.",
  affiliatedClinics: [clinic2],
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
  nursePic: "assets/images/nurse3.jpg",
  age: 40,
  address: "333 Third Blvd",
  city: "Smallville",
  state: "KS",
  bio: "Compassionate nurse specializing in cancer care.",
  affiliatedClinics: [clinic3],
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
  nursePic: "assets/images/nurse4.jpg",
  age: 38,
  address: "444 Fourth Rd",
  city: "Metropolis",
  state: "NY",
  bio: "Expert in critical care with a focus on ICU patient management.",
  affiliatedClinics: [clinic1, clinic4],
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
  nursePic: "assets/images/nurse5.jpg",
  age: 32,
  address: "555 Fifth Ln",
  city: "Smallville",
  state: "KS",
  bio: "Provides excellent general care in busy hospital settings.",
  affiliatedClinics: [clinic3],
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
  nursePic: "assets/images/nurse6.jpg",
  age: 36,
  address: "666 Sixth Ave",
  city: "Metropolis",
  state: "NY",
  bio: "Assists in surgeries and provides exceptional post-operative care.",
  affiliatedClinics: [clinic4],
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
  nursePic: "assets/images/nurse7.jpg",
  age: 29,
  address: "777 Seventh St",
  city: "Metropolis",
  state: "NY",
  bio: "Focused on community health and preventive care.",
  affiliatedClinics: [clinic1, clinic2],
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
  nursePic: "assets/images/nurse8.jpg",
  age: 42,
  address: "888 Eighth Blvd",
  city: "Smallville",
  state: "KS",
  bio: "Experienced in caring for the elderly and rehabilitative patients.",
  affiliatedClinics: [clinic2, clinic4],
  yearsOfExperience: 14,
  certifications: ["BLS", "Geriatric Nursing Certification"],
  languagesSpoken: ["English", "German"],
  createdAt: DateTime(2025, 2, 8),
  updatedAt: DateTime(2025, 2, 8),
  reviews: [nurseReview8],
);

//
// Aggregated Dummy Data Lists
//
final List<Clinic> dummyClinics = [clinic1, clinic2, clinic3, clinic4];
final List<Doctor> dummyDoctors = [doctor1, doctor2, doctor3, doctor4, doctor5, doctor6, doctor7, doctor8];
final List<Nurse> dummyNurses = [nurse1, nurse2, nurse3, nurse4, nurse5, nurse6, nurse7, nurse8];
