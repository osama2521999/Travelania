// ignore_for_file: file_names
import 'package:bookingapp/bloCs/BookedScreenController/cubit.dart';
import 'package:bookingapp/bloCs/BookedScreenController/states.dart';
import 'package:bookingapp/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BookedScreen extends StatelessWidget {
  const BookedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;

    return BlocProvider(
      create: (context) => BookedScreenController(context)..getUserTravels(),
      child: BlocConsumer<BookedScreenController,BookedScreenStates>(
        listener: (context, state) {},
        builder:  (context, state) {
          var controller = BookedScreenController.get(context);

          if(controller.checkData){

            return controller.getData ? Expanded(
              child: ListView.builder(
                itemCount: controller.travels.length,
                itemBuilder: (context, index) {

                  return SizedBox(
                    width: size.width,
                    height: (size.width)*.4,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                          ///textDirection: TextDirection.rtl,
                          children: [

                            Container(
                              alignment: Alignment.centerRight,
                              child: Image.network(
                                controller.travels[index].imagePass,
                                fit: BoxFit.cover,
                                width: (size.width)*.5,
                                height: (size.width)*.4,
                              ),
                            ),

                            SingleChildScrollView(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.ltr,

                                children: [
                                  Row(
                                    ///textDirection: TextDirection.rtl,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Country: ",style: TextStyle(color: appThemColor,fontSize: 16,fontFamily: "Lemonada")),
                                      Text(controller.travels[index].country,textDirection: TextDirection.ltr,style: const TextStyle(fontSize: 14,fontFamily: "cairo")),
                                    ],
                                  ),

                                  Row(
                                    ///textDirection: TextDirection.rtl,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Travel: ",style: TextStyle(color: appThemColor,fontSize: 16,fontFamily: "Lemonada")),
                                      Text(controller.travels[index].travelName,textDirection: TextDirection.ltr,style: const TextStyle(fontSize: 14,fontFamily: "cairo")),
                                    ],
                                  ),

                                  Row(
                                    ///textDirection: TextDirection.rtl,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Time: ",style: TextStyle(color: appThemColor,fontSize: 16,fontFamily: "Lemonada")),
                                      Text(controller.travels[index].time,textDirection: TextDirection.ltr,style: const TextStyle(fontSize: 14,fontFamily: "cairo")),
                                    ],
                                  ),

                                  Container(
                                    child: DecoratedBox(
                                      decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          gradient: const LinearGradient(
                                            colors: [
                                              ///Colors.yellowAccent,
                                              Colors.red,
                                              Color.fromRGBO(143, 148, 251, .6),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                      ),
                                      child: ElevatedButton(
                                        child: Text(
                                          "cancel",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:  fontSize ,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Amiri'
                                          ),
                                        ),
                                        onPressed:() {
                                          ///Call method of cancel Travel

                                          controller.loading(controller.travels[index].id);

                                        },
                                        style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                                      ),
                                    ),
                                    padding:const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    width: buttonsHeightWidth(context, 0, .3)[0],
                                    height: buttonsHeightWidth(context, .07, 0)[1] ,
                                  ),

                                ],
                              ),
                            ),

                          ]
                      ),
                    ),
                  );

                },
              ),
            ) :

            Expanded(
                child: Center(
                  child: Text(
                    "You haven't booked any Travel Yet",
                    style: fixedHeadTextStyle(family: "Lemonada",font: 18),
                  ),
                )
            );

          }else{

            return spinner(size);

          }

        },
      ),
    );
  }

  Widget spinner(Size size){
    return SizedBox(
      width: size.width,
      height: (size.height)/1.5,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}
