import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gate_x/pages/accountScreens/components/account_details_dashboards.dart';
import 'package:gate_x/pages/auth/signin_user.dart';
import 'package:gate_x/providers/user_providers.dart';

class AccountDetailsMyAccountWidget extends ConsumerStatefulWidget {
  const AccountDetailsMyAccountWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountDetailsMyAccountWidget> createState() =>
      _AccountDetailsMyAccountWidgetState();
}

class _AccountDetailsMyAccountWidgetState
    extends ConsumerState<AccountDetailsMyAccountWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await _auth.signOut();

      // Correctly read and update the provider
      ref.read(userProvider.notifier).removeUserInfo();

      Fluttertoast.showToast(
        msg: "Logout Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SigninUser()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      }
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(255, 107, 107, 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        const Color.fromRGBO(255, 107, 107, 1).withOpacity(0.8),
                    width: 2,
                  ),
                ),
              ),
              child: const Text(
                "My Account",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            DashboardItem(
              itemName: "Privacy",
              icon: const Icon(
                Icons.lock_person_rounded,
                size: 35,
                color: Color.fromRGBO(255, 107, 107, 1),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await _signOut();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  "Logout Account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 107, 107, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
