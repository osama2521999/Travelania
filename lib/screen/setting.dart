import 'dart:io';
import 'package:bookingapp/bloCs/SettingsController/cubit.dart';
import 'package:bookingapp/bloCs/SettingsController/states.dart';
import 'package:bookingapp/constant/sharedLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/constant.dart';
import '../router/RoutePaths.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;
    
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).popAndPushNamed(RoutePaths.mainScreen);
        return true;
      },
      child: SharedLayout(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(child: Text("Setting Screen",style: fixedHeadTextStyle(font: 24,family: 'cairo')),),
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

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [

              Padding(padding: EdgeInsets.only(top: (size.height)*.07)),

              Container(
                width: size.width,
                height: 50,
                padding: const EdgeInsets.only(right: 10),
                margin: const EdgeInsets.only(left: 10,bottom: 20),
                child: ListView(
                  //reverse: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Text("Edit Your Profile : ",style: fixedHeadTextStyle(font: 18,family: "Lemonada"),textDirection: TextDirection.ltr),
                  ],
                ),
              ),

              BlocProvider(
                create: (context) => SettingsController(context)..checkPrefs(),
                child: BlocConsumer<SettingsController,SettingsStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var controller = SettingsController.get(context);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Directionality(
                    ///textDirection: TextDirection.rtl,
                    textDirection: TextDirection.ltr,
                    child: SwitchListTile(
                      title: Text('Change Mode',style: fixedHeadTextStyle(family: "Lemonada"),),
                      subtitle: Text(controller.modeName,style: fixedHeadTextStyle(),),
                      activeColor: appThemColor,
                      value: controller.darkMode,
                      onChanged: (bool value) {
                        controller.changeMode(value);
                      },
                    ),
                  ),*/
                        Stack(
                          children: [
                            controller.imagePass.isEmpty ?Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              width: (size.width)*.35,
                              height: (size.width)*.35,
                              child: ClipOval(child: controller.loadImage()),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 2
                                  )
                              ),
                            ):
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              height:  (size.width)*.35,
                              width:  (size.width)*.35,
                              decoration:  BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 2
                                ),
                                image: DecorationImage(
                                  image: FileImage(File(controller.imagePass)),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 120,left: 108),
                              child: IconButton(
                                onPressed: () => controller.imageDialog(),
                                icon: const Icon(Icons.camera_alt_outlined),
                                tooltip: "Change your Photo",
                                color: appThemColor,
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child:  Directionality(
                                  ///textDirection: TextDirection.rtl,
                                  textDirection: TextDirection.ltr,
                                  child: TextFormField(
                                    style: fixedHeadTextStyle(),
                                    controller: controller.newPassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'input New Password';
                                      }
                                      return null;
                                    },
                                    decoration: fixedInputDecoration("New Password",15.0,null),
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                  ),
                                ),
                                width: constFieldWidth(context,.6),
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              ),
                              Container(
                                child:  Directionality(
                                  ///textDirection: TextDirection.rtl,
                                  textDirection: TextDirection.ltr,
                                  child: TextFormField(
                                    style: fixedHeadTextStyle(),
                                    /// textAlign: TextAlign.right,
                                    controller: controller.confirmPassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'input Confirm Password';
                                      }
                                      return null;
                                    },
                                    decoration: fixedInputDecoration("Confirm Password",15.0,null),
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                  ),
                                ),
                                width: constFieldWidth(context,.6),
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                      "Change Password",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:  fontSize ,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Amiri'
                                      ),
                                    ),
                                    onPressed:() {
                                      if(_formKey.currentState!.validate()){
                                        controller.loading();
                                      }
                                    },
                                    style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                                  ),
                                ),
                                padding:const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                width: buttonsHeightWidth(context, 0, .6)[0],
                                height: buttonsHeightWidth(context, .08, 0)[1] ,

                              ),//Button
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
          ],
          onTap: (index){
            if(index==1){
              Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.mainScreen, (route) => false);
            }
          }
        ),

      ),
    );
  }
}
