// User model for guest users (not logged in)
// ignore_for_file: file_names

class GuestUserModel {
  final String uid;

  GuestUserModel({required this.uid});

  factory GuestUserModel.fromMap(Map<String, dynamic> data) {
    return GuestUserModel(
      uid: data['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
    };
  }
}
