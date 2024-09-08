// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gate_x/models/user_model.dart';

final userProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

class LocalUser {
  final String id;
  final UserModel user;

  LocalUser({required this.id, required this.user});

  LocalUser copyWith({
    String? id,
    UserModel? user,
  }) {
    return LocalUser(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }
}

class UserNotifier extends StateNotifier<LocalUser> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserNotifier()
      : super(
          LocalUser(
            id: 'ERR001',
            user: const UserModel(
              username: 'Error User',
              emailId: 'error@gmail.com',
            ),
          ),
        );

  Future<void> removeUserInfo() async {
    state = LocalUser(
      id: 'ERR001',
      user: const UserModel(
        username: 'Error User',
        emailId: 'error@gmail.com',
      ),
    );
  }

  Future<void> retreiveUserInfo(String email) async {
    QuerySnapshot response = await _firestore
        .collection("users")
        .where('emailId', isEqualTo: email)
        .get();

    if (response.docs.isEmpty) {
      print("User not found with email : $email");
      return;
    }

    state = LocalUser(
        id: response.docs[0].id,
        user:
            UserModel.fromMap(response.docs[0].data() as Map<String, dynamic>));
  }

  Future<void> registerUser(String username, String emailId) async {
    try {
      await _firestore.collection('users').doc(emailId).set(
            UserModel(
              username: username,
              emailId: emailId,
            ).toMap(),
          );
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(emailId).get();
      state = LocalUser(
        id: emailId,
        user: UserModel.fromMap(snapshot.data() as Map<String, dynamic>),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removingLocalUserData() {
    state = LocalUser(
        id: "error",
        user: const UserModel(emailId: "error@gmail.com", username: "Error"));
  }
}
