class Restoran {
  String imageUrl;
  String name;
  String foodsd;
  String launch;

  Restoran({
    required this.imageUrl,
    required this.name,
    required this.foodsd,
    required this.launch,
  });
}

final List<Restoran> restorans = [
  Restoran(
    imageUrl: 'assets/images/grilledham.png',
    name: 'Grilled Ham',
    foodsd: 'Western package',
    launch: 'Available on 7 july',
  ),
  Restoran(
    imageUrl: 'assets/images/taco.png',
    name: 'Taco Bell',
    foodsd: 'Western package',
    launch: 'Available on 9 july',
  ),
  Restoran(
    imageUrl: 'assets/images/chickentandoori.png',
    name: 'Tandoori Chicken',
    foodsd: 'Indian package',
    launch: 'Available on 15 july',
  ),
];
