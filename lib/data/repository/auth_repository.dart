import 'package:car_e_commerce/data/local/pref_repository.dart';
import 'package:car_e_commerce/data/local/sql_database.dart';
import 'package:car_e_commerce/data/module/user/user.dart';
import 'package:car_e_commerce/data/repository/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sqflite/sqflite.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final GoogleSignIn _googleSignIn;
  var currUser = AppUser.empty;

  AuthRepository({
    firebase_auth.FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : auth = auth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Stream<AppUser> get user {
    return auth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AppUser.empty : firebaseUser.toUser;
      currUser = user;
      return user;
    });
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User? user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        currUser = AppUser(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoURL);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      User? user = (await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        currUser = AppUser(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoURL);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signInUsingGoogle() async {
    try {
      final firebase_auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User? user = (await auth.signInWithCredential(credential)).user;
      if (user != null) {
        currUser = AppUser(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoURL);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> signOut() async {
    PreferenceRepository.clearAllSharedPreference();
    deleteDatabase("data.db");
    DataBaseRepository.database = null;
    await firebase_auth.FirebaseAuth.instance.signOut();
    _googleSignIn.signOut();
  }

  bool isSignedIn() {
    return auth.currentUser != null;
  }
}

extension on firebase_auth.User {
  AppUser get toUser {
    return AppUser(
        id: uid, email: email, photoUrl: photoURL, name: displayName);
  }
}
