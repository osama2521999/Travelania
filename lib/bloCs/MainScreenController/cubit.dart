import 'package:bookingapp/bloCs/MainScreenController/states.dart';
import 'package:bookingapp/model/Travel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenController extends Cubit<MainScreenStates>{

  MainScreenController(this.context) : super(InitialState());

  BuildContext context;

  static MainScreenController get(context) => BlocProvider.of(context);

  final referenceDatabase = FirebaseDatabase.instance;

  List<Travel> travels =[];

  bool getData = false;

  int currentIndex =0;


  void changeIndex(int index) {
    debugPrint(index.toString());
    currentIndex=index;
    emit(ChangeIndexState());
  }

  Future<void> getTravels() async {

    // final travelsRef=referenceDatabase.ref().child("travels");
    //
    // travelsRef.once().then((value) {
    //
    //   value.snapshot.children.forEach((element) {
    //
    //     travels.add(Travel.fromJson(Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>)));
    //
    //   });
    //
    //   print('Data : ${travels.length}');
    //
    //   emit(GetTravelsState());
    //
    // });

    var value = await referenceDatabase.ref().child("travels").once();

    for (var element in value.snapshot.children) {
      //debugger();
      travels.add(Travel.fromJson(Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>)));
    }

    getData=true;
    emit(GetTravelsState());

    debugPrint('Travels : ${travels.length}');

  }


}