// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';

class LoginedUser {

  static User? user  ;

  static String uId = '';
  static String name = '';
  static String email = '';
  static String password = '';
  static String photoUrl = '';

  static void singOut() {
    uId = '';
    name = '';
    email = '';
    password = '';
    photoUrl = '';
  }
}
