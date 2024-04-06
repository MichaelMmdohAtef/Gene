import 'package:Gene/library/scroll_bar/scrollBar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';

import '../generated/l10n.dart';

class DoctorsScreen extends StatefulWidget {

  DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  ScrollController? scrollDoctorController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollDoctorController=ScrollController(initialScrollOffset: HomeCubit.get(context).offSitOfDoctorsScreen);
    ///initialize the listener of Scroll Controller
    checkScrollDoctorUp(context);
  }

  @override
  Widget build(BuildContext context) {

   double screenHeight =MediaQuery.sizeOf(context).height;
   double screenWidth =MediaQuery.sizeOf(context).width;

    return Builder(
      builder: (context) {
        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {

          },
          builder: (context, state) {
            var cubit=HomeCubit.get(context);
            return Scaffold(
              appBar: statusBar(),
              body: Stack(
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
                  appBarWidget(context: context,
                      height: MediaQuery.sizeOf(context).height * 0.21598,
                      width:MediaQuery.sizeOf(context).width,
                      assetBackgroundImage: "assets/container_home_page/title appBar.png",
                      titleAppBar: S.of(context).titleDoctorPage),

                  ///body
                  ConditionalBuilder(
                    condition: cubit.allDoctors.length != 0,
                    builder:(context) =>PositionedDirectional(
                      bottom: screenHeight*0.1263,
                      top: screenHeight * 0.1241,
                      start:screenWidth* 0.0327,
                      end: screenWidth* 0.0327,
                      child: Container(
                        width: screenWidth,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(image:AssetImage("assets/Background/background_item_doctors.png"),
                              fit: BoxFit.fill
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(
                            top:screenHeight* 0.0215 ,
                            bottom:screenHeight* 0.0551,
                            start:screenWidth* 0.015,
                            end:screenWidth* 0.015,
                          ),
                          child: ScrollbarLocal(
                            controller: scrollDoctorController,
                            interactive: true,
                            thumbVisibility: true,
                            thickness:15,
                            radius: Radius.circular(15),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(
                                horizontal: screenWidth* 0.0515,
                              ),
                              child: GridView.count(
                                crossAxisCount:2,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                controller: scrollDoctorController,
                                padding: EdgeInsets.all(5),
                                physics: ScrollPhysics(),
                                children: List.generate(
                                    cubit.allDoctors.length,
                                        (index) => itemOfDoctors(
                                          index: index,
                                        context: context,
                                        model: cubit.allDoctors[index],
                                        widgetScreen: DoctorsScreen()
                                    ),
                                ),
                                mainAxisSpacing: MediaQuery.sizeOf(context).height*0.0329,
                                crossAxisSpacing: MediaQuery.sizeOf(context).width*0.0397,
                                childAspectRatio:
                                0.614,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    fallback:(context) => PositionedDirectional(
                      bottom: screenHeight*0.1263,
                      top: screenHeight * 0.1241,
                      start:screenWidth* 0.0327,
                      end: screenWidth* 0.0327,
                      child: Container(
                        width: screenWidth,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(image:AssetImage("assets/Background/background_item_doctors.png"),
                              fit: BoxFit.fill
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(
                            top:screenHeight* 0.0215 ,
                            bottom:screenHeight* 0.0551,
                            start:screenWidth* 0.0665,
                            end:screenWidth* 0.0665,
                          ),
                          child: SingleChildScrollView(
                            child: Container(

                            ),
                          ),
                        ),
                        // color: Colors.white,
                      ),
                    ),
                  ),

                  /// navBar
                  appNavBar(context: context),

                ],
              ),
            );
          },
        );
      },
    );

  }

  ///scroll to top page in doctor screen
  void scrollDoctorsToTop() {
    scrollDoctorController!.animateTo(scrollDoctorController!.position.minScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  ///check if offset of screen bigger than 30 make the button of scroll appear
  void checkScrollDoctorUp(BuildContext context) {
    scrollDoctorController!..addListener(() {
      double offSit=scrollDoctorController!.offset;
      print(offSit);
      if (scrollDoctorController!.offset == scrollDoctorController!.position.maxScrollExtent-20) {
        HomeCubit.get(context).onBackDoctorsToTop(index: true,offSit: offSit);
      } else {
        HomeCubit.get(context).onBackDoctorsToTop(index: false,offSit: offSit);
      }
    });
  }
}
