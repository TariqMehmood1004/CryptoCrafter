// UserModel model for logged-in UserModels
// ignore_for_file: file_names

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
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
