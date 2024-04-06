import 'package:Gene/library/scroll_bar/scrollBar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';


// ignore: must_be_immutable
class SupDoctor extends StatefulWidget {
  ClinicsModel? model;
  SupDoctor({ClinicsModel? this.model});

  @override
  State<SupDoctor> createState() => _SupDoctorState();
}

class _SupDoctorState extends State<SupDoctor> {

  ScrollController? scrollDoctorController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollDoctorController=ScrollController(initialScrollOffset: HomeCubit.get(context).offSitOfSupDoctorsScreen);
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
            ///scaffold
            return Scaffold(
              appBar: statusBar(),


              body: Stack(
                children: [

                  /// first background
                  Positioned(
                    height:
                    MediaQuery.sizeOf(context).height * 0.8218,
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
                    height:
                    MediaQuery.sizeOf(context).height * 0.8218,
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
                  appBarWidgetWithoutIcon(context: context,
                      height: MediaQuery.sizeOf(context).height * 0.21598,
                      width:MediaQuery.sizeOf(context).width,
                      assetBackgroundImage: "assets/container_home_page/title appBar.png",
                      titleAppBar: "${widget.model!.name!}"),

                  ///body
                  ConditionalBuilder(
                    condition: widget.model!.doctors!.length != 0 ,
                    builder:(context) =>  PositionedDirectional(
                      bottom: screenHeight*0.1263,
                      top: screenHeight * 0.1241,
                      start:screenWidth* 0.0327,
                      end: screenWidth* 0.0327,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(image:AssetImage("assets/Background/background_item_doctors.png"),
                              fit: BoxFit.fill
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(
                            top:screenHeight* 0.03261 ,
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
                                horizontal: screenWidth* 0.04,
                              ),
                              child: GridView.count(
                                controller: scrollDoctorController,
                                crossAxisCount:2,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(5),
                                physics: ScrollPhysics(),
                                children: List.generate(
                                    widget.model!.doctors!.length,
                                        (index) => itemOfDoctors(
                                          index: index,
                                        context: context,
                                        model:widget.model!.doctors![index],
                                        widgetScreen:SupDoctor(model: widget.model)
                                    )),
                                mainAxisSpacing: MediaQuery.sizeOf(context).height*0.0329,
                                crossAxisSpacing: MediaQuery.sizeOf(context).width*0.0397,
                                childAspectRatio: (MediaQuery.sizeOf(context).width * 0.3808)
                                    / (MediaQuery.sizeOf(context).height * 0.2861),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => PositionedDirectional(
                      bottom: screenHeight*0.1263,
                      top: screenHeight * 0.1241,
                      start:screenWidth* 0.0327,
                      end: screenWidth* 0.0327,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(image:AssetImage("assets/Background/background_item_doctors.png"),
                              fit: BoxFit.fill
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(
                            top:screenHeight* 0.03261,
                            start:screenWidth* 0.0514,
                            end:screenWidth* 0.0514,
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                            ),
                          ),
                        ),
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
        HomeCubit.get(context).onBackSupDoctorsToTop(index: true,offSit: offSit);
      } else {
        HomeCubit.get(context).onBackSupDoctorsToTop(index: false,offSit: offSit);
      }
    });
  }
}
