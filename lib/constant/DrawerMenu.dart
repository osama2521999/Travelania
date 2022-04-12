// ignore_for_file: file_names
import 'dart:io';

import 'package:bookingapp/constant/constant.dart';
import 'package:bookingapp/router/RoutePaths.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dialogs.dart';


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {

  bool prefsChecker=false;
  String imagePass="";

  @override
  void initState() {
    checkPrefs();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(110),
      ),
      child: SizedBox(
        //width: 250,
        width: ((size.width)/2)+20,
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                imagePass.isEmpty ? Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: (size.width)*.35,
                  height: (size.width)*.35,
                  child: ClipOval(child: Image.asset("assets/images/DefaultUser.png")),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Colors.grey,
                          //color: ButtonColor,
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
                      image: FileImage(File(imagePass)),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),

                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    title: const Text(
                      'Main Screen',
                      //textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "Lemonada",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.mainScreen, (route) => false);
                    },
                    trailing: const Icon(
                      Icons.home,
                      size: 25,
                    ),
                  ),
                ),
                const Divider(color: Colors.black,),
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    title: Text(
                      'About App',
                     //textAlign: TextAlign.right,
                      style: fixedHeadTextStyle(family: "Lemonada",font: 16,weight: FontWeight.bold)
                    ),
                    onTap: () {

                    },
                    trailing: const Icon(
                      Icons.info_outline,
                      size: 25,
                    ),
                  ),
                ),
                const Divider(color: Colors.black,),
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    title: const Text(
                      'Setting',
                      //textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "Lemonada",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blueAccent,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.settings, (route) => false);
                    },
                    trailing: const Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const Divider(color: Colors.black,),
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    title: const Text('Sign Out',
                        //textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "Lemonada",
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    onTap: () {
                      //Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.start, (route) => false);
                      MyDialog.backToLoginDialog(context,"Do You Want to LogOut", RoutePaths.start);
                    },
                    trailing: const Icon(
                      Icons.logout,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("UserImage")){
      setState(() {
        prefsChecker=true;
        imagePass=prefs.getString('UserImage')!;
      });
    }else{
      prefsChecker=false;
    }
  }

}


