// appointment_state.dart
// appointment_state.dart

import 'package:flutter/material.dart';

sealed class AppointmentState {
  final String statusName;
  final Color statusColor;
  final bool canCancel;
  final bool canReschedule;

  const AppointmentState({
    required this.statusName,
    required this.statusColor,
    required this.canCancel,
    required this.canReschedule,
  });

  factory AppointmentState.fromString(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return UpcomingAppointmentState();
      case 'confirmed':
        return ConfirmedAppointmentState();
      case 'completed':
        return CompletedAppointmentState();
      case 'canceled':
        return CanceledAppointmentState();
      default:
        throw ArgumentError('Invalid appointment state: $status');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppointmentState &&
              runtimeType == other.runtimeType &&
              statusName == other.statusName;

  @override
  int get hashCode => statusName.hashCode;

  @override
  String toString() => statusName;
}

class UpcomingAppointmentState extends AppointmentState {
  UpcomingAppointmentState()
      : super(
    statusName: 'Upcoming',
    statusColor: Colors.orange,
    canCancel: true,
    canReschedule: true,
  );
}

class ConfirmedAppointmentState extends AppointmentState {
  ConfirmedAppointmentState()
      : super(
    statusName: 'Confirmed',
    statusColor: Colors.green,
    canCancel: true,
    canReschedule: true,
  );
}

class CompletedAppointmentState extends AppointmentState {
  CompletedAppointmentState()
      : super(
    statusName: 'Completed',
    statusColor: Colors.blue,
    canCancel: false,
    canReschedule: false,
  );
}

class CanceledAppointmentState extends AppointmentState {
  CanceledAppointmentState()
      : super(
    statusName: 'Canceled',
    statusColor: Colors.red,
    canCancel: false,
    canReschedule: false,
  );
}