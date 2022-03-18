import 'package:car_e_commerce/data/module/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  var currentUser = const AppUser.empty();

  Stream<Object?> get appUser {
    return _auth.authStateChanges().map((userFireBase) {
      final tempUser =
          userFireBase == null ? AppUser.empty : userFireBase.toUser;
      return tempUser;
    });
  }

  // sign up method using firebase
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // sign in method using firebase
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  bool isSignedIn() {
    return _auth.currentUser != null;
  }
}

// copying the user from firebase to the AppUser module
extension on User {
  AppUser get toUser {
    return AppUser(
        id: uid, email: email, photoUrl: photoURL, name: displayName);
  }
}
