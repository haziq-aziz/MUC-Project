// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'menupackage.dart';
import 'checkoutform.dart';

class PackageDetail extends StatefulWidget {
  final Menupackage menupackage;
  const PackageDetail({super.key, required this.menupackage});

  @override
  _PackageDetailState createState() {
    return _PackageDetailState();
  }
}

class _PackageDetailState extends State<PackageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menupackage.label),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(image: AssetImage(widget.menupackage.imageUrl)),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.menupackage.label,
              style: const TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.menupackage.details.length,
                itemBuilder: (BuildContext context, int index) {
                  final detail = widget.menupackage.details[index];
                  return Text(detail.name);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to CheckoutForm when button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Payment'),
                  ),
                );
              },
              child: const Text('Calculate per pax'),
            ),
          ],
        ),
      ),
    );
  }
}
