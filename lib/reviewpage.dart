import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;
  final _reviewController = TextEditingController();
  String? _selectedPackage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StarRating(
              value: _rating,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(
                    color: Color.fromARGB(255, 103, 101, 101), width: 2),
              ),
              elevation: 4,
              child: DropdownButton<String>(
                value: _selectedPackage,
                onChanged: (value) {
                  setState(() {
                    _selectedPackage = value;
                  });
                },
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                items: [
                  'Fusion Package',
                  'Western Package',
                  'Thai Package',
                ].map((package) {
                  return DropdownMenuItem<String>(
                    value: package,
                    child: Text(package),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Write your review',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_selectedPackage != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThankYouPage(
                        review: _reviewController.text,
                        rating: _rating,
                        package: _selectedPackage!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a package'),
                    ),
                  );
                }
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const StarRating({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    const size = 36.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            onChanged(index + 1);
          },
          color: const Color.fromARGB(255, 218, 201, 52),
          iconSize: size,
          icon: Icon(
            index < value ? Icons.star : Icons.star_border,
          ),
          padding: EdgeInsets.zero,
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}

class ThankYouPage extends StatelessWidget {
  final String review;
  final int rating;
  final String package;

  const ThankYouPage(
      {super.key,
      required this.review,
      required this.rating,
      required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank You'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReviewBox(
              title: 'Your Review',
              review: review,
              rating: rating.toDouble(),
              package: package,
            ),
            Divider(
              color: Colors.grey[300],
              height: 16,
            ),
            const ReviewBox(
              title: 'Menchabot',
              review: 'Delicious food!! Very GOODDD',
              rating: 5.0,
              package: 'Western Package',
            ),
            Divider(
              color: Colors.grey[300],
              height: 16,
            ),
            const ReviewBox(
              title: 'Izz',
              review: 'Very recommended',
              rating: 4.0,
              package: 'Fusion Pckage',
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewBox extends StatelessWidget {
  final String title;
  final double rating;
  final String review;
  final String package;

  const ReviewBox({
    super.key,
    required this.title,
    required this.rating,
    required this.review,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Package: $package',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 4),
        StarRating(
          value: rating.toInt(),
          onChanged: (value) {},
        ),
        const SizedBox(height: 16),
        Text(
          review,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
