import 'package:action_manager/models/app_lat_long.dart';
import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String name;
  final String email;
  final String? phone;
  final String password;
  final AppLatLong? geo;

  const UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.geo,
    this.phone,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          email: json['email']! as String,
          phone: json['phone'] != null ? json['phone'] as String : null,
          password: json['password']! as String,
          geo: json['geo'] != null ? AppLatLong(lat: Map<String, double>.from(json['geo'] as Map<dynamic, dynamic>)['lat']!, long: Map<String, double>.from(json['geo'] as Map<dynamic, dynamic>)['long']!) : null,
        );


  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'geo': geo,
    };
  }
}
