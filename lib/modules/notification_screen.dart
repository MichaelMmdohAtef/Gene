import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/library/number_paginator/number_pagination_local.dart';
import 'package:Gene/models/notifications_model.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});
  late double screenHeight;
  late double screenWidth;
   int numberOfListOfItems=5;
   int i = 0;
   int n = 0;
  final NumberPaginatorController numberPaginatorController=NumberPaginatorController();
   int? lengthOfPages;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomeCubit.get(context).onChangePageNumberOfNotification(value: 1);

        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {

          },
          builder:(context, state) {
            var cubit=HomeCubit.get(context);
            lengthOfPages = (HomeCubit.get(context).notifications.length / numberOfListOfItems).ceil();
            splitScreens(context);
            screenHeight=MediaQuery.sizeOf(context).height;
            screenWidth=MediaQuery.sizeOf(context).width;
            return Scaffold(
              appBar: statusBar(),
              body:Stack(
                children: [

                  /// first background
                  Positioned(
                    height: MediaQuery.sizeOf(context).height * 0.8218,
                    width: MediaQuery.sizeOf(context).width,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage(
                          "assets/Background/App Background-1.png",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    top: 0,
                    left: 0,
                  ),

                  ///second background
                  Positioned(
                    height: MediaQuery.sizeOf(context).height * 0.8218,
                    width: MediaQuery.sizeOf(context).width,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage(
                          "assets/Background/App Background.png",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    top: MediaQuery.sizeOf(context).height * 0.8207,
                    left: 0,
                  ),

                  ///appbar
                  appBarWidget(
                    context: context,
                    height:MediaQuery.sizeOf(context).height * 0.2159,
                    width:MediaQuery.sizeOf(context).width,
                    titleAppBar: S.of(context).titleNotificationPage,
                    assetBackgroundImage: "assets/container_home_page/title appBar.png",
                  ),



                  ///body
                  Stack(
                    children: [
                      PositionedDirectional(
                          start: screenWidth * 0.0327,
                          end: screenWidth * 0.0327,
                          top: screenHeight * 0.1263,
                          bottom: screenHeight * 0.1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ///container that view notifications
                              Container(
                                height: screenHeight * 0.61,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: defaultBlackColor.withAlpha(30),
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 15,
                                    ),
                                  ],
                                  color: defaultWhiteColor,
                                ),
                                child: Padding(
                                  padding:  EdgeInsetsDirectional.only(
                                    top: screenHeight * 0.0237,
                                    bottom: screenHeight * 0.0237,
                                    start:screenWidth * 0.0490,
                                    end: screenWidth * 0.0490,
                                  ),
                                  child: screensOfNotifications[cubit.selectedPageNumber-1]
                                ),
                              ),

                              SizedBox(
                                  height:screenHeight * 0.01727,
                              ),

                              ///navigation controller that navigate back & next
                              ///show number of pages
                              Container(
                                height:screenHeight * 0.0853,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: defaultBlackColor.withAlpha(30),
                                    //     blurRadius: 15,
                                    //     blurStyle: BlurStyle.outer,
                                    //   ),
                                    // ],
                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                ),
                                child: Padding(
                                  padding:EdgeInsetsDirectional.only(
                                    start:screenWidth * 0.04439,
                                    end:screenWidth * 0.0420,
                                    bottom: screenHeight * 0.0151,
                                    top: screenHeight * 0.01619,
                                  ),
                                  child: NumberPaginationLocal(
                                    noNumber: true,
                                    pageTotal: lengthOfPages!,
                                    fontFamily: "Roboto",
                                    fontSize: 24,
                                    pageInit: cubit.selectedPageNumber,
                                    onPageChanged: (index){
                                      lengthOfPages = (HomeCubit.get(context).notifications.length / numberOfListOfItems).ceil();
                                      cubit.onChangePageNumberOfNotification(value:index);
                                      i=HomeCubit.get(context).selectedPageNumber -1;
                                      if(HomeCubit.get(context).selectedPageNumber==1){
                                        n=0;
                                      }else{
                                        n= i *numberOfListOfItems;
                                      }
                                    },
                                    threshold: screensOfNotifications.length > 5 ? 5: screensOfNotifications.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///navbar
                  appNavBar(context: context),

                ],
              ),
            );
          },
        );
      }
    );
  }

  ///widget of notification
  Widget _defaultContainer({
     required BuildContext context,
     required NotificationModel model,
}){
    n++;
    return Container(
      height:screenHeight * 0.0939,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: defaultBlackColor.withAlpha(30),
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      child: Padding(
        padding:EdgeInsetsDirectional.only(
          start:screenWidth * 0.0560,
          end:screenWidth * 0.0140,
          bottom: screenHeight * 0.0161,
          top: screenHeight * 0.0140,
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///title
                defaultText(
                  height: screenHeight * 0.0313,
                    text: model.title!,
                    textHeight: 1.318,
                    fontSize: 22,
                    fontFamily: "Roboto",
                    color: Colors.blue,
                    context: context),

                defaultText(
                    height: screenHeight * 0.0205,
                    text: model.duration!,
                    textHeight: 1.357,
                    fontSize: 14,
                    fontFamily: "Roboto",
                    color: Colors.blue,
                    context: context),
              ],
            )),

            SizedBox(width:screenWidth * 0.0911,),

            // if(model.active!)
            // Container(
            //   height:screenHeight * 0.0259,
            //   width:screenWidth * 0.0560,
            //   clipBehavior: Clip.antiAlias,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: defaultBlueAccentColor,
            //   ),
            //
            // ),

          ],
        ),
      ),
    );
  }

  ///split screen every screen have seven notification
   List<Widget> screensOfNotifications = [];
   splitScreens(BuildContext context) {
     int lenghtOfNotifications=HomeCubit.get(context).notifications.length;
     for (i;i < lengthOfPages!;i++) {
       screensOfNotifications.add(
           ListView.separated(
           itemBuilder: (context, index) {
             for (n; n < HomeCubit.get(context).notifications.length;) {
               return _defaultContainer(model: HomeCubit.get(context).notifications[n],context: context);
             }
             return null;
           },
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           separatorBuilder:(context, index) => SizedBox(
             height: screenHeight * 0.0215,
           ),
           itemCount:
           (lenghtOfNotifications - ((i) * numberOfListOfItems)) > numberOfListOfItems || (lenghtOfNotifications - ((i) * numberOfListOfItems)) == numberOfListOfItems
               ? numberOfListOfItems
               : lenghtOfNotifications % numberOfListOfItems)
       );
     }
   }
}
