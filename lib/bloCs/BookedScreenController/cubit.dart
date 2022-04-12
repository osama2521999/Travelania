import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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



}