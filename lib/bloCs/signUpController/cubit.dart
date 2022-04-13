import 'package:bookingapp/bloCs/signUpController/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/Dialogs.dart';
import '../../constant/constant.dart';

class SingUpController extends Cubit<SignUpStates> {
  SingUpController(this.context) : super(InitialState());

  var context;

  static SingUpController get(context) => BlocProvider.of(context);

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final referenceDatabase = FirebaseDatabase.instance;

  bool passMode = true;
  bool confirmPassMode = true;

  String? errorMessage;

  Future<bool> signUp(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password,
      );

      await credential.user?.updateDisplayName(firstName.value.text+lastName.value.text);


      final refUser = referenceDatabase.ref();


      ///refUser.child("Users").push().set(email);
      //refUser.child("Users").push().child(email).set("");
      //refUser.child("Users").push().child(email).child("TravelsId").set("InitialTest");
      //await refUser.child("Users").child(email).child("TravelsId").child("InitialTest").push().set(email);
      refUser.child("Users").child(credential.user!.uid).child("TravelsId").set("InitialTest");

      return true;
    } on Exception catch (error) {
      debugPrint(error.toString());

      errorMessage=error.toString().substring(error.toString().indexOf(" "));

      return false;
    }
  }

  Future<void> loading() async {
    if (password.value.text != confirmPassword.value.text) {
      MyDialog.showMyDialog(context,
          "Make Sure that Password and Confirm Password Identical", "ok",
          icon: Icons.warning_rounded, titleColor: Colors.yellow);
    } else {
      MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

      bool signUpTest = await signUp(userName.value.text, password.value.text);

      if (signUpTest) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context); //popup dialog
          MyDialog.showMyDialog(context, "Successful SignUp", "ok", icon: Icons.check_circle_outline, titleColor: Colors.green);

          ///Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.start, (route) => false);
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context); //popup dialog
          MyDialog.showMyDialog(context, errorMessage! /*"SignUp Failed"*/, "ok",
              icon: Icons.cancel_outlined, titleColor: Colors.red);
        });
      }
    }
  }

  Widget seePass(value, int typeIndex) {
    if (!value) {
      return IconButton(
        icon: const Icon(Icons.visibility, color: appThemColor),
        onPressed: () {
          if (typeIndex == 1) {
            passMode = !value;
          } else if (typeIndex == 2) {
            confirmPassMode = !value;
          }
          emit(SeenHidePassState());
        },
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.visibility_off, color: appThemColor),
        onPressed: () {
          if (typeIndex == 1) {
            passMode = !value;
          } else if (typeIndex == 2) {
            confirmPassMode = !value;
          }
          emit(SeenHidePassState());
        },
      );
    }
  }
}
