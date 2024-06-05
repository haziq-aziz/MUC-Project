import 'package:intl/intl.dart';

class MenuBook {
  final int bookId;
  final int userId;
  final DateTime bookDate;
  final DateTime bookTime;
  final DateTime eventDate;
  final DateTime eventTime;
  final String menuPackage;
  final int numGuest;
  final double packagePrice;

  MenuBook({
    required this.bookId,
    required this.userId,
    required this.bookDate,
    required this.bookTime,
    required this.eventDate,
    required this.eventTime,
    required this.menuPackage,
    required this.numGuest,
    required this.packagePrice,
  });

  factory MenuBook.fromMap(Map<String, dynamic> map) {
    return MenuBook(
      bookId: map['bookid'],
      userId: map['userid'],
      bookDate: DateTime.parse(map['bookdate']),
      bookTime: DateFormat('HH:mm:ss').parse(map['booktime']),
      eventDate: DateTime.parse(map['eventdate']),
      eventTime: DateFormat('HH:mm:ss').parse(map['eventtime']),
      menuPackage: map['menupackage'],
      numGuest: map['numguest'],
      packagePrice: map['packageprice'],
    );
  }
}