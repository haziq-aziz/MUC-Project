import 'package:flutter/material.dart';
import 'menupackage.dart';
import 'package_detail.dart';

class PageListFood extends StatelessWidget {
  const PageListFood({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Restaurant Package Menu Booking',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0xFF4B9EA6),
          secondary: Colors.grey,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF4B9EA6), foregroundColor: Colors.white),
      ),
      home: const MyHomePage(title: 'Restaurant Package Menu Booking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
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
                          menupackage: Menupackage.samples[index]);
                    },
                  ),
                );
              },
              child: buildPackageCard(Menupackage.samples[index]),
            );
          },
        ),
      ),
    );
  }

  Widget buildPackageCard(Menupackage menupackage) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(menupackage.imageUrl)),
            const SizedBox(
              height: 14.0,
            ),
            Text(
              menupackage.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              ),
            )
          ],
        ),
      ),
    );
  }
}
