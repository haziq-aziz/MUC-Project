import 'package:restaurantbooking/models/activity_model.dart';


class Destination {
  String imageUrl;
  String nopackage;
  String tpackage;
  String description;
  List<Activity> activities;

  Destination({
    required this.imageUrl,
    required this.nopackage,
    required this.tpackage,
    required this.description,
    required this.activities,
  });
}

List<Activity> foods = [
  Activity(
    imageUrl: 'assets/images/tembikai1.jpg',
    name: 'Watermelon Juice Lovely',
    descfood: 'Makizushi are rice-based rolls wrapped in nori seaweed..',
    //startTimes: ['breakfast','lunch'],
    rating: 5,
    price: '1',

  ),
  Activity(
    imageUrl: 'assets/images/sushifusion.png',
    name: 'Sushi rolls',
    descfood: 'Makizushi are rice-based rolls wrapped in nori seaweed..',
    //startTimes: ['breakfast',''],
    rating: 5,
    price: '2',

  ),
  Activity(
    imageUrl: 'assets/images/teriyakifusion.png',
    name: 'Teriyaki pizza',
    descfood: 'It flavors of teriyaki sauce with the classic comfort of pizza ',
    //startTimes: ['lunch', 'dinner'],
    rating: 4,
    price: '3',
  ),
  Activity(
    imageUrl: 'assets/images/kimchifriedfusion.png',
    name: 'Kimchi fried rice',
    descfood: 'It seasoned with spices, and butter, resulting in crispy skin and juicy meat.',
    //startTimes: ['lunch', 'dinner'],
    rating: 3,
    price: '4',
  ),

];


List<Activity> foods2 = [
  Activity(
    imageUrl: 'assets/images/chickenwingswestern.png',
    name: 'Chicken wings',
    descfood: 'baked, fried, smoked, grilled, or even made into soup.',
    //startTimes: ['breakfast','lunch'],
    rating: 5,
    price: '1',
  ),
  Activity(
    imageUrl: 'assets/images/grilledwestern.png',
    name: 'Grilled steak',
    descfood: 'It combines a caramelized, smoky exterior with a tender, juicy interior. ',
    //startTimes: ['lunch', 'dinner'],
    rating:5,
    price: '2',
  ),
  Activity(
    imageUrl: 'assets/images/roastedchickenwestern.png',
    name: 'Roasted chicken',
    descfood: 'It seasoned with spices, and butter, resulting in crispy skin and juicy meat.',
    //startTimes: ['lunch', 'dinner'],
    rating: 3,
    price: '3',
  ),
];

List<Activity> foods3 = [
  Activity(
    imageUrl: 'assets/images/padthai.png',
    name: 'Pad Thai',
    descfood: 'It combines stir-fried rice noodles with eggs and tofu',
    //startTimes: ['lunch', 'dinner'],
    rating: 4,
    price: '1',
  ),
  Activity(
    imageUrl: 'assets/images/tomyamthai.png',
    name: 'Tom Yam',
    descfood: 'often served as a spicy, sour, and aromatic soup.',
    //startTimes: ['lunch', 'dinner'],
    rating: 5,
    price: '2',
  ),

  Activity(
    imageUrl: 'assets/images/massamathai.png',
    name: 'Massaman beef curry',
    descfood: 'It rich and fragrant Thai coconut curry featuring tender, fall-apart beef',
    //startTimes: ['lunch', 'dinner'],
    rating: 3,
    price: '3',
  ),
];

List<Activity> foods4 = [
  Activity(
    imageUrl: 'assets/images/samosasindian.png',
    name: 'Samosas',
    descfood: 'Pastry with a savory filling. It is spiced potatoes, onions, peas or fish. ',
    //startTimes: ['breakfast','lunch'],
    rating: 5,
    price: '1',
  ),
  Activity(
    imageUrl: 'assets/images/palakindia.png',
    name: 'Palak paneer',
    descfood: 'Dish made with succulent cubes of paneer Indian cottage cheese',
    //startTimes: ['lunch', 'dinner'],
    rating: 5,
    price: '2',
  ),
  Activity(
    imageUrl: 'assets/images/naanindia.png',
    name: 'Naan bread ',
    descfood: 'It is a soft, moist and originating from Indian cuisine.',
    //startTimes: ['lunch', 'dinner'],
    rating: 3,
    price: '3',
  ),
];

List<Activity> foods5 = [
  Activity(
    imageUrl: 'assets/images/teriyakijapan.png',
    name: 'Teriyaki chicken',
    descfood: 'It is is a quick and easy chicken stir-fry that delicious and healthy.',
    //startTimes: ['lunch', 'dinner'],
    rating: 5,
    price: '1',
  ),
  Activity(
    imageUrl: 'assets/images/sushiplatter.png',
    name: 'Sushi platter',
    descfood: 'It is pleasing and delicious assortment of sushi pieces.',
    //startTimes: ['lunch', 'dinner'],
    rating: 4,
    price: '2',
  ),
  Activity(
    imageUrl: 'assets/images/misosoupjapan.png',
    name: 'Miso soup',
    descfood: 'It is comforting, brothy soup that’s both delicious and nutritious! ',
    //startTimes: ['lunch', 'dinner'],
    rating: 3,
    price: '3',
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/fusion.png',
    nopackage: 'Package 1',
    tpackage: 'Fusion Package',
    description: 'Fusion food refers to culinary creations that combine elements cultures and cuisines into new inventive ',
    activities: foods,
  ),
  Destination(
    imageUrl: 'assets/images/western.png',
    nopackage: 'Package 2',
    tpackage: 'Western Package',
    description: 'Western cuisine encompasses a wide range of dishes from various European and American traditions.',
    activities: foods2,
  ),
  Destination(
    imageUrl: 'assets/images/thai.png',
    nopackage: 'Package 3',
    tpackage: 'Thai Package',
    description: 'Thai cuisine is rich, flavorful, and deeply influenced by its history and culture draws from ancient. ',
    activities: foods3,
  ),
  Destination(
    imageUrl: 'assets/images/indianpackage.png',
    nopackage: 'Package 4',
    tpackage: 'Indian Package',
    description: 'An Indian package offers a variety of dishes from the diverse regions of India, known for their rich spices and flavors.',
    activities: foods4,
  ),
  Destination(
    imageUrl: 'assets/images/japanesepackage.png',
    nopackage: 'Package 5',
    tpackage: 'Japanese Package',
    description: 'A Japanese package features traditional Japanese cuisine, which is known for its emphasis on seasonal ingredients.',
    activities: foods5,
  ),
];
