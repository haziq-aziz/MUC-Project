import 'package:restaurantbooking/models/activity_model.dart';


class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.description,
    required this.activities,
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/fusion.png',
    name: 'Fusion packages(1)',
    personpax: '5 pax - 10 pax',
    startTimes: ['8.30 am','9:00 am', '11:00 am'],
    rating: 5,
    price: 50,
  ),
  Activity(
    imageUrl: 'assets/images/western.png',
    name: 'Western packages(2)',
    personpax: '7 pax - 15 pax',
    startTimes: ['12:00 pm', '1:00 pm'],
    rating: 4,
    price: 40,
  ),
  Activity(
    imageUrl: 'assets/images/thai.png',
    name: 'Thai packages(3)',
    personpax: '7 pax - 20 pax',
    startTimes: ['7:30 pm', '8:00 pm'],
    rating: 3,
    price: 30,
  ),
];


// List<Activity> packagess = [
//   Activity(
//     imageUrl: 'assets/images/fusion.png',
//     name: 'Fusion packages',
//     personpax: '5 pax - 10 pax',
//     startTimes: ['8.30 am','9:00 am', '11:00 am'],
//     rating: 5,
//     price: 30,
//   ),
//   Activity(
//     imageUrl: 'assets/images/gondola.jpg',
//     name: 'Western packages',
//     personpax: '7 pax - 15 pax',
//     startTimes: ['12:00 pm', '1:00 pm'],
//     rating: 4,
//     price: 50,
//   ),
//   Activity(
//     imageUrl: 'assets/images/murano.jpg',
//     name: 'Thai packages',
//     personpax: '7 pax - 20 pax',
//     startTimes: ['7:30 pm', '8:00 pm'],
//     rating: 3,
//     price: 50,
//   ),
// ];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/quillmall.png',
    city: 'Cafe Ruuma',
    country: 'Kampung Baru',
    description: 'Café Ruuma at Quill City Mall is a homely restaurant in a home kitchen',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/restoranAyam.png',
    city: 'Ayam Kampung',
    country: 'Petaling Jaya',
    description: 'Every dish is prepared in a home kitchen, and the casual, open-air restaurant is built.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/restoranAli.png',
    city: 'Restoran Ali',
    country: 'Kuchai Exchange',
    description: 'If you’re a fan of seafood, this is a must-visit spot in the Kuchai Lama Hawker Centre area.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/restoranAnis.png',
    city: 'Restoran Anis',
    country: 'Kampung Baru',
    description: 'Anis Puteri Gulai Kawah is known for its rich and aromatic gulai dishes',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/restoranTijah.png',
    city: 'Medan Tijah',
    country: 'Jalan P.Ramlee',
    description: 'Enjoy fresh fish and other seafood dishes with a view of the city.',
    activities: activities,
  ),
];
