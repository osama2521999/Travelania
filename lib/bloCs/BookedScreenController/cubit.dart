import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/Dialogs.dart';
import '../../model/LoginedUser.dart';
import '../../model/Travel.dart';
import '../BookedScreenController/states.dart';


class BookedScreenController extends Cubit<BookedScreenStates>{

  BookedScreenController(this.context) : super(InitialState());

  var context;

  static BookedScreenController get(context) => BlocProvider.of(context);

  final referenceDatabase = FirebaseDatabase.instance;

  List<int> userBookedTravels = [];

  List<Travel> travels =[];

  bool getData = false;
  bool checkData = false;

  String failedMessage = '';


  Future<void> getUserBookedTravelsId() async {

    var userValue = await referenceDatabase.ref().child("Users").child(LoginedUser.uId).once();

    for(var element in userValue.snapshot.child("TravelsId").children){

      userBookedTravels.add(int.parse(element.value.toString()));

    }

  }

  Future<void> getUserTravels() async {

    await getUserBookedTravelsId();

    var value = await referenceDatabase.ref().child("travels").once();

    for (var element in value.snapshot.children) {
      if(userBookedTravels.contains(int.parse(element.key!))){

        travels.add(Travel.fromJson(Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>)));
        debugPrint('Travels : ${travels.length}');

      }
    }

    if(travels.isNotEmpty){
      getData=true;
    }else{
      getData=false;
    }

    checkData=true;
    emit(GetUserTravelsState());

  }


  Future<void> removeFromUser(int travelId) async {

    var userValue = await referenceDatabase.ref().child("Users").child(LoginedUser.uId).once();
    for(var element in userValue.snapshot.child("TravelsId").children){
      if(element.value==travelId){
        await element.ref.remove();
      }
    }

    travels.removeWhere((element) => element.id==travelId);

    if(travels.isEmpty){
      getData=false;
    }

  }


  Future<bool> removeTravel(int travelId) async {


    try {


      await removeFromUser(travelId);

      var travelsValue = await referenceDatabase.ref().child("travels").child('$travelId').once();

      for(var element in travelsValue.snapshot.child("seats").children){
        if(element.value==LoginedUser.email){
          await element.ref.remove();
        }
      }

      emit(RemoveDoneState());

      return true;

    } on Exception catch (error) {
      debugPrint(error.toString());

      failedMessage=error.toString().substring(error.toString().indexOf(" "));

      return false;
    }

  }


  Future<void> loading(int travelId) async{

    MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

    bool checkTravel = await removeTravel(travelId);

    if(checkTravel){

      Future.delayed( const Duration(seconds: 3), () {
        Navigator.pop(context); //popup dialog
        //Navigator.of(context).pushNamed(RoutePaths.mainScreen,arguments: {"userName":email.value.text});
        MyDialog.showMyDialog(context,"Remove Done Successfully","ok",icon: Icons.check_circle_outline,titleColor: Colors.green);
      });

    }else{

      Future.delayed( const Duration(seconds: 3), () {
        Navigator.pop(context); //popup dialog
        MyDialog.showMyDialog(context,failedMessage,"ok",icon: Icons.cancel_outlined,titleColor: Colors.red);
      });

    }


  }



}