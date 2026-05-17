class UserModel {
  static const String collectionName = 'user';
  final String uid;
  final String? name;
  final String email;
  

  UserModel({this.name, required this.email, required this.uid});

  UserModel.fromJson(Map<String, Object?> json)
    : this(
        name: json['name'] as String?,
        email: json['email']! as String,
        uid: json['uid']! as String,
      );

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'uid': uid
    };
  }
}