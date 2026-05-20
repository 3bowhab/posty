class UserModel {
  static const String collectionName = 'user';

  final String uid;
  final String? name;
  final String email;

  const UserModel({required this.uid, this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String?,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'name': name, 'email': email};
  }
}
