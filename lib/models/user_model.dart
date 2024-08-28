// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String username;
  final String emailId;

  const UserModel({
    required this.username,
    required this.emailId,
  });


  UserModel copyWith({
    String? username,
    String? emailId,
  }) {
    return UserModel(
      username: username ?? this.username,
      emailId: emailId ?? this.emailId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'emailId': emailId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      emailId: map['emailId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(username: $username, emailId: $emailId)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.emailId == emailId;
  }

  @override
  int get hashCode => username.hashCode ^ emailId.hashCode;
}
