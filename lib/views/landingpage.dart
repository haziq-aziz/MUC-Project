import 'package:flutter/material.dart';
import 'package:restaurantbooking/Authentication/signup.dart';
import 'package:restaurantbooking/Authentication/login.dart';
import 'package:restaurantbooking/views/home_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/background.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
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
                      top: 20, bottom: 30),
                  child: Image.asset(
                    'assets/images/image_landing.png',
                    height: 250,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all<Size>(
                        const Size(250, 50)),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromRGBO(43, 159, 148, 1.0),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0),
                        side: const BorderSide(
                            color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all<Size>(
                        const Size(250, 50)),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(125, 172, 226, 220),
                    ),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0),
                        side: const BorderSide(
                            color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Packages',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(43, 159, 148, 1.0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                          width: 5),
                      Icon(
                        Icons
                            .food_bank_rounded,
                        color: Color.fromRGBO(
                            43, 159, 148, 1.0),
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
