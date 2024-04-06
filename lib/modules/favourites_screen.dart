import 'package:Gene/modules/gene_clinics_screen.dart';
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/library/number_paginator/number_pagination_local.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/models/favourites_model.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class FavouritesScreen extends StatelessWidget {

  FavouritesScreen({super.key, this.doctorModel});

  Doctors? doctorModel;

  late double screenHeight;
  late double screenWidth;
  final int _numberOfListOfItems=5;
  int _i = 0;
  int _n = 0;
  int? lengthOfPages;
  BuildContext? globalContext;
  @override
  Widget build(BuildContext context){
    return Builder(
        builder: (context) {
          HomeCubit.get(context).onChangePageNumberOfFavourite(value: 1);

          return BlocConsumer<HomeCubit,HomeStates>(
            listener: (context, state) {

            },
            builder:(context, state) {
              var cubit=HomeCubit.get(context);
              globalContext=context;
              lengthOfPages = (HomeCubit.get(context).listOfFavourites.length / _numberOfListOfItems).ceil();
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

                    ///scaffold
                    SingleChildScrollView(
                      child: Stack(
                        children: [

                          ///app Bar
                          appBarWidget(
                            context: context,
                            height:MediaQuery.sizeOf(context).height * 0.2159,
                            width:MediaQuery.sizeOf(context).width,
                            titleAppBar: S.of(context).titleFavouritesPage,
                            assetBackgroundImage: "assets/container_home_page/title appBar.png",
                          ),

                          ///body
                          Padding(
                            padding:  EdgeInsetsDirectional.only(
                              start: screenWidth * 0.0327,
                              end: screenWidth * 0.0327,
                              top: screenHeight * 0.1263,
                              bottom: screenHeight * 0.1209,
                            ),
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight:screenHeight * 0.7 ),
                                child: Column(
                                  children: [

                                    ///list of favourite screens
                                    Container(
                                      height: screenHeight * 0.8693,
                                      clipBehavior: Clip.antiAlias,
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
                                      child: ConditionalBuilder(
                                        condition: HomeCubit.get(context).listOfFavourites.length != 0,
                                        builder: (context) {
                                          return Padding(
                                              padding:  EdgeInsetsDirectional.only(
                                                top: screenHeight * 0.0237,
                                                bottom: screenHeight * 0.0302,
                                                start:screenWidth * 0.0490,
                                                end: screenWidth * 0.0490,
                                              ),
                                              child: screensOfFavourites[cubit.selectedFavouritePageNumber-1]
                                          );
                                        },
                                        fallback: (context) => Container(),
                                      ),
                                    ),

                                    SizedBox(
                                      height:screenHeight * 0.01619,
                                    ),

                                    /// navigator between pages
                                    if(HomeCubit.get(context).listOfFavourites.length > 5)
                                      Container(
                                        height:screenHeight * 0.0853,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: defaultBlackColor.withAlpha(30),
                                                blurRadius: 15,
                                                blurStyle: BlurStyle.outer,
                                              ),
                                            ],
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
                                            pageTotal: lengthOfPages!,
                                            fontFamily: "Roboto",
                                            fontSize: 24,
                                            pageInit: cubit.selectedFavouritePageNumber,
                                            onPageChanged: (index){
                                              cubit.onChangePageNumberOfFavourite(value:index);
                                              lengthOfPages = (HomeCubit.get(context).notifications.length / _numberOfListOfItems).ceil();
                                              _i=HomeCubit.get(context).selectedFavouritePageNumber -1;
                                              if(HomeCubit.get(context).selectedFavouritePageNumber==1){
                                                _n=0;
                                              }else{
                                                _n= _i *_numberOfListOfItems-1;
                                              }
                                            },
                                            threshold: screensOfFavourites.length > 5 ? 5: screensOfFavourites.length,
                                          ),
                                        ),
                                      ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///nav Bar
                    appNavBar(context: context),

                  ],
                ),
              );
            },
          );
        }
    );
  }

  ///default container of favourite
  Widget _defaultContainer({
    required BuildContext context,
    required FavouritesModel model,
  }){
    _n++;
    return Container(
      height:screenHeight * 0.1501,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: defaultBlackColor.withAlpha(30),
              blurRadius: 15,
              blurStyle:BlurStyle.outer,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      child: Padding(
        padding:EdgeInsetsDirectional.only(
          start:screenWidth * 0.0233,
          end:screenWidth * 0.0420,
          bottom: screenHeight * 0.0064,
          top: screenHeight * 0.0064,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///image of doctor
            Container(
              height: screenHeight * 0.1360,
              width: screenWidth * 0.2943,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: defaultBlackColor
                        .withAlpha(16),
                    offset: Offset(0, 0),
                    blurRadius: 15,
                    blurStyle: BlurStyle.inner,
                  ),
                ],
              ),
              child: CircleAvatar(
                child: model.doctor!.image !=null?
                Image.network(model.doctor!.image!,fit: BoxFit.cover):
                Image.asset(
                    "assets/Background/avatar.png",fit: BoxFit.cover),
              ),
            ),

            SizedBox(
              width: screenWidth * 0.0093,
            ),

            Expanded(
              child: Container(
                height: screenHeight * 0.0982,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ///doctor name (full name)
                    defaultText(
                        text: model.doctor!.fullName!,
                        color: Color(0xff434343),
                        fontSize: 18,
                        fontFamily: "Roboto",
                        textAlign: TextAlign.start,
                        textHeight: 1.333,
                        boxFit: BoxFit.contain,
                        height:screenHeight * 0.0259,
                        context: context),

                    SizedBox(
                      height: screenHeight * 0.0194,
                    ),

                    ///specialization of doctor
                    defaultText(
                        text: "Heart Surgeon",
                        color: defaultBlueDarkColor.withOpacity(0.85),
                        fontSize: 12,
                        fontFamily: "Roboto",
                        width: screenWidth,
                        textAlign: TextAlign.start,
                        textHeight: 1.333,
                        height:screenHeight * 0.0172,
                        context: context
                    ),

                    Spacer(),

                    Container(
                      height:screenHeight * 0.02159,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          ///years of experience
                          defaultText(
                              text: "+10 Years exp.",
                              color: defaultBlueDarkColor.withOpacity(0.85),
                              fontSize: 12,
                              fontFamily: "Roboto",
                              textAlign: TextAlign.start,
                              textHeight: 1.333,
                              width: screenWidth * 0.1822,
                              height:screenHeight * 0.0172,
                              context: context
                          ),

                          Spacer(),

                          ///buttons(favourites - clinics)
                          Expanded(
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  ///favourite button
                                  Expanded(
                                    child: IconButton(
                                      iconSize: 35,
                                      alignment: AlignmentDirectional.center,
                                      padding: EdgeInsets.all(0),
                                      onPressed: () async{
                                        bool hasInternet=await NetworkConnection.getConnectivity();
                                        if(hasInternet){
                                          showDialog(context: context, builder: (context) =>defaultCircleProgressBar());
                                          await HomeCubit.get(context).deleteFavourite(doctorUserId:model.doctor!.id!).then((value)async{
                                            Navigator.pop(context);
                                            await showDialog(context: context, builder:(context) => defaultDialog(context: context,text: S.of(context).doctorDeletedSuccessfully,));
                                          });
                                          await HomeCubit.get(globalContext).getClinicsData();                                        
                                        }else{
                                          showSnackBar(context: context, text: S.current.failedConnection);
                                        }
        
                                      },
                                      icon: SvgPicture.asset(
                                        fit: BoxFit.contain,
                                        "assets/svgIcons/favourite.svg",
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),

                                  ///clinics button
                                  Expanded(
                                    child: IconButton(
                                      iconSize: 35,
                                      alignment: AlignmentDirectional.center,
                                      padding: EdgeInsets.all(0),
                                      onPressed: () async{
                                        bool hasInternet=await NetworkConnection.getConnectivity();
                                        if(!hasInternet){
                                          showSnackBar(context: context, text: S.current.failedConnection);
                                        }
                                        navigateAndPush(context, GeneClinicsScreen());
                                      },
                                      icon: SvgPicture.asset(
                                        fit: BoxFit.contain,
                                        "assets/svgIcons/stethoscope-svgrepo-com.svg",
                                        color: defaultBlueDarkColor,
                                      ),
                                    ),
                                  ),

                                ],
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
    );
  }

  List<Widget> screensOfFavourites = [];
  ///fun to split screens in list
  splitScreens(BuildContext context) {
    int _lengthOfFavourites=HomeCubit.get(context).listOfFavourites.length;
    for (_i;_i < lengthOfPages!;_i++) {
      screensOfFavourites.add(
          Container(
            height: MediaQuery.sizeOf(context).height * 0.8693,
            child: ListView.separated(
              shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  for (_n; _n < HomeCubit.get(context).listOfFavourites.length;) {
                    return _defaultContainer(model: HomeCubit.get(context).listOfFavourites[_n],context: context);
                  }
                  return null;
                },
                separatorBuilder:(context, index) => SizedBox(
                  height: screenHeight * 0.01619,
                ),
                itemCount:
                (_lengthOfFavourites - ((_i) * _numberOfListOfItems)) > _numberOfListOfItems || (_lengthOfFavourites - ((_i) * _numberOfListOfItems)) == _numberOfListOfItems
                    ? _numberOfListOfItems
                    : _lengthOfFavourites % _numberOfListOfItems),
          )
      );
    }
  }
}
