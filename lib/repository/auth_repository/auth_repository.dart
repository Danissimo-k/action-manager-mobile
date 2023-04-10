
import 'package:action_manager/models/user.dart';
import 'package:action_manager/repository/auth_repository/exceptions/signup_email_password_failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/currencies.dart';
import '../../models/app_lat_long.dart';
import 'exceptions/signin_email_password_failures.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Rxn<User?> firebaseUser = Rxn<User>();

  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  Future<User> get getUser async => _auth.currentUser!;

  @override
  void onReady() {
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) {
    if (user?.uid != null) {
      firestoreUser.bindStream(_streamFirestoreUser());
    }
    user == null ? Get.offAllNamed('/login') : Get.offAllNamed('/');
  }

  _createUser(UserModel user, User firebaseUser) async {
    await _db.doc('/users/${firebaseUser.uid}').set({
      ...user.toJson(),
      'currencies': {CurrenciesConstants.rubTicker: 10000},
      'stocks': {}
    });
  }

  Stream<UserModel> _streamFirestoreUser() {
    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }

  Future<void> createUserWithEmailAndPassword(UserModel newUser) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: newUser.email, password: newUser.password)
          .then((value) => _createUser(newUser, value.user!))
          .then((value) => Get.snackbar(
                "Success",
                "Your account has been created",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green,
              ))
          .then((value) => {});
    } on FirebaseException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      print('FIRE BASE AUTH EXCEPTION - ${e.code}');
      Get.snackbar(
        "Ошибка",
        ex.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } catch (_) {
      const ex = SignupWithEmailAndPasswordFailure();
      print('FIRE BASE AUTH EXCEPTION');
      Get.snackbar(
        "Ошибка",
        ex.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  Future<void> loginUserWithEmailAndPassword(UserModel newUser) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: newUser.email, password: newUser.password)
          .then((val) {
        Get.snackbar(
          "Успех",
          "Вы успешно авторезовались",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      });
    } on FirebaseException catch (e) {
      final ex = SigninWithEmailAndPasswordFailure.code(e.code);
      print('FIRE BASE AUTH EXCEPTION - ${e.code}');
      Get.snackbar(
        "Ошибка",
        ex.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } catch (_) {
      const ex = SigninWithEmailAndPasswordFailure();
      print('FIRE BASE AUTH EXCEPTION');
      Get.snackbar(
        "Ошибка",
        ex.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  Future<void> logout() async => await _auth.signOut();

  Future<void> saveGeoPosition(AppLatLong appLatLong) async {
    await _db.doc('/users/${firebaseUser.value!.uid}').update({
      'geo': {'lat': appLatLong.lat, 'long': appLatLong.long}
    });
    Get.snackbar(
      "Успех",
      "Ваше местоположение успешно сохранено",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }

  Future<AppLatLong?> getGeoPosition() async {
    final point = Map<String, double>.from(await _db
        .collection('users')
        .doc(firebaseUser.value!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.data()!['geo'] ?? {};
    }).first);
    if (point.isEmpty) {
      return null;
    }
    return AppLatLong(lat: point['lat']!, long: point['long']!);
  }

}
