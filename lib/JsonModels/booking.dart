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

  Map<String, dynamic> toMap() {
    return {
      'bookid': bookId,
      'userid': userId,
      'bookdate': DateFormat('yyyy-MM-dd').format(bookDate),
      'booktime': DateFormat('HH:mm:ss').format(bookTime),
      'eventdate': DateFormat('yyyy-MM-dd').format(eventDate),
      'eventtime': DateFormat('HH:mm:ss').format(eventTime),
      'menupackage': menuPackage,
      'numguest': numGuest,
      'packageprice': packagePrice,
    };
  }

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
