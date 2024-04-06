import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/modules/Sign_In/forget_password_with_email_screen.dart';
import 'package:Gene/modules/Sign_In/sign_up.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({bool? this.fromUser,Widget? this.widget,this.onPopToUserScreen});
  Function()? onPopToUserScreen;
  bool? fromUser;
  Widget? widget;
  late double screenHeight;
  late double screenWidth;
  ///controller that control email value
  TextEditingController emailController = TextEditingController();
  ///controller that control password value
  TextEditingController passwordController = TextEditingController();
  ///controller that control scaffold screen
  var scaffoldKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return BlocConsumer<SignInCubit,SignInState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit=SignInCubit.get(context);
          return Scaffold(
            ///appBar
            appBar:AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              title: defaultText(
                context: context,
                height: screenHeight * 0.0313,
                width: screenWidth * 0.1542,
                text: S.of(context).signInButton,
                fontSize: 22,
                textHeight: 1.318,
                color: defaultGreyColor,
              ),
              centerTitle: true,
              titleSpacing: 0,
              leading: IconButton(
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsetsDirectional.only(start: 10),
                icon: Container(
                  height: screenHeight * 0.0334,
                  width:screenWidth * 0.0724,
                  child: FittedBox(
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.cover,
                    child: Icon(Icons.arrow_back_sharp),
                  ),
                ),
                alignment: AlignmentDirectional.center,
                color: Color(0xffA1A1A1),
                style: ButtonStyle(
                  alignment: Alignment.center,
                ),
              ),
            ),

            body: Padding(
              padding: EdgeInsetsDirectional.only(
                top: screenHeight * 0.0067,
                start: screenWidth * 0.0350,
                end: screenWidth * 0.0350,
              ),
              child: Form(
                key: scaffoldKey,
                child: SingleChildScrollView(
                  child: Container(
                    width: screenWidth,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      ///image of screen
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.276,
                        width: MediaQuery.sizeOf(context).width * 0.7009,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: defaultBlackColor.withAlpha(8),
                          //     blurRadius: 25,
                          //     offset: Offset(0, 0),
                          //     blurStyle: BlurStyle.outer,
                          //   ),
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            languageApp!="ar"?
                            imageSignInScreenEN:
                            imageSignInScreenAR,
                            fit: BoxFit.fill,),
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.015,
                      ),
                      ///email field
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                              width: screenWidth * 0.1261,
                              text: S.of(context).emailText,
                              color: defaultGreyColor,
                              context: context),
                          SizedBox(
                            height: screenHeight * 0.0097,
                          ),
                          defaultTextFormField(
                              context: context,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onValidate: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).emailEmptyValidator;
                                }
                                return null;
                              })
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.015,
                      ),
                      ///password field
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                              height:screenHeight *0.03131,
                              text: S.of(context).passwordText,
                              color: defaultGreyColor,
                              context: context),
                          SizedBox(
                            height: screenHeight * 0.0097,
                          ),
                          defaultTextFormField(
                              context: context,
                              controller: passwordController,
                              onSuffixIcon: (){
                                cubit.onChangePasswordVisibility();
                              },
                              suffixIconSvg: cubit.hiddenPassword?"assets/svgIcons/not-visible.png":"assets/svgIcons/visible.png",
                              isPassword: cubit.hiddenPassword,
                              keyboardType: TextInputType.visiblePassword,
                              onValidate: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).passwordEmptyValidator;
                                }
                                return null;
                              })
                        ],
                      ),

                      SizedBox(
                        height: screenHeight * 0.0367,
                      ),

                      ///sign in
                      defaultMaterialButton(
                          height: MediaQuery.sizeOf(context).height * 0.0626,
                          context: context,
                          backgroundColor: defaultBlueAccentColor,
                          textColor:  defaultWhiteColor,
                          text: S.of(context).signInButton,
                          onPress: ()async{
                            if(scaffoldKey.currentState!.validate()){
                              bool hasInternet=await NetworkConnection.getConnectivity();
                              if(hasInternet){
                                showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                cubit.signInWithPass(context: context,
                                    email:emailController.text.trim(),
                                    pass:passwordController.text).then((value){
                                  // if(cubit.loginDataModel!=null && cubit.loginDataModel!.status != errorState){
                                  //   if(fromUser==null || fromUser == false ){
                                  //       // navigateAndFinish(context , HomeScreen());
                                  //     }else if(fromUser ==true && widget!=null){
                                  //     Navigator.pop(context);
                                  //   }
                                  //   }
                                });
                              }else{
                                showSnackBar(context: context, text: S.current.failedConnection);
                              }
                            }
                          }
                          ),

                      SizedBox(
                        height: screenHeight * 0.0151,
                      ),

                      ///forget password button
                      Container(
                        alignment: Alignment.center,
                        width: screenWidth,
                        height: screenHeight * 0.0799,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.0313,
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              child: TextButton(
                                  onPressed: () {
                                    navigateAndPush(context, ForgetPasswordWithEmailScreen());
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                                  ),
                                  clipBehavior: Clip.none,
                                  child: FittedBox(
                                    child: Text(
                                      S.of(context).forgetPasswordText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: defaultBlueAccentColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto",
                                        height: 1.318,
                                        fontSize: 22,
                                      ),
                                    ),
                                  )),
                            ),

                            Expanded(
                              child: SizedBox(),
                            ),

                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.0334,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: MediaQuery.sizeOf(context).height * 0.00215,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width * 0.334,
                                    height: MediaQuery.sizeOf(context).height * 0.0313,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xffD8D8D8),
                                          width: 1,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 1.0,
                                        end: 1,
                                      ),
                                      child: FittedBox(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          S.of(context).or_continue_text_devider,
                                          style: TextStyle(
                                            color: Color(0xff040404),
                                            fontFamily: "Roboto",
                                            height: 1.333,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: MediaQuery.sizeOf(context).height * 0.00215,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.0097,
                      ),

                      ///google and facebook
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.0626,
                        child: Row(
                          children: [
                            ///google button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffEBEBEB),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: MaterialButton(
                                  onPressed: () async{
                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                    if(!hasInternet){
                                      showSnackBar(context: context, text: S.current.failedConnection);
                                    }
                                    await SignInCubit.get(context).signInWithGoogle(context: context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: MediaQuery.sizeOf(context).height * 0.044,
                                        width: MediaQuery.sizeOf(context).width * 0.0957,
                                        child: Image.asset(
                                          "assets/svgIcons/google.png",
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width * 0.0467,
                                      ),
                                      defaultText(text: S.of(context).googleTextButton,
                                          width: MediaQuery.sizeOf(context).width * 0.1612,
                                          height: MediaQuery.sizeOf(context).height * 0.0313,
                                          color: defaultGreyColor,
                                          fontFamily: "Roboto",
                                          textHeight: 1.318,
                                          fontSize: 22,
                                          context: context),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.0467,
                            ),
                            ///facebook button
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffEBEBEB),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: MaterialButton(
                                  onPressed: () async{
                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                    if(!hasInternet){
                                      showSnackBar(context: context, text: S.current.failedConnection);
                                    }
                                    await cubit.signInWithFaceBook(context: context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: MediaQuery.sizeOf(context).height * 0.044,
                                        width: MediaQuery.sizeOf(context).width * 0.0957,
                                        child: Image.asset(
                                          "assets/svgIcons/facebook.png",
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width *  0.0467,
                                      ),
                                      defaultText(
                                          text: S.of(context).facebookTextButton,
                                          color: defaultGreyColor,
                                          width: MediaQuery.sizeOf(context).width * 0.1612,
                                          height: MediaQuery.sizeOf(context).height * 0.0313,
                                          fontFamily: "Roboto",
                                          textHeight: 1.318,
                                          fontSize: 22,
                                          context: context),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.0334,
                      ),
                      ///ask to sign up
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.0313,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultText(
                                text: S.of(context).askUserTextToSignUp,
                                color: Color(0xff5E5D5D),
                                height: MediaQuery.sizeOf(context).height * 0.0313,
                                fontFamily: "Roboto",
                                textHeight: 1.318,
                                fontSize: 22,
                                context: context),
                            SizedBox(
                              width:MediaQuery.sizeOf(context).width*0.0257 ,
                            ),
                            ///sign up button
                            Container(
                              height:MediaQuery.sizeOf(context).height * 0.0313,
                              child: TextButton(onPressed: (){
                                navigateAndPush(context,SignUpScreen());
                              },
                                  style:ButtonStyle(
                                    padding:MaterialStatePropertyAll(EdgeInsets.all(0)),
                                  ) ,
                                  clipBehavior: Clip.none,
                                  child:FittedBox(
                                    child: Text(S.of(context).signUpButton,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: defaultBlueAccentColor,
                                        fontFamily: "Roboto",
                                        height:1.318 ,
                                        fontSize:22 ,

                                      ),
                                    ),
                                  ) ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}
