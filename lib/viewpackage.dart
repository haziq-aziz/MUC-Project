import 'package:flutter/material.dart';
import 'menupackage.dart';
import 'package_detail.dart';

class ViewPackage extends StatefulWidget {
  final String name;

  const ViewPackage({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<ViewPackage> createState() => _ViewPackageState();
}

class _ViewPackageState extends State<ViewPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selera Kampung", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
      backgroundColor:Color(0xFF4B9EA6),),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the name here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Hello, ${widget.name}",
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Color(0xFF4B9EA6),
                      ),
                    ),
                    Text(
                      "Select your desired package",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            // Container to display the list of packages
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Our Packages",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4B9EA6),
                ),
              ),
            ),
            SizedBox(height: 10), // Add gap here
            // ListView to display the list of packages
            Expanded(
              child: ListView.builder(
                itemCount: Menupackage.samples.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PackageDetail(
                              menupackage: Menupackage.samples[index],
                            );
                          },
                        ),
                      );
                    },
                    child: buildPackageCard(Menupackage.samples[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPackageCard(Menupackage menupackage) {
    return Card(
      color: Color(0xFF4B9EA6), 
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(menupackage.imageUrl)),
            const SizedBox(height: 14.0),
            Text(
              menupackage.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
