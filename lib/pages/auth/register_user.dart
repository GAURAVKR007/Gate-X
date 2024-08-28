import 'package:gate_x/components/custom_appbar.dart';
import 'package:gate_x/pages/auth/post_register.dart';
import 'package:gate_x/providers/user_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterUser extends ConsumerStatefulWidget {
  const RegisterUser({super.key});

  @override
  ConsumerState<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends ConsumerState<RegisterUser> {
  bool isCheck = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60), // Set the height of the app bar
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Image(image: AssetImage("assets/images/reg-icon.png")),
                  const SizedBox(height: 20),
                  const Text(
                    "Create an Account",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 70),
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username cannot be empty";
                      } else if (value.length > 14) {
                        return "Username must be at Max 21 characters";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: const Image(
                          image: AssetImage("assets/icons/reg-user-icon.png")),
                      labelText: "Username",
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      } else if (!emailRegex.hasMatch(value)) {
                        return "Enter valid email Syntax";
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
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      } else if (value.length < 7) {
                        return "Password must be at least 7 characters";
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
                  Row(
                    children: [
                      Checkbox(
                        value: isCheck,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheck = value!;
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        checkColor: Colors.white,
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color.fromRGBO(84, 62, 233, 1);
                          }
                          return Colors.white;
                        }),
                      ),
                      const Expanded(
                        child: Text(
                          "I hereby agree to the terms of services and privacy policy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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
                          if (isCheck) {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                              ref.read(userProvider.notifier).registerUser(
                                  _usernameController.text,
                                  _emailController.text);

                              Fluttertoast.showToast(
                                msg: "User Registered Successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostRegister(
                                        username: _usernameController.text,
                                      )));
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
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "Please agree to the terms of services and privacy policy",
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
                        child: Text("Create Account",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Already have an account? Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
