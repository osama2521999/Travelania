// ignore_for_file: file_names
import 'package:bookingapp/constant/DrawerMenu.dart';
import 'package:flutter/material.dart';


class SharedLayout extends StatelessWidget {

  SharedLayout({Key? key, /*required*/ this.body,this.appBar,this.floatingActionButton,this.extendBodyBehindAppBar,this.bottomNavigationBar}) : super(key: key);

  Widget? body;
  bool? extendBodyBehindAppBar = false;
  AppBar? appBar;
  Widget? floatingActionButton;
  BottomNavigationBar? bottomNavigationBar;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        //FocusScope.of(context).unfocus();
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(

        ///backgroundColor: appScreensColor,
        extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
        key: _scaffoldKey,
        drawer: const DrawerMenu(),
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        body: body,

        // bottomNavigationBar: BottomNavigationBar(
        //   ///unselectedItemColor: appBarColor,
        //   ///backgroundColor: appScreensColor,
        //
        //   currentIndex: controller.currentIndex,
        //
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home/*,color: appBarColor*/),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.save/*,color: appBarColor*/),
        //       label: 'reserved',
        //     ),
        //   ],
        //
        //   onTap: controller.changeIndex,
        // ),
        bottomNavigationBar: bottomNavigationBar,

      ),
    );
  }
}
