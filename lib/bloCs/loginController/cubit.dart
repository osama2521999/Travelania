import 'package:bookingapp/bloCs/loginController/states.dart';
import 'package:bookingapp/constant/Dialogs.dart';
import 'package:bookingapp/model/LoginedUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/constant.dart';
import '../../router/RoutePaths.dart';


class LoginController extends Cubit<LoginStates>{

  LoginController(this.context) : super(InitialState());

  var context;

  static LoginController get(context) => BlocProvider.of(context);

  TextEditingController email = TextEditingController() ;
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool passMode = true;

  bool savedPass = false;


  Future<bool> login() async{


    try {

      UserCredential loginTest = await auth.signInWithEmailAndPassword(
          email: email.value.text, password: password.value.text
      );

      LoginedUser.uId=loginTest.user!.uid;
      LoginedUser.name=loginTest.user!.displayName!;
      LoginedUser.email=email.value.text;
      LoginedUser.password=password.value.text;

      LoginedUser.photoUrl=loginTest.user!.photoURL ?? '' ;
      LoginedUser.user = auth.currentUser;

      return true;


    } on Exception catch (error) {

      debugPrint(error.toString());

      return false;

    }

  }


  Future<void> loading() async{

    MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

    bool loginTest = await login();

    if(loginTest){

      if(savedPass){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('UserName', email.value.text);
        prefs.setString('Password', password.value.text);
      }

      Future.delayed( const Duration(seconds: 3), () {
        Navigator.pop(context); //popup dialog
        Navigator.of(context).pushNamed(RoutePaths.mainScreen,arguments: {"userName":email.value.text});
      });

    }else{

      Future.delayed( const Duration(seconds: 3), () {
        Navigator.pop(context); //popup dialog
        //MyDialog.showMyDialog(context,"Failed Login","Sure from Email or Password","ok");
        MyDialog.showMyDialog(context,"Sure from Email or Password","ok",icon: Icons.cancel_outlined,titleColor: Colors.red);
      });

    }


  }


  Widget seePass(){
    if(!passMode){
      return IconButton(
        icon: const Icon(Icons.visibility,color: appThemColor),
        onPressed: () {
          passMode=!passMode;
          emit(SeenHidePassState());
        },
      );
    }else{
      return IconButton(
        icon: const Icon(Icons.visibility_off,color: appThemColor),
        onPressed: () {
          passMode=!passMode;
          emit(SeenHidePassState());
        },
      );
    }
  }

  Future<void> getSavedLogin() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("UserName")&&prefs.containsKey("Password")){
      email.text=prefs.getString('UserName')!;
      password.text=prefs.getString('Password')!;

      savedPass=true;
      emit(GetSavedPassState());
    }
  }

  void changeCheckbox(value) {
    savedPass=value!;
    emit(ChangeSavePassState());
  }


}