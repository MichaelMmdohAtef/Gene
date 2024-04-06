import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/splash_layout/cubit/cubit.dart';
import 'package:Gene/layouts/splash_layout/cubit/states.dart';
import 'package:Gene/models/Splash_Model.dart';
import 'package:Gene/modules/Sign_In/welcome_page.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  ///controller that control with index of screen
  PageController pageController=PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit,SplashState>(
      listener: (context, state) {

      },
      builder:(context, state) {
          var cubit=SplashCubit.get(context);
          return  Scaffold(
            appBar: statusBar(),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(
                      "assets/Background/cliped background.png"
                  ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Stack(
                    children: [
                      /// page view that control with index of screen
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) =>
                        index==0?
                        firstItemSplash(context,cubit.screens[index]):
                        itemSplash(context,cubit.screens[index],index),
                        itemCount:cubit.screens.length,
                        onPageChanged: (index) {
                          ///change index of screen
                          cubit.onchangeIndex(index: index,context: context);
                        },
                      ),
                      ///page indicator
                      Padding(
                        padding: EdgeInsets.only(bottom:MediaQuery.sizeOf(context).height*0.0341),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            height: MediaQuery.sizeOf(context).height *0.0248,
                            child: SmoothPageIndicator(
                              controller:pageController,
                              count: SplashCubit.get(context).screens.length,
                              effect: const ScrollingDotsEffect(
                                  activeDotColor:defaultWhiteColor ,
                                  dotColor: Color(0xff67B9C5),
                                  dotHeight: 16,
                                  dotWidth: 16,
                                  spacing: 18,
                                  activeStrokeWidth: 10
                              ),
                            ),
                          ),
                        ),
                      ),
                      ///skip to sign in button
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          top:MediaQuery.sizeOf(context).height*0.013,
                          end: MediaQuery.sizeOf(context).width*0.077,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: TextButton(
                            onPressed: (){
                              ///store on Boarding value in cash memory
                              SplashCubit.get(context).navigateOnBoarding(context: context,screen:WelcomePage());
                            },
                            child: Text(
                              S.current.skipButton,
                              style: const TextStyle(
                                fontSize: 24,
                                height: 1.33,
                                color: defaultWhiteColor,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }

  ///second & third splash screen
  Widget itemSplash(BuildContext context,SplashModel model,int index){
    ///body of splash screen
    return Padding(
      padding:  EdgeInsetsDirectional.only(
        top: MediaQuery.sizeOf(context).height *0.114,
        start:MediaQuery.sizeOf(context).width *0.0397 ,
        end:MediaQuery.sizeOf(context).width * 0.0397,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// image
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1,color: const Color(0xff707070),
                style: BorderStyle.none,
                strokeAlign: BorderSide.strokeAlignOutside
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color:defaultBlackColor.withAlpha(8),
                  blurRadius: 25,
                  offset: const Offset(0, 0),
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
            clipBehavior: Clip.antiAlias,
            height:MediaQuery.sizeOf(context).height * 0.482,
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: index!=1?
                  ///third splash screen
                  Image.asset(
                    languageApp!="ar"?
                    thirdImageSplashScreenEN:
                    thirdImageSplashScreenAR,
                    fit: BoxFit.fill,):
                  ///second splash screen
                  Image.asset(
                languageApp!="ar"?
                secondImageSplashScreenEN:
                secondImageSplashScreenAR,
                fit: BoxFit.fill,),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.015,
          ),
          ///text with container
          Container(
            height:MediaQuery.sizeOf(context).height * 0.272,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: [
                Container(
                  height:MediaQuery.sizeOf(context).height * 0.272,
                  width: MediaQuery.sizeOf(context).width,
                  color:  defaultWhiteColor.withOpacity(0.41),
                  child:Padding(
                    padding: EdgeInsets.only(top:MediaQuery.sizeOf(context).height*0.0161),
                    child: Container(
                      width:MediaQuery.sizeOf(context).width * 0.656,
                      height:MediaQuery.sizeOf(context).height * 0.0356,
                      alignment: Alignment.topCenter,
                      child: Text(
                        textAlign: TextAlign.center,
                        model.text!,
                        style:const TextStyle(
                            height:1.1333,
                            color: Color(0xff67B9C5),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Arial"
                        ) ,
                      ),
                    ),
                  ) ,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///first splash screen
  Widget firstItemSplash(BuildContext context,SplashModel model){
    ///body of splash screen
    return Padding(
      padding:  EdgeInsetsDirectional.only(
        top: MediaQuery.sizeOf(context).height *0.114,
        start:MediaQuery.sizeOf(context).width *0.0397,
        end:MediaQuery.sizeOf(context).width * 0.0397,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///image
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1,color: const Color(0xff707070),
                  style: BorderStyle.none,
                  strokeAlign: BorderSide.strokeAlignOutside
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: defaultBlackColor.withAlpha(8),
                  blurRadius: 25,
                  offset: const Offset(0, 0),
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
            clipBehavior: Clip.antiAlias,
            height:MediaQuery.sizeOf(context).height * 0.222,
            width: MediaQuery.sizeOf(context).width * 0.341,
            child: Padding(
              padding: const EdgeInsets.all(15),
              ///second splash screen
              child: Image.asset(
                languageApp!="ar"?
                firstImageSplashScreenEN:
                firstImageSplashScreenAR,
                fit: BoxFit.fill,),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.0215,
          ),
          ///text with container
          Container(
            height:MediaQuery.sizeOf(context).height * 0.272,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: [
                Container(
                  height:MediaQuery.sizeOf(context).height * 0.272,
                  width: MediaQuery.sizeOf(context).width,
                  child:Padding(
                    padding: EdgeInsets.only(top:MediaQuery.sizeOf(context).height*0.0161),
                    child:defaultText(
                        text: model.text!,
                        width: MediaQuery.sizeOf(context).width,
                        color: Color(0xff67B9C5),
                        height: MediaQuery.sizeOf(context).height * 0.0356,
                        boxFit: BoxFit.fitHeight,
                        alignment: AlignmentDirectional.topCenter,
                        textAlign: TextAlign.center,
                        context: context,
                        textHeight:1.1333,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: "Arial"
                    ),
                  ) ,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
