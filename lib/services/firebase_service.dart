import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:posty/models/user_model.dart';

class FirebaseService {
  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;

    signIn.initialize(
      serverClientId:
          '650182089324-t06lkadtslal53i3o8j834nd4hisr76f.apps.googleusercontent.com',
    );

    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toFirestore(),
        );
  }

  static Future<void> addUserToFirestore(UserModel user) async {
    await getUserCollection().doc(user.uid).set(user);
  }

  static Future<UserModel?> getUserFromFirestore(String uid) async {
    final docSnapShot = await getUserCollection().doc(uid).get();
    return docSnapShot.data();
  }
}
