// ignore_for_file: file_names

import 'package:bookingapp/bloCs/MainScreenController/cubit.dart';
import 'package:bookingapp/bloCs/MainScreenController/states.dart';
import 'package:bookingapp/constant/constant.dart';
import 'package:bookingapp/constant/sharedLayout.dart';
import 'package:bookingapp/router/RoutePaths.dart';
import 'package:bookingapp/screen/bookedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/Dialogs.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;


    return WillPopScope(
      onWillPop: () async{
        final eDialog= await MyDialog.backToLoginDialog(context,"Do You Want to LogOut", RoutePaths.start);
        return eDialog??false;
      },
      child: BlocProvider(
      create: (context) => MainScreenController(context)..getTravels(),
      child: BlocConsumer<MainScreenController,MainScreenStates>(
          listener: (context, state) {},
          builder:  (context, state) {
            var controller = MainScreenController.get(context);
            return SharedLayout(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(child: Text("Main Screen",style: fixedHeadTextStyle(font: 24,family: 'cairo')),),
                flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient:  LinearGradient(
                          colors: [
                            Colors.blue,
                            Color.fromRGBO(143, 148, 251, .6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                    )
                ),
              ),
              body:Column(
                children: [
                  ListTile(
                    leading: Image.asset("assets/images/travel.png"),
                    title: Text("Travelania",style: fixedHeadTextStyle(font: fontSize-1,weight: FontWeight.bold,family: "cairo")),
                    subtitle: Text("Travel is easier with us.",style: fixedHeadTextStyle(font: fontSize-1,weight: FontWeight.bold,family: "cairo")),
                  ),

                  controller.currentIndex !=0 ? const BookedScreen() :
                  controller.getData==false ?spinner(size) : Expanded(

                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: controller.travels.length,
                        itemBuilder: (context, index){
                          return Card(
                            //semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  controller.travels[index].imagePass,
                                  fit: BoxFit.cover,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RoutePaths.bookingScreen,
                                        arguments: {'Travel':controller.travels[index]}
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    // height: 10,
                                    child: Card(
                                      color: Colors.white.withOpacity(.7),
                                      semanticContainer: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: ListTile(
                                        title: Text(controller.travels[index].travelName),
                                        subtitle: const Text("More Details"),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,

                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.save),
                    label: 'Booked Travel',
                  ),
                ],
                onTap: controller.changeIndex,
              ),
            );
          },
        )
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

/*class MainScreen extends SharedLayout {

  MainScreen({Key? key}) : super();




  void main(){

    MainScreen mainObject = MainScreen();

    mainObject.body = Center(child: Text("data"));

  }



}*/
