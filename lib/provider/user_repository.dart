import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/model/user_model.dart';
class UserRepository extends GetxController{
  static UserRepository get instance=> Get.find();
  final _db= FirebaseFirestore.instance;
  createUser(UserModel user) async{
    await _db.collection("Users").add(user.toMap()).whenComplete(() => Get.snackbar("Success", "Completed",colorText: Colors.green),
    ).catchError((error,stackTrace){
      Get.snackbar("Error","Something went wrong");
      print(error.toString()) ;
    }
     );
  }
}