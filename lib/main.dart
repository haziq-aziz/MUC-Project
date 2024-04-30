import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover Your Best Food',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'), // Replace with your background image asset
            fit: BoxFit.cover, // Adjust the BoxFit according to your needs
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selera Kampung',
                style: TextStyle(
                    fontSize: 42,
                    color: Color.fromRGBO(43, 159, 148, 1.0),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Text(
                'Reserve your table now for an extraordinary dining experience!',
                style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(
                    top: 20, bottom: 20), // Add margin top and bottom here
                child: Image.asset(
                  'assets/images/image_landing.png', // Replace with your illustration image
                  height: 300,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your action when the button is pressed
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(43, 159, 148, 1.0)
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)
                    ,)
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}