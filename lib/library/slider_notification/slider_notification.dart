
import 'package:Gene/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/modules/notification_screen.dart';

import '../../generated/l10n.dart';

// ignore: must_be_immutable
class NotificationSlider extends StatefulWidget {
  Widget? child;
  ScrollController? scrollController;
  NotificationSlider({super.key,Widget? this.child,ScrollController? controller});

  @override
  State<NotificationSlider> createState() => NotificationSliderState();
}

class NotificationSliderState extends State<NotificationSlider> with SingleTickerProviderStateMixin{
  AnimationController? animationController;
  Animation<Offset>? animation;
  
  @override
  void initState() {
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 10000));
    animation=Tween<Offset>(begin:Offset(0, 0) ,end:Offset(0, 0))
        .animate(CurvedAnimation(parent: animationController!, curve: Curves.ease));
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder:(context) {
          return BlocConsumer<HomeCubit,HomeStates>(
            listener: (context, state) {

            },
            builder: (context, state) {
                return SlideTransition(
                  position: animation!,
                  child:ConstrainedBox(
                    constraints: BoxConstraints(minWidth: MediaQuery.sizeOf(context).width,minHeight: MediaQuery.sizeOf(context).height* 0.2,maxHeight: MediaQuery.sizeOf(context).height* 0.5),
                    child: Column(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          // height: 200,
                          // width: double.infinity,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height * 0.02),
                            child: Column(
                              children: [
                                ListView.separated(
                                    itemBuilder: (context, index) => supItemOfNotificationUi(index: index),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => SizedBox(height: 5,),
                                    itemCount:notificationList.length),
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.01,
                                ),
                                Container(
                                  height: MediaQuery.sizeOf(context).height * 0.0626,
                                  width: MediaQuery.sizeOf(context).width * 0.97,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffFE3398),
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    15)),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Text(S.of(context).cancelButtonText,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: defaultWhiteColor,
                                                  fontFamily: "Roboto",
                                                  height: 1.318,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width * 0.0233,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: defaultBlueAccentColor,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(15)),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                                navigateAndPush(
                                                    context, NotificationScreen());
                                              });
                                            },
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Text(S.of(context).moreToNavigate,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(
                                                      0xffFFFFFF),
                                                  fontFamily:
                                                  "Roboto",
                                                  height: 1.318,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                );

              },
          );
        }
      ),
    );
          }

    supItemOfNotificationUi({
    required int index,
    }){
      return Padding(
        padding:EdgeInsetsDirectional.only(
          start:MediaQuery.sizeOf(context).width * 0.015,
          end:MediaQuery.sizeOf(context).width * 0.015,
          bottom: MediaQuery.sizeOf(context).height * 0.005,
          top: MediaQuery.sizeOf(context).height * 0.005,
        ),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: defaultBlackColor.withAlpha(40),
                  blurRadius: 15,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child: ListTile(
            onTap: () {

            },
            minLeadingWidth: 0,
            leading: CircleAvatar(
              child: Image.asset("assets/Background/icon_image.png",),
              radius: 18,
            ),
            title: Row(
              children: [
                // CircleAvatar(
                //   child: Image.asset("assets/Background/icon_image.png",),
                //   radius: 15,
                // ),
                // SizedBox(
                //   width: MediaQuery.sizeOf(context).width * 0.02,
                // ),
                Text(
                    "Title",
                    style: TextStyle(
                      color: defaultBlueDarkColor,
                    ),
                    maxLines: 1,
                  ),
                // SizedBox(
                //   width: MediaQuery.sizeOf(context).width * 0.01,
                // ),
                // Container(
                //   height:5,
                //   width: 5,
                //   decoration: BoxDecoration(
                //     color: defaultBlueDarkColor,
                //     shape: BoxShape.circle,
                //   ),
                // ),
                // SizedBox(
                //   width: MediaQuery.sizeOf(context).width * 0.01,
                // ),
                // Text(
                //   "APP",
                //   style: TextStyle(
                //     color: defaultBlueDarkColor,
                //   ),
                //   maxLines: 1,
                // ),
              ],
            ),
            subtitle: Text(
              "supTitle:${notificationList[index]}",
              style: TextStyle(
                color: defaultBlueDarkColor.withOpacity(0.7),
              ),
              maxLines:2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }


  // scrollToTop(){
  //   animationController!.animateBack(0,duration:Duration(milliseconds: 4000) ,curve:Curves.ease).then((value){
  //     HomeCubit().onCancelNotification(canceled: false);
  //     HomeCubit().onChangePressNotification(pressed: false);
  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     });
  //   });
  // }



  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }


}
