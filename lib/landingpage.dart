import 'package:flutter/material.dart';
import 'reservationpage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/background.png'), // RBackground Image
            fit: BoxFit.cover, // Make the background image fit to the screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selera Kampung',
                style: TextStyle(
                    fontSize: 42,
                    color: Color.fromRGBO(43, 159, 148, 1.0),
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Reserve your table now for an extraordinary dining experience!',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(
                    top: 20, bottom: 30), // Add margin top and bottom here
                child: Image.asset(
                  'assets/images/image_landing.png', // Replace with your illustration image
                  height: 300,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReservationPage())); // Add your action when the button is pressed
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(43, 159, 148, 1.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  )),
                ),
                child: const Text('Get Started',
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
