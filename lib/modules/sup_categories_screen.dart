
import 'package:Gene/library/scroll_bar/scrollBar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';


// ignore: must_be_immutable
class SupCategoriesScreen extends StatelessWidget {
  ClinicsModel? model;
  SupCategoriesScreen({required ClinicsModel this.model});


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

                  ///appBar
                  appBarWidget(context: context,
                      height: MediaQuery.sizeOf(context).height * 0.21598,
                      width:MediaQuery.sizeOf(context).width,
                      assetBackgroundImage: "assets/container_home_page/title appBar.png",
                      titleAppBar: model!.speciality!),

                  ///body
                  ConditionalBuilder(
                    condition: model!.supCategory!.length != 0,
                    builder:(context) =>PositionedDirectional(
                      bottom: screenHeight* 0.1339,
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
                            top: screenHeight * 0.03261,
                            start: screenWidth* 0.015,
                            end: screenWidth* 0.015,
                          ),
                          child: ScrollbarLocal(
                            interactive: true,
                            thumbVisibility: true,
                            thickness:15,
                            radius: Radius.circular(15),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(
                                horizontal: screenWidth* 0.04,
                              ),
                              child: SingleChildScrollView(
                                child: Container(
                                  width: screenWidth,
                                  child: GridView.count(
                                    crossAxisCount:3,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                        model!.supCategory!.length,
                                            (index) => itemSupClinic(
                                            context:
                                            context,
                                            model: model!.supCategory![index],
                                            clinicModel: model!,
                                            doctors: model!.doctors
                                        )),
                                    primary: false,
                                    mainAxisSpacing: MediaQuery.sizeOf(context).width*0.02336,
                                    crossAxisSpacing: MediaQuery.sizeOf(context).height*0.02332,
                                    childAspectRatio:
                                    0.75,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // color: Colors.white,
                      ),
                    ),
                    fallback: (context) =>PositionedDirectional(
                      bottom: screenHeight* 0.1339,
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
                            start:screenWidth* 0.0514,
                            end:screenWidth* 0.0514,
                          ),
                          child: SingleChildScrollView(
                            child: Container(),
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
}
