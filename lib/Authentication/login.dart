import 'package:flutter/material.dart';
import 'package:restaurantbooking/Authentication/signup.dart';
import 'package:restaurantbooking/JsonModels/session.dart';
import 'package:restaurantbooking/services/database_service.dart';
import 'package:restaurantbooking/views/home_screen.dart';
import 'package:restaurantbooking/views/home_screen_success.dart';
import 'package:restaurantbooking/views/edit_profile.dart';
import 'package:restaurantbooking/Admin/dashboard.dart';
import 'package:restaurantbooking/Authentication/globals.dart' as globals;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;

  final db = DatabaseService();

  login() async {
  var user = Users(username: username.text, password: password.text);
  bool isAdminUser = await db.isAdmin(user.username);

  if (isAdminUser) {
    bool adminPasswordCheck =
        await db.checkAdminPassword(user.username, user.password);

    if (adminPasswordCheck) {
      // Set admin session data upon successful login
      AdminSession.setAdminSession(user.username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard()),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  } else {
      bool userLogin = await db.login(user);

      if (userLogin) {
        int userId = await db.getUserIdByUsername(username.text);
        Users currentUser =
            await db.getUserById(userId); // Retrieve current user's information
        globals.userId = userId; // Store userId in globals
        globals.name = currentUser.name; // Store userName in globals
        globals.email = currentUser.email; // Store userEmail in globals
        setState(() {
          isLoginTrue = false; // Reset the login error flag
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenSuccess()),
        );
      } else {
        setState(() {
          isLoginTrue = true;
        });
      }
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color.fromRGBO(43, 159, 148, 1.0),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(43, 159, 148, 1.0)
                          .withOpacity(.2),
                    ),
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
                        hintText: "Username",
                      ),
                    ),
                  ),
                  // Password Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromRGBO(43, 159, 148, 1.0)
                          .withOpacity(.2),
                    ),
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
                              : Icons.visibility_off),
                        ),
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
                      color: const Color.fromRGBO(43, 159, 148, 1.0),
                    ),
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
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Color.fromRGBO(43, 159, 148, 1.0)),
                        ),
                      ),
                    ],
                  ),
                  // Incorrect password notification
                  isLoginTrue
                      ? const Text(
                          "Username or password is incorrect",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
