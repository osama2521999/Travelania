import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const MaterialAccentColor color=Colors.blueAccent;


const Color appThemColor=color;

/// bool appDarkMode = false;
/// String appModeName = "Light Mode";
/// Color appScreensColor=Colors.white;
/// Color appBarColor=Colors.grey.shade900;
/// Color appFieldColor=Colors.grey;


/// void darkThem(bool valid) {
///   if(valid){
///     appModeName="Dark Mode";
///     appDarkMode=valid;
///     appScreensColor=Colors.grey.shade900/*blueGrey.shade700*/;
///     appBarColor=Colors.white;
///     appFieldColor=Colors.white;
///   }else{
///     appModeName = "Light Mode";
///     appDarkMode=!valid;
///     appScreensColor=Colors.white;
///     appBarColor=Colors.grey.shade900;
///     appFieldColor=Colors.grey;
///   }
/// }

String emailFormat ="[a-zA-Z0-9\+\.\%\-\+]{1,256}"+"\\@"+"[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"+"("+"\\."+"[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"+")+";

List<TextInputFormatter> justNum=[
  LengthLimitingTextInputFormatter(3),
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
];


double constFieldWidth(BuildContext context,double scale){

  return (MediaQuery.of(context).size.width)*scale;

}


List<double> buttonsHeightWidth(BuildContext context,double scaleHeight,double scaleWidth){

  double width = (MediaQuery.of(context).size.width)*scaleWidth;
  double height = (MediaQuery.of(context).size.height)*scaleHeight;

  return [width,height];

}


InputDecoration fixedInputDecoration(String text,double border,Widget? suffix){
  return InputDecoration(

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),

    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      borderSide:  BorderSide(
        color: color.shade100,
        width: 2.0,
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      ///borderSide:  BorderSide(
        ///color: appFieldColor,
      ///),
    ),

    labelText: text,
    //labelStyle: TextStyle(color: appFieldColor),
    suffixIcon: suffix,
    suffixText: null,
  );

}


ButtonStyle fixedButtonStyle(double circular,{Color? buttonColor ,double? elevation }){
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all( buttonColor??appThemColor ),
      elevation: MaterialStateProperty.all(elevation),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circular),
              side: BorderSide(
                //color: Colors.orangeAccent.shade700,
                color: color.shade700,
              )
          )
      )
  );
}



TextStyle fixedHeadTextStyle({double? font, String? family,FontStyle? style,FontWeight? weight,Color? color}){
  return TextStyle(
      fontWeight: weight,
      fontStyle: style,
      color: color /*?? appBarColor*/,
      fontFamily: family,
      fontSize: font
  );
}

