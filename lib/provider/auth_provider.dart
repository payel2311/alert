import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:newproject/model/user_model.dart';
import 'package:newproject/screeens/otpScreen.dart';
import 'package:newproject/utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? _uid;
  UserModel? _userModel;
  UserModel get userModel=> _userModel!;

  String get uid => _uid!;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }
 Future setSignIn() async{
   final SharedPreferences s = await SharedPreferences.getInstance();
   s.setBool("is_signedin", true);
   _isSignedIn=true;
   notifyListeners();

 }
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {

      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (
              PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId: verificationId,),
            ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
      _userModel=userModel;
      await _firebaseFirestore.collection("users").doc(_uid).set(userModel.toMap()).then((value) {
        onSuccess();
        _isLoading=false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future <bool> checkExistingUser() async {
    DocumentSnapshot snapshot = await _firebaseFirestore.collection("users")
        .doc(_uid)
        .get();
    if (snapshot.exists) {
      print("users exists");
      return true;
    }
    else {
      print("new user");
      return false;
    }
  }

  void saveUserDataToFirebase({required BuildContext context,
    required UserModel userModel,
    required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      userModel.phoneNumber= _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid= _firebaseAuth.currentUser!.phoneNumber!;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }

  }
  Future saveUserDataToSP()async{
    SharedPreferences s= await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }
}