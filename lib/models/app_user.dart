import 'package:mind_labify/utils/enums.dart';

class AppUser {
  String? uid;
  String name;
  String email;
  String phoneNumber;
  UserType userType;
  String? age;
  String? gender;
  String? mood;
  List<String?>? stressorsName;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    this.age,
    this.gender,
    this.mood,
    this.stressorsName,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    UserType? userType,
    String? age,
    String? gender,
    String? mood,
    List<String?>? stressorsName,
  }) {
    return AppUser(
      uid: uid ?? uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      mood: mood ?? this.mood,
      stressorsName: stressorsName ?? this.stressorsName,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userType: map['userType'] != null
          ? map['userType'] == UserType.user.toString()
              ? UserType.user
              : UserType.admin
          : UserType.admin,
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      mood: map['mood'] ?? '',
      stressorsName: map['stressorsName'] != null
          ? List<String>.from(
              map['stressorsName'],
            )
          : [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType.toString(),
      'age': age,
      'gender': gender,
      'mood': mood,
      'stressorsName': stressorsName,
    };
  }
}
