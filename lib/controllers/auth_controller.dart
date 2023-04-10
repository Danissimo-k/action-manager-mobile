import 'package:action_manager/repository/auth_repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class AuthController extends GetxController{
  static AuthController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();


  void registerUser(UserModel userModel) async {
    AuthRepository.instance.createUserWithEmailAndPassword(userModel);
  }

  void login(UserModel userModel) async {
    AuthRepository.instance.loginUserWithEmailAndPassword(userModel);
  }

  UserModel get user  => AuthRepository.instance.firestoreUser.value!;

}