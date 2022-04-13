import 'dart:io';
import 'package:bookingapp/bloCs/SettingsController/states.dart';
import 'package:bookingapp/model/LoginedUser.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/Dialogs.dart';
import '../../constant/constant.dart';


class SettingsController extends Cubit<SettingsStates>{

  SettingsController(this.context) : super(InitialState());

  var context;

  static SettingsController get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();


  bool prefsChecker=false;
  String imagePass="";

  File image =  File("");

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  //final FirebaseAuth auth = FirebaseAuth.instance;

  String? errorMessage;

  // bool darkMode=appDarkMode;
  // String modeName =appModeName;


  Future<void> checkPrefs() async{
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // if(!prefsChecker){
    //   if(pref.containsKey("UserImage")){
    //     imagePass=pref.getString('UserImage')!;
    //     prefsChecker=true;
    //     emit(PrefsCheckingState());
    //   }else{
    //     prefsChecker=true;
    //   }
    // }

    if(LoginedUser.photoUrl.isNotEmpty){
      prefsChecker=true;
      imagePass=LoginedUser.photoUrl;
      emit(PrefsCheckingState());
    }else{
      prefsChecker=false;
    }

  }


  Future<bool> changePassword() async {

    //User? user =  auth.currentUser;

    try {

      // UserCredential credential = await auth.signInWithEmailAndPassword(
      //   email: LoginedUser.email, password: LoginedUser.password,
      // );

      // await credential.user?.updatePassword(newPassword.value.text);


      await LoginedUser.user?.updatePassword(newPassword.value.text);


      return true;

    } on Exception catch(error){

      debugPrint(error.toString());

      errorMessage=error.toString().substring(error.toString().indexOf(" "));

      return false;

    }

  }

  Future<void> loading() async {
    if (newPassword.value.text != confirmPassword.value.text) {
      MyDialog.showMyDialog(context,
          "Make Sure that Password and Confirm Password Identical", "ok",
          icon: Icons.warning_rounded, titleColor: Colors.yellow);
    } else {
      MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

      bool changePassTest = await changePassword();

      if (changePassTest) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context); //popup dialog
          MyDialog.showMyDialog(context, "Password Change Successfully", "ok", icon: Icons.check_circle_outline, titleColor: Colors.green);

        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context); //popup dialog
          MyDialog.showMyDialog(context, errorMessage!, "ok",
              icon: Icons.cancel_outlined, titleColor: Colors.red);
        });
      }
    }
  }

  Future<void> imageDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // if equal false => user must tap button!
      builder: (BuildContext context) {
        return  Directionality(
          ///textDirection: TextDirection.rtl,
          textDirection: TextDirection.ltr,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )
            ),
            title:   const Center(child: Text("Choose Photo Place",style: TextStyle(fontFamily: "Lemonada",color: appThemColor),)),
            content:  SingleChildScrollView(
              child:  Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed:() =>  gallery(),
                          child: const Text("Gallery ",style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                      ),
                      const Padding(padding: EdgeInsets.only(left: 100)),
                      const Icon(Icons.image),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () => camera(),
                          child: const Text("Camera",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                      ),
                      const Padding(padding: EdgeInsets.only(left: 100)),
                      const Icon(Icons.camera_alt)
                    ],
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("cancel"),
                style: fixedButtonStyle(12),
              )
            ],
          ),
        );
      },
    );
  }

  gallery() async{
    //PickedFile? pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    image=File(pickedImage!.path);
    imagePass=pickedImage.path;
    //emit(GetCameraImage());
    if(image.path!=""){
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('UserImage', image.path);
      await LoginedUser.user?.updatePhotoURL(image.path);
      LoginedUser.photoUrl=image.path;
    }
    Navigator.of(context).pop();

    emit(GetGalleryImage());
  }
  camera() async{
    //PickedFile? pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    image=File(pickedImage!.path);
    imagePass=pickedImage.path;
    //emit(GetCameraImage());
    if(image.path!=""){
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('UserImage', image.path);
      await LoginedUser.user?.updatePhotoURL(image.path);
      LoginedUser.photoUrl=image.path;
    }
    debugPrint(image.path);
    Navigator.of(context).pop();

    emit(GetGalleryImage());
  }

  void changeMode(value){
    // darkMode=value;
    // darkThem(darkMode);
    // modeName =appModeName;
    // emit(ChangeModeState());
  }


  Widget loadImage(){
    return Image.asset("assets/images/DefaultUser.png",);
  }


}
