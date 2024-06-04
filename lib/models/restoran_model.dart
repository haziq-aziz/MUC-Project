class Restoran {
  String imageUrl;
  String name;
  String address;
  int price;

  Restoran({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.price,
  });
}

final List<Restoran> restorans = [
  Restoran(
    imageUrl: 'assets/images/sogo.png',
    name: 'Sogo selera',
    address: 'Jalan TAR, KL',
    price: 56,
  ),
  Restoran(
    imageUrl: 'assets/images/restoran2.png',
    name: 'Restoran Jalan Tar',
    address: 'Jalan TAR, KL',
    price: 45,
  ),
  Restoran(
    imageUrl: 'assets/images/restoran3.png',
    name: 'Restoran Selatan',
    address: 'Jalan Chow Kit, KL',
    price: 30,
  ),
];
