import 'package:gate_x/components/custom_appbar.dart';
import 'package:gate_x/pages/auth/register_user.dart';
import 'package:gate_x/pages/homeScreens/home_screen.dart';
import 'package:gate_x/providers/user_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SigninUser extends ConsumerStatefulWidget {
  const SigninUser({super.key});

  @override
  ConsumerState<SigninUser> createState() => _SigninUserState();
}

class _SigninUserState extends ConsumerState<SigninUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppbar(),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth * 0.999,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // const SizedBox(height: 20),
                  const Image(
                      image: AssetImage("assets/images/signin-icon.png")),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 70),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: const Image(
                          image:
                              AssetImage("assets/icons/email-user-icon.png")),
                      labelText: "Email id",
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length <= 6) {
                        return 'Password must be at least 7 characters';
                      }

                      return null;
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: const Image(
                          image: AssetImage("assets/icons/pass-user-icon.png")),
                      labelText: "Password",
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // handle tap event
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(228, 241, 248, 1))),
                        ),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color.fromRGBO(228, 241, 248, 1)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: screenWidth * 0.99,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(84, 62, 233, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          debugPrint("Usermane : ${_emailController.text}");
                          debugPrint("Password : ${_passwordController.text}");

                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);

                            ref
                                .read(userProvider.notifier)
                                .retreiveUserInfo(_emailController.text);

                            Fluttertoast.showToast(
                              msg: "Login Successful",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Sign In",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "(or)",
                    style: TextStyle(
                        color: Color.fromRGBO(228, 241, 248, 1), fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    width: screenWidth * 0.99,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  "assets/icons/google-img-signin-icon.png"),
                            ),
                            SizedBox(width: 20),
                            Text("Sign in with Google",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterUser()));
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
