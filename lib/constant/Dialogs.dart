// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/LoginedUser.dart';
import 'constant.dart';

class MyDialog {

  static void loadingDialog(context, {required Size size})  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: SizedBox(
                height: (size.width)*.8,
                width: (size.width)*.8,
                child: SpinKitSpinningLines(size: (size.width)*.3,lineWidth: 10,color: appThemColor)
            )
        );
      },
    );
  }


  static Future<void> showMyDialog(BuildContext context,  String massage, String btnNam,{Color? titleColor,Color? massageColor, String? titleText,IconData? icon})
  {

    Widget titleWidget;
    if(titleText!=null){
      titleWidget = Text(titleText,style: fixedHeadTextStyle(color: titleColor,family: 'Lemonada'),);
    }else{
      titleWidget=Icon(icon,color: titleColor,size: 50);
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Directionality(
          //textDirection: TextDirection.rtl,
          textDirection: TextDirection.ltr,
          child: AlertDialog(
            //backgroundColor: color,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )
            ),
            //title: Center(child: Text(title)),
            title: Center(child: titleWidget,),
            content: SingleChildScrollView(
              child: Center(child: Text(massage,style: fixedHeadTextStyle(color: massageColor,family: 'cairo'),)),
            ),
            actions: [
              SizedBox(
                width: 70,
                height: 35,
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(btnNam),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: appThemColor)
                            ),
                        )
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }


  static Future<bool?> backToLoginDialog(BuildContext context,String title,String nextRout)
  {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // if = false => user must tap button!
      builder: (context) {
        return Directionality(
          //textDirection: TextDirection.rtl,
          textDirection: TextDirection.ltr,
          child: AlertDialog(
            //backgroundColor: AppScreensColor,
            title: Center(child: Text(title,style: fixedHeadTextStyle(family: 'Lemonada'),)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context,false);
                },
                child: const Text("cancel"),
                style: fixedButtonStyle(12),
              ),
              ElevatedButton(
                onPressed: () {
                  LoginedUser.singOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(nextRout, (route) => false);
                },
                child: const Text("ok"),
                style: fixedButtonStyle(12),
              ),
            ],
          ),
        );
      },
    );
  }

}