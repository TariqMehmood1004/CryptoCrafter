// c:/Users/Tariq Mehmood/Desktop/CryptoCrafter/lib/Models/AdminModel.dart
// User model for admin users

// ignore_for_file: file_names

class AdminModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  AdminModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  factory AdminModel.fromMap(Map<String, dynamic> data) {
    return AdminModel(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'],
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }
}
