import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class ForgetPasswordWithEmailScreen extends StatelessWidget {
   ForgetPasswordWithEmailScreen({super.key});
  late double screenHeight;
  late double screenWidth;

  ///email controller that control with text of email
  TextEditingController emailController = TextEditingController();

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
                  ///title screen
                  defaultText(
                      text: S.of(context).forgetPasswordText,
                      color:defaultGreyColor,
                      textAlign: TextAlign.center,
                      alignment: AlignmentDirectional.center,
                      height:screenHeight * 0.039,
                      fontSize: 25,
                      context: context),
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
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        languageApp!="ar"?
                        imageForgetPasswordScreenEN:
                        imageForgetPasswordScreenAR,
                        fit: BoxFit.fill,),
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.0626,
                  ),

                  ///email field
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsetsDirectional.only(
                          start: screenWidth * 0.0327,
                        ),
                          ///email text
                          child:defaultText(
                              height: screenHeight * 0.0313,
                              text:S.of(context).emailText,
                              boxFit: BoxFit.fitHeight,
                              color: defaultGreyColor,
                              context: context),
                        ),
                        SizedBox(
                          height:screenHeight * 0.015 ,
                        ),
                        ///text field for email
                        defaultTextFormField(
                            context: context,
                            controller: emailController,
                            isPassword: false,
                            // hint: "+20 100 0000 000",
                            keyboardType: TextInputType.emailAddress,
                            // prefixWidget:true,
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).phoneEmptyValidator;
                              }
                              return null;
                            }
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.0539,
                  ),

                  ///send button
                  defaultMaterialButton(
                    height: screenHeight * 0.0626,
                    context: context,
                    backgroundColor:defaultBlueAccentColor,
                    textColor:defaultWhiteColor,
                    text:S.of(context).sendText,
                    onPress: ()async{
                      bool hasInternet=await NetworkConnection.getConnectivity();
                      if(hasInternet){
                        showDialog(context: context, builder:(context) => defaultCircleProgressBar());
                        await cubit.forgetPasswordWithEmail(context: context, email:emailController.text.trim(),forgetPass: true).then((value){
                          cubit.onChangeEmailVerification(email: emailController.text.trim());
                        });
                      }else{
                        showSnackBar(context: context, text: S.current.failedConnection);
                      }

                    },
                  ),

                  SizedBox(
                    height: screenHeight * 0.03,
                  ),

                  ///another way button
                  ///verification with phone number
                  // Padding(
                  //   padding: const EdgeInsetsDirectional.only(
                  //     end: 25,
                  //   ),
                  //   child: Container(
                  //     height: MediaQuery.sizeOf(context).height * 0.0313,
                  //     alignment: AlignmentDirectional.centerEnd,
                  //     child: TextButton(
                  //         onPressed: () {
                  //           navigateAndPush(context, ForgetPasswordWithPhoneNumberScreen());
                  //         },
                  //         style: ButtonStyle(
                  //           padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                  //         ),
                  //         clipBehavior: Clip.none,
                  //         child: FittedBox(
                  //           child: Text(
                  //             S.of(context).anotherWayText,
                  //             style: TextStyle(
                  //               color: defaultBlueAccentColor,
                  //               fontWeight: FontWeight.bold,
                  //               fontFamily: "Roboto",
                  //               height: 1.318,
                  //               fontSize: 22,
                  //             ),
                  //           ),
                  //         )),
                  //   ),
                  // ),

                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
