import 'package:flutter/material.dart';
import 'package:restaurantbooking/Authentication/signup.dart';
import 'package:restaurantbooking/JsonModels/users.dart';
import 'package:restaurantbooking/services/database_service.dart';
import 'package:restaurantbooking/BookForm/bookingform.dart';
import 'package:restaurantbooking/views/home_screen.dart';
import 'package:restaurantbooking/views/home_screen_success.dart';
import 'package:restaurantbooking/Authentication/globals.dart' as globals;
import 'package:restaurantbooking/views/profile.dart'; // Import the globals file

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  int _currentTab = 0;

  // Show password toggle
  bool isVisible = false;

  // Bool variable to show error message
  bool isLoginTrue = false;

  final db = DatabaseService();

  // Call function in login button
  login() async {
    var response =
        await db.login(Users(username: username.text, password: password.text));

    if (response == true) {
      // Retrieve userId
      int userId = await db.getUserIdByUsername(username.text);

      // if login is correct, update isLoggedIn and go to landing page
      if (!mounted) return;
      setState(() {
        globals.isLoggedIn = true;
        globals.userId = userId; // Store userId in globals
      });

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Profile(userId: userId)));
    } else {
      // If login is not correct, show error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  // Global key for form
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Color.fromRGBO(43, 159, 148, 1.0),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/login_image.png",
                            width: 300,
                          ),
                          const SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromRGBO(43, 159, 148, 1.0)
                                      .withOpacity(.2)),
                              child: TextFormField(
                                controller: username,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Username is required";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Username"),
                              )),
                          // Password Field
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(43, 159, 148, 1.0)
                                    .withOpacity(.2)),
                            child: TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                              obscureText: !isVisible,
                              decoration: InputDecoration(
                                icon: const Icon(Icons.lock),
                                border: InputBorder.none,
                                hintText: "Password",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Login Button
                          Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      const Color.fromRGBO(43, 159, 148, 1.0)),
                              child: TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp()));
                                  },
                                  child: const Text("SIGN UP",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              43, 159, 148, 1.0)))),
                            ],
                          ),
                          // Incorrect password notification
                          isLoginTrue
                              ? const Text("Username or password is incorrect",
                                  style: TextStyle(color: Colors.red))
                              : const SizedBox(),
                        ],
                      ))))),
    );
  }
}
