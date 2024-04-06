import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class VerificationScreen extends StatelessWidget {
  
  VerificationScreen({super.key, bool? this.forgetPassword,String? this.phone,String? this.emailVerification});
  String? phone;
  String? emailVerification;
  bool? forgetPassword;
  late double screenHeight;
  late double screenWidth;
  ///controller that control with focus node
  final focus=FocusNode();
  ///controller that control with number of pin code
  TextEditingController pinController = TextEditingController();
  ///controller that control scaffold screen
  var scaffoldKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    if(SignInCubit.get(context).initValueForVerificationScreen)
      SignInCubit.get(context).onInitialVerificationScreen();
    return BlocConsumer<SignInCubit,SignInState>(
      listener: (context, state) {
        if(state is OnSuccessSignInStates){
          if(state.value!.statusCode==200) {
            navigateAndFinish(context,HomeScreen());
          }
        }
      },
      builder: (context, state) {
        var cubit=SignInCubit.get(context);

        return Scaffold(
          appBar: statusBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: BlocConsumer<SignInCubit,SignInState>(builder: (context, state) {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  start: screenWidth * 0.0350,
                  end: screenWidth * 0.0350,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: scaffoldKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                      SizedBox(
                        height:screenHeight * 0.0518,
                      ),
                      ///title verification
                      defaultText(
                        text:S.of(context).titleVerificationPage,
                        color:defaultGreyColor,
                        alignment: AlignmentDirectional.center,
                        height:screenHeight * 0.0313,
                        context: context,
                      ),
                      SizedBox(
                        height:screenHeight * 0.0259 ,
                      ),
                      ///image
                      Container(
                        height:screenHeight * 0.1965,
                        width:screenWidth * 0.7009,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: defaultBlackColor.withAlpha(18),
                            //     blurRadius: 25,
                            //     blurStyle: BlurStyle.outer,
                            //   ),
                            // ],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            languageApp!="ar"?
                            imageVerificationScreenEN:
                            imageVerificationScreenAR,
                            fit: BoxFit.fill,),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.0194,
                      ),

                      ///text of verification
                      defaultText(
                          text:S.of(context).verificationText,
                          color: defaultGreyColor,
                          height:screenHeight * 0.0939,
                          fontSize: 22,
                          alignment: AlignmentDirectional.center,
                          textHeight: 1.318,
                          context: context,),


                      SizedBox(
                        height: screenHeight * 0.0380,
                      ),

                      ///Pin put to enter token of user
                      Container(
                        height:screenHeight * 0.097,
                        width: screenWidth,
                        child:Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            focusNode: focus,
                            controller: pinController,
                            length: 6,
                            keyboardType: TextInputType.phone,
                            listenForMultipleSmsOnAndroid: true,
                            submittedPinTheme:PinTheme(
                              height:screenHeight * 0.0626,
                              width:screenWidth * 0.1355,
                              textStyle: TextStyle(
                                  fontSize: 35
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffF5F5F5),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            hapticFeedbackType: HapticFeedbackType.heavyImpact,
                            separatorBuilder: (index) =>SizedBox(
                              width: screenWidth * 0.04205,
                            ),
                            defaultPinTheme: PinTheme(
                              height:screenHeight * 0.0626,
                              width:screenWidth * 0.1355,
                              textStyle: TextStyle(
                                  fontSize: 35
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffF5F5F5),
                                borderRadius:BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.0215,
                      ),

                      ///Continue with verification
                      defaultMaterialButton(
                        height: screenHeight * 0.0626,
                        context: context,
                        backgroundColor:defaultBlueAccentColor,
                        textColor:defaultWhiteColor,
                        text:S.of(context).continueText,
                        onPress: ()async{
                          FocusScope.of(context).unfocus();
                          cubit.onChangeSmsCode(code:pinController.text.toString());
                          bool hasInternet=await NetworkConnection.getConnectivity();
                          if(hasInternet){
                            cubit.verifyPassword(context: context, email:cubit.emailVerification!, token: pinController.text.toString(),forgetPass: forgetPassword!,);
                          }else{
                            showSnackBar(context: context, text: S.current.failedConnection);
                          }
                        },
                      ),
                    ]),
                  ),
                ),
              );
            }, listener: (context, state) {

            },),
          ),
        );
      },
    );
  }


}

///verification code dialog
///dialog to tell user that processing of register have been successful
///and navigate to home page
verificationCodeDialog({
  required BuildContext context,
}){
  late double screenHeight= MediaQuery.sizeOf(context).height;
  late double screenWidth= MediaQuery.sizeOf(context).width;
  return Column(
    children: [
      SizedBox(
        height: screenHeight * 0.0377,
      ),
      ///text
      defaultText(
          height:screenHeight * 0.0626,
          width: screenWidth * 0.7056,
          text: S.of(context).successAccountCreatedText,
          fontSize: 22,
          textHeight: 1.3181,
          alignment: AlignmentDirectional.center,
          textAlign: TextAlign.center,
          boxFit: BoxFit.fitHeight,
          color: defaultGreyColor,
          context: context
      ),

      SizedBox(
        height: screenHeight * 0.0280,
      ),

      ///navigate to home page
      defaultMaterialButton(
          height:screenHeight * 0.0626,
          context: context,
          backgroundColor: defaultBlueAccentColor,
          textColor:defaultWhiteColor,
          text:S.of(context).goToHomeButton,
          onPress: (){
            showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
            SignInCubit.get(context).signInWithPass(context: context, email: SignInCubit.get(context).registerModel!.email??"",
                pass: SignInCubit.get(context).registerModel!.password!,fromVerificationAfterRegister: true);
          }),
    ],
  );
}

