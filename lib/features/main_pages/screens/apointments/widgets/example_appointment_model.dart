class AppointmentItem {
  final String doctorName;
  final String doctorSpecialty;
  final String? doctorPfpUrl;
  final String? avatarUrl;
  final String patientName;
  final String time;
  final String date;
  final String state;
  final bool isFinished;
  final bool isCanceled;

  AppointmentItem({
    required this.doctorName,
    required this.doctorSpecialty,
    this.doctorPfpUrl,
    this.avatarUrl,
    required this.patientName,
    required this.time,
    required this.date,
    required this.state,
    required this.isFinished,
    required this.isCanceled,
  });
}
