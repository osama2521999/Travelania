// ignore_for_file: file_names
import 'package:bookingapp/bloCs/bookingController/cubit.dart';
import 'package:bookingapp/bloCs/bookingController/states.dart';
import 'package:bookingapp/model/Travel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/constant.dart';
import '../constant/sharedLayout.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({Key? key,this.argument}) : super(key: key);

  dynamic argument;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;
    Travel travel = argument['Travel'];

    return SharedLayout(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:Center(
        child: Column(
          children: [

            SizedBox(
              width: size.width,
              height: (size.height)/3,
              child:Image.network(
                travel.imagePass,
                fit: BoxFit.cover,
              ),
            ),

            BlocProvider(
              create: (context) => BookingController(context),
              child: BlocConsumer<BookingController,BookingStates>(
                listener: (context, state) {},
                builder: (context, state) {

                  var controller = BookingController.get(context);

                  return Expanded(
                    child: SizedBox(
                      width: (size.width)-5,
                      height: double.infinity,
                      child: Card(
                          borderOnForeground: true,
                          // shadowColor: Colors.black38,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(travel.travelName,style: fixedHeadTextStyle(color: Colors.blue,font: fontSize,weight: FontWeight.bold,family: "cairo")),
                                  alignment: Alignment.center,
                                ),

                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(travel.travelDescription,style: fixedHeadTextStyle(font: fontSize-1,color: Colors.black54,weight: FontWeight.bold,family: "cairo")),
                                  //alignment: Alignment.center,
                                ),

                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Text("Country : ",style: fixedHeadTextStyle(font: fontSize,weight: FontWeight.bold,family: "cairo")),
                                      Text(travel.country,style: fixedHeadTextStyle(color: Colors.blue,font: fontSize-1,weight: FontWeight.bold,family: "cairo")),
                                    ],
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),

                                // ListTile(
                                //   title: Text(travel.travelName,style: fixedHeadTextStyle(font: fontSize-1,weight: FontWeight.bold,family: "cairo")),
                                //   subtitle: Text(travel.travelDescription),
                                // ),

                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Text("Price : ",style: fixedHeadTextStyle(font: fontSize,weight: FontWeight.bold,family: "cairo")),
                                      Text(travel.price,style: fixedHeadTextStyle(color: Colors.blue,font: fontSize-1,weight: FontWeight.bold,family: "cairo")),
                                    ],
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),

                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Text("Time : ",style: fixedHeadTextStyle(font: fontSize,weight: FontWeight.bold,family: "cairo")),
                                      Text(travel.time,style: fixedHeadTextStyle(color: Colors.blue,font: fontSize-1,weight: FontWeight.bold,family: "cairo")),
                                    ],
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),

                                Container(

                                  child: DecoratedBox(
                                    decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: const LinearGradient(
                                          colors: [
                                            ///Colors.yellowAccent,
                                            Colors.blue,
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                    ),
                                    child: ElevatedButton(
                                      child: Text(
                                        "Book",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:  fontSize ,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Amiri'
                                        ),
                                      ),
                                      onPressed:() {
                                        ///here we should call method of book;

                                        controller.loading(travel.id);

                                      },
                                      style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                                    ),
                                  ),
                                  margin:const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  width: buttonsHeightWidth(context, 0, .4)[0],
                                  height: buttonsHeightWidth(context, .06, 0)[1] ,
                                ),

                              ],
                            ),
                          )
                      ),
                    ),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
