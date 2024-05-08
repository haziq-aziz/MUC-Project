import 'package:flutter/material.dart';
import 'menupackage.dart';

class PackageDetail extends StatefulWidget {
  final Menupackage menupackage;
  const PackageDetail({Key? key, required this.menupackage}) : super(key: key);

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
                  return Text('${detail.name}');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your functionality for "Add to Cart" here
              },
              child: const Text('Calculate per pax'),
            
            ),
          ],
        ),
      ),
    );
  }
}
