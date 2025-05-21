import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user status on login
      final uid = userCredential.user!.uid;
      await _firestore.collection('users').doc(uid).update({
        'isOnline': true,
        'lastActive': FieldValue.serverTimestamp(),
      });

      //await _savePushToken(uid);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Register user
  Future<UserCredential> createUserWithEmailAndPassword(
      String email,
      String password,
      String userName,
      ) async {
    try {
      // Check if username is taken
      final userNameQuery = await _firestore
          .collection('users')
          .where('name', isEqualTo: userName)
          .get();

      if (userNameQuery.docs.isNotEmpty) {
        throw Exception('user-name taken');
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': userName,
        'profilePic': '', // can be updated later
        'isOnline': true,
        'lastActive': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'pushToken': '',
      });

      //await _savePushToken(uid);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).update({
        'isOnline': false,
        'lastActive': FieldValue.serverTimestamp(),
      });
    }
    await _auth.signOut();
  }

  // Save push notification token
  // Future<void> _savePushToken(String uid) async {
  //   final token = await FirebaseMessaging.instance.getToken();
  //   if (token != null) {
  //     await _firestore.collection('users').doc(uid).update({
  //       'pushToken': token,
  //     });
  //   }
  // }
}
