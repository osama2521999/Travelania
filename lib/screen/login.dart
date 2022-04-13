import 'package:bookingapp/bloCs/loginController/cubit.dart';
import 'package:bookingapp/bloCs/loginController/states.dart';
import 'package:bookingapp/router/RoutePaths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/CustomClip.dart';
import '../constant/constant.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;

    return Scaffold(
      //appBar: AppBar(title: const Text("Login")),


      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                child: Container(
                  width: size.width,
                  height: 300,
                  //color: Colors.orange,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background3.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                clipper: CustomClipPath(),
              ),

              const Padding(padding: EdgeInsets.only(top: 10)),

              BlocProvider(
                create: (context) => LoginController(context)..getSavedLogin(),
                child: BlocConsumer<LoginController,LoginStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var controller = LoginController.get(context);

                    return Form(
                      key: controller.formKey ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            child:  TextFormField(
                              controller: controller.email,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Input Valid Text';
                                }
                                RegExp regexp = RegExp(emailFormat);
                                if(regexp.hasMatch(value)){
                                  return null;
                                }
                                return "This is not valid Email";
                              },
                              decoration: fixedInputDecoration("Email",15.0,null),
                            ),
                            width: constFieldWidth(context,.6),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),
                          Container(
                            child:  TextFormField(
                              controller: controller.password,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Input Valid Text';
                                }
                                return null;
                              },
                              obscureText: controller.passMode,
                              decoration: fixedInputDecoration("Password",15.0,controller.seePass()),
                            ),
                            width: constFieldWidth(context,.6),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),

                          Container(
                            padding: EdgeInsets.fromLTRB((size.width)*.2, 5, 0, 0),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Save Password",
                                  style: fixedHeadTextStyle(font: fontSize-1,weight: FontWeight.bold,family: "cairo"),
                                ),
                                Checkbox(
                                  value: controller.savedPass,
                                  onChanged: (value) =>controller.changeCheckbox(value),
                                  activeColor: appThemColor,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(RoutePaths.signUp);
                                    },
                                    child: Text(
                                      "Sign up",
                                      style:  TextStyle(
                                        fontFamily: "cairo",
                                        color: appThemColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize-1,
                                      ),
                                    )
                                ),
                                Text(
                                  "If You not have account ",
                                  style: fixedHeadTextStyle(font: fontSize,weight: FontWeight.bold,family: 'cairo'),
                                ),
                              ],
                            ),
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
                                  "login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:  fontSize ,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Amiri'
                                  ),
                                ),
                                onPressed:() {
                                  if(controller.formKey.currentState!.validate()){
                                    controller.loading();
                                  }
                                },
                                style: fixedButtonStyle(12,buttonColor: Colors.transparent,elevation: 0),
                              ),
                            ),
                            padding:const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: buttonsHeightWidth(context, 0, .6)[0],
                            height: buttonsHeightWidth(context, .08, 0)[1] ,
                          ),
                        ],
                      ),
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
