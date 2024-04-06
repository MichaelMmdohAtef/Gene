import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/shared/components/constants.dart';

import '../../generated/l10n.dart';

// ignore: must_be_immutable
class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key, this.email,String? this.token,});
  late double screenHeight;
  late double screenWidth;
  String? email;
  String? token;

  ///controller that control the new password with it value
  TextEditingController passwordController = TextEditingController();
  ///controller that control the confirm password with it value
  TextEditingController confirmPasswordController = TextEditingController();

  ///controller that control the scaffold screen
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
          appBar: statusBar(),
          body: Padding(
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
                    height:screenHeight * 0.0518 ,
                  ),
                  ///title of page
                  defaultText(text:S.of(context).titleNewPassPage,
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
                    height:screenHeight * 0.276,
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
                        imageNewPasswordScreenEN:
                        imageNewPasswordScreenAR,
                        fit: BoxFit.fill,),
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.0237,
                  ),
                  ///new password
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    // height: screenHeight * 0.1036,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsetsDirectional.only(
                          start: screenWidth * 0.0327,
                        ),
                          child:defaultText(
                              height: screenHeight * 0.0313,
                              text: S.of(context).passwordText,
                              boxFit: BoxFit.fitHeight,
                              color: defaultGreyColor,
                              context: context),
                        ),
                        SizedBox(
                          height:screenHeight * 0.0070,
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
                  ),


                  SizedBox(
                    height: screenHeight * 0.0237,
                  ),

                  ///confirm password
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    // height: screenHeight * 0.1036,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsetsDirectional.only(
                          start: screenWidth * 0.0327,
                        ),
                          child:defaultText(
                              height: screenHeight * 0.0313,
                              text: S.of(context).confirmPasswordText,
                              boxFit: BoxFit.fitHeight,
                              color: defaultGreyColor,
                              context: context),
                        ),
                        SizedBox(
                          height:screenHeight * 0.0070,
                        ),
                        // Spacer(),
                        defaultTextFormField(
                            context: context,
                            controller:confirmPasswordController ,
                            onSuffixIcon: (){
                              cubit.onChangePasswordVisibility();
                            },
                            suffixIconSvg: cubit.hiddenPassword?"assets/svgIcons/not-visible.png":"assets/svgIcons/visible.png",
                            isPassword: cubit.hiddenPassword,
                            keyboardType: TextInputType.visiblePassword,
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).confirmNewPasswordEmptyValidator;
                              }else if(passwordController.text != confirmPasswordController.text){
                                return "confirm password must equal password";
                              }
                              return null;
                            })
                      ],
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.04,
                  ),

                  ///Continue button navigate confirm dialog
                  defaultMaterialButton(
                    height: screenHeight * 0.0626,
                    context: context,
                    backgroundColor:defaultBlueAccentColor,
                    textColor:defaultWhiteColor,
                    text:S.of(context).continueText,
                    onPress: ()async{
                      bool hasInternet=await NetworkConnection.getConnectivity();
                      if(scaffoldKey.currentState!.validate()){
                        if(hasInternet){
                          showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                          cubit.changePasswordWithForget(
                              context: context,
                              email: cubit.emailVerification!,
                              token: cubit.smsCode!,
                              pass: passwordController.text);
                        }else{
                          showSnackBar(context: context, text: S.current.failedConnection);
                        }

                      }
                    },
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }



}
///confirm dialog
///dialog that tell user that process of change password success
confirmNewPasswordDialog({
  required BuildContext context,
}){
  late double screenHeight=MediaQuery.sizeOf(context).height;
  late double screenWidth=MediaQuery.sizeOf(context).width;
  return Column(
    children: [
      SizedBox(
        height: screenHeight * 0.0377,
      ),
      ///text of check
      defaultText(
          height:screenHeight * 0.0626,
          width: screenWidth * 0.7056,
          text: S.of(context).successPassChangedText,
          fontSize: 22,
          alignment: AlignmentDirectional.center,
          textHeight: 1.3181,
          textAlign: TextAlign.center,
          boxFit: BoxFit.fitHeight,
          color: defaultGreyColor,
          context: context),
      SizedBox(
        height: screenHeight * 0.0280,
      ),
      ///navigate to login with new password
      defaultMaterialButton(
          height:screenHeight * 0.0626,
          context: context,
          backgroundColor: defaultBlueAccentColor,
          textColor:defaultWhiteColor,
          text: S.of(context).loginText,
          onPress: (){
            navigateAndFinish(context, SignInScreen());
          }),
    ],
  );
}
