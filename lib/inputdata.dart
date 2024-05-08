import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationFormData {
  String? name;
  String? address;
  String? phone;
  String? email;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? additionalRequest;
  String? numberOfGuests;

  ReservationFormData({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.selectedDate,
    required this.selectedTime,
    required this.additionalRequest,
    required this.numberOfGuests,
  });

  @override
String toString() {
  // Format date using DateFormat
  String formattedDate = selectedDate != null
      ? DateFormat('dd MM yyyy').format(selectedDate!)
      : 'None';

  // Format time using TimeOfDay.toString()
  String formattedTime = selectedTime != null
      ? selectedTime.toString()
      : 'None'; // Display 'None' if selectedTime is null

  return 'ReservationFormData{name: $name, address: $address, phone: $phone, email: $email, selectedDate: $formattedDate, selectedTime: $formattedTime, additionalRequest: $additionalRequest, numberOfGuests: $numberOfGuests}';
}

}
