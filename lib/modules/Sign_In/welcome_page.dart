import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/modules/Sign_In/sign_up.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';

class WelcomePage extends StatelessWidget {
   WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit,SignInState>(
      listener: (context, state) {

      },
        builder:(context, state) {
        var cubit=HomeCubit.get(context);
          return  Scaffold(
            appBar:statusBar(),
            body: Padding(
              padding: EdgeInsetsDirectional.only(
                  end:MediaQuery.sizeOf(context).width* 0.0373,
                  start: MediaQuery.sizeOf(context).width* 0.0373,
                top: MediaQuery.sizeOf(context).height * 0.0239,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                    ///skip button
                    Container(
                      height:MediaQuery.sizeOf(context).height * 0.0626,
                      width:MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: defaultBinkColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: MaterialButton(
                        onPressed: () async{
                        showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                        bool hasInternet=await NetworkConnection.getConnectivity();
                        if(hasInternet){
                          await cubit.getClinicsData().then((value){
                            navigateAndReplace(context: context,widget:  HomeScreen());
                          });
                        }else{
                          navigateAndReplace(context: context,widget:  HomeScreen());
                          showSnackBar(context: context, text: S.current.failedConnection);
                        }

                      },
                        child: Text(S.of(context).skipButton,
                        textAlign:TextAlign.center,
                        style: TextStyle(
                          color: defaultWhiteColor,
                          fontFamily: "Roboto",
                            height:1.318 ,
                          fontSize:22 ,
                        ),
                      ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.0410,
                    ),

                    ///welcome text
                    Container(
                      alignment: Alignment.center,
                      height:MediaQuery.sizeOf(context).height * 0.042 ,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(S.of(context).welcomeText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: defaultGreyColor,
                            fontFamily: "Roboto",
                            height:1.318 ,
                            fontSize:22 ,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.0215,
                    ),

                    ///image of screen
                    Container(
                      height:MediaQuery.sizeOf(context).height * 0.347 ,
                      width: MediaQuery.sizeOf(context).width* 0.7616,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: defaultBlackColor.withAlpha(8),
                        //     blurRadius: 25,
                        //     blurStyle: BlurStyle.outer,
                        //   ),
                        // ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          languageApp!="ar"?
                          imageWelcomePageScreenEN:
                          imageWelcomePageScreenAR,
                          fit: BoxFit.fill,),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.066,
                    ),

                    ///sign in with facebook
                    Container(
                      height:MediaQuery.sizeOf(context).height * 0.0626,
                      width:MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: MaterialButton(
                        onPressed: ()async{
                        bool hasInternet=await NetworkConnection.getConnectivity();
                        if(!hasInternet){
                          showSnackBar(context: context, text: S.current.failedConnection);
                        }
                        await SignInCubit.get(context).signInWithFaceBook(context: context);
                      },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height *0.044,
                              width:MediaQuery.sizeOf(context).width* 0.0957,
                              child: Image.asset("assets/svgIcons/facebook.png",
                              fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,

                              ),
                            ),
                            SizedBox(
                              width:MediaQuery.sizeOf(context).width*0.070 ,
                            ),
                            Container(
                              width:MediaQuery.sizeOf(context).width* 0.556 ,
                              height:MediaQuery.sizeOf(context).height * 0.0313 ,
                              child: FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(S.of(context).facebookButton,
                                  style: TextStyle(
                                    color: defaultGreyColor,
                                    fontFamily: "Roboto",
                                    height:1.318 ,
                                    fontSize:22 ,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    SizedBox(
                      height:MediaQuery.sizeOf(context).height * 0.0259,
                    ),

                    ///sign in with google
                    Container(
                      height:MediaQuery.sizeOf(context).height * 0.0626,
                      width:MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: MaterialButton(onPressed: () async{
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
                              height: MediaQuery.sizeOf(context).height *0.044,
                              width:MediaQuery.sizeOf(context).width* 0.0957,
                              child: Image.asset("assets/svgIcons/google.png",
                              fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,

                              ),
                            ),
                            SizedBox(
                              width:MediaQuery.sizeOf(context).width*0.070 ,
                            ),
                            Container(
                              width:MediaQuery.sizeOf(context).width* 0.556 ,
                              height:MediaQuery.sizeOf(context).height * 0.0313 ,
                              child: FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(S.of(context).googleButton,
                                  style: TextStyle(
                                    color: defaultGreyColor,
                                    fontFamily: "Roboto",
                                    height:1.318 ,
                                    fontSize:22 ,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    SizedBox(
                      height:MediaQuery.sizeOf(context).height*0.0269 ,
                    ),

                    ///or text
                    Container(
                        width: MediaQuery.sizeOf(context).width,
                        height:MediaQuery.sizeOf(context).height * 0.0345 ,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                                child: Container(
                                  height:MediaQuery.sizeOf(context).height * 0.00215,
                                  color: Color(0xff707070),
                                ),
                            ),

                            Container(
                              width:MediaQuery.sizeOf(context).width* 0.065,
                              height:MediaQuery.sizeOf(context).height * 0.0313 ,
                              child: FittedBox(
                                alignment: AlignmentDirectional.center,
                                child: Text(S.of(context).or_text_devider,
                                  style: TextStyle(
                                    color: Color(0xff040404),
                                    fontFamily: "Roboto",
                                    height:1.318 ,
                                    fontSize:22 ,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                height:MediaQuery.sizeOf(context).height * 0.00215,
                                color: Color(0xff707070),
                              ),
                            ),

                          ],
                        ),
                      ),

                    SizedBox(
                      height:MediaQuery.sizeOf(context).height*0.0259 ,
                    ),

                    ///sign in with password
                    Container(
                    height:MediaQuery.sizeOf(context).height * 0.0626,
                    width:MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: defaultBlueAccentColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: MaterialButton(
                      onPressed: ()async{
                        navigateAndPush(context, SignInScreen());
                    },
                      child: Center(
                        child: Text(S.of(context).signInWithPassButton,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: defaultWhiteColor,
                            fontFamily: "Roboto",
                            height:1.318 ,
                            fontSize:22 ,
                          ),
                        ),
                      ),

                    ),
                  ),

                    SizedBox(
                      height:MediaQuery.sizeOf(context).height*0.0215 ,
                    ),

                    ///sign up
                    Container(
                    height:MediaQuery.sizeOf(context).height * 0.0313 ,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height:MediaQuery.sizeOf(context).height * 0.0313,
                          // width: MediaQuery.sizeOf(context).width* 0.457,
                          child: FittedBox(
                            child: Text(S.of(context).askUserTextToSignUp,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff5E5D5D),
                                fontFamily: "Roboto",
                                height:1.318 ,
                                fontSize:22 ,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:MediaQuery.sizeOf(context).width*0.0257 ,
                        ),
                        Container(
                          height:MediaQuery.sizeOf(context).height * 0.0313,
                          // width: MediaQuery.sizeOf(context).width* 0.168,
                          child: TextButton(onPressed: (){
                            navigateAndPush(context,SignUpScreen());
                          },
                              style:ButtonStyle(
                                padding:MaterialStatePropertyAll(EdgeInsets.all(0)),
                              ),
                              clipBehavior: Clip.none,
                              child:FittedBox(
                                child: Text(S.of(context).signUpButton,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: defaultBlueAccentColor,
                                fontFamily: "Roboto",
                                height:1.318,
                                fontSize:22,
                            ),
                          ),
                              )),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
    );
  }
}
