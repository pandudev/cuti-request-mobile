import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:cuti_flutter_mobile/services/penggunaService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PenggunaState extends ChangeNotifier {
  Pengguna _pengguna = Pengguna();

  Pengguna get getPengguna => _pengguna;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      FirebaseUser _firebaseUser = await _auth.currentUser();

      if (_firebaseUser != null) {
        _pengguna = await PenggunaService().getPengguna(_firebaseUser.uid);

        if (_pengguna != null) {
          retVal = "success";
        }
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signIn(String email, String password) async {
    String retVal = "error";

    try {
      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _pengguna = await PenggunaService().getPengguna(_authResult.user.uid);

      if (_pengguna != null) {
        retVal = "success";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _pengguna = Pengguna();
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    String retVal = "error";

    try {
      FirebaseUser _firebaseUser = await _auth.currentUser();
      AuthCredential _credential = EmailAuthProvider.getCredential(
          email: _firebaseUser.email, password: oldPassword);
      AuthResult _authResult =
          await _firebaseUser.reauthenticateWithCredential(_credential);

      if (_authResult != null) {
        await _firebaseUser.updatePassword(newPassword);
        retVal = "success";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
