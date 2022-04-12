import 'dart:developer';

import 'package:bookingapp/bloCs/bookingController/states.dart';
import 'package:bookingapp/model/LoginedUser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/Dialogs.dart';

class BookingController extends Cubit<BookingStates>{
  BookingController(this.context) : super(InitialState());

  BuildContext context;

  static BookingController get(context)=> BlocProvider.of(context);

  final referenceDatabase = FirebaseDatabase.instance;

  List<int> userBookedTravelsId = [];

  String failedBookingMessage = '';

  
  Future<void> getUserBookedTravelsId() async {

    var userValue = await referenceDatabase.ref().child("Users").child(LoginedUser.uId).once();

    for(var element in userValue.snapshot.child("TravelsId").children){

      userBookedTravelsId.add(int.parse(element.value.toString()));

    }
    
  }


  Future<bool> bookTravel(int travelId) async {

    await getUserBookedTravelsId();

    if(!userBookedTravelsId.contains(travelId)){

      var travelsValue = await referenceDatabase.ref().child("travels").once();


      int lengthOfSeats = travelsValue.snapshot.child("$travelId").child("seats").children.length;

      int travelSeatNum = int.parse(travelsValue.snapshot.child("$travelId").child("seatsNum").value.toString());
      // int travelSeatNum = 5;

      if(lengthOfSeats<travelSeatNum){

        await referenceDatabase.ref().child("travels").child("$travelId").child("seats").push().set(LoginedUser.email);
        await referenceDatabase.ref().child("Users").child(LoginedUser.uId).child("TravelsId").push().set(travelId);

        return true;

      }else{

        failedBookingMessage="Unfortunately all seats on this travel booked.";

        return false;
      }

    }else{

      failedBookingMessage="You have already Booked this travel.";

      return false;

    }

  }


  Future<void> loading(int travelId) async{

    MyDialog.loadingDialog(context, size: MediaQuery.of(context).size);

    bool checkTravel = await bookTravel(travelId);

    if(checkTravel){

      Future.delayed( const Duration(seconds: 3), () {
        Navigator.pop(context); //popup dialog
        //Navigator.of(context).pushNamed(RoutePaths.mainScreen,arguments: {"userName":email.value.text});
        MyDialog.showMyDialog(context,"Booking Travel Done Successfully","ok",icon: Icons.check_circle_outline,titleColor: Colors.green);
      });

    }else{

      Future.delayed( const Duration(seconds: 3), () {
        Navigator.pop(context); //popup dialog
        MyDialog.showMyDialog(context,failedBookingMessage,"ok",icon: Icons.cancel_outlined,titleColor: Colors.red);
      });

    }


  }


}