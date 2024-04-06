import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/modules/chat/chat_screen.dart';
import 'package:Gene/modules/doctor_details_screen.dart';
import 'package:Gene/modules/favourites_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/library/number_paginator/number_pagination_local.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  late double screenHeight;
  late double screenWidth;
  final int _numberOfListOfItems=7;
  int _i = 0;
  int _n = 0;
  int? lengthOfPages;

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          HomeCubit.get(context).onChangePageNumberOfChats(value: 1);
          return BlocConsumer<HomeCubit,HomeStates>(
            listener: (context, state) {

            },
            builder:(context, state) {
              var cubit=HomeCubit.get(context);
              lengthOfPages = (HomeCubit.get(context).allDoctors.length / _numberOfListOfItems).ceil();
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

                    ///single child scroll view
                    SingleChildScrollView(
                      child: Stack(
                        children: [

                          ///appbar
                          appBarWidget(
                            context: context,
                            height:MediaQuery.sizeOf(context).height * 0.2159,
                            width:MediaQuery.sizeOf(context).width,
                            titleAppBar: S.of(context).titleOfChatsScreen,
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
                            ///single child scroll view
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight:screenHeight * 0.7),
                                child: Column(
                                  children: [

                                    ///container that show chats
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
                                        condition: HomeCubit.get(context).allDoctors.length != 0,
                                        builder: (context) {
                                          return Padding(
                                              padding:  EdgeInsetsDirectional.only(
                                                top: screenHeight * 0.0237,
                                                bottom: screenHeight * 0.0302,
                                                start:screenWidth * 0.0490,
                                                end: screenWidth * 0.0490,
                                              ),
                                              child: screensOfChats[cubit.selectedChatsPageNumber-1]
                                          );
                                        },
                                        fallback: (context) => Container(),
                                      ),
                                    ),

                                    SizedBox(
                                      height:screenHeight * 0.01619,
                                    ),

                                    ///navigation controller that navigate back & next
                                    ///show number of pages
                                    if(HomeCubit.get(context).allDoctors.length >5)
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
                                            pageInit: cubit.selectedChatsPageNumber,
                                            onPageChanged: (index){
                                              cubit.onChangePageNumberOfChats(value:index);
                                              lengthOfPages = (HomeCubit.get(context).allDoctors.length / _numberOfListOfItems).ceil();
                                              _i=HomeCubit.get(context).selectedChatsPageNumber -1;
                                              if(HomeCubit.get(context).selectedChatsPageNumber==1){
                                                _n=0;
                                              }else{
                                                _n= _i *_numberOfListOfItems;
                                              }
                                            },
                                            threshold: screensOfChats.length > 4 ? 4: screensOfChats.length,
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

  ///default container of doctor
  Widget _defaultContainer({
    required BuildContext context,
    required Doctors model,
  }){
    _n++;
    return InkWell(
      onTap: (){
        navigateAndPush(context,ChatScreen(doctorModel: model,));
      },
      child: Container(
        height:screenHeight * 0.101,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: defaultBlackColor.withAlpha(30),
                blurRadius: 15,
                blurStyle:BlurStyle.outer,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Padding(
          padding:EdgeInsetsDirectional.only(
            start:screenWidth * 0.00,
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
                  child: model.image !=null?
                  Image.network(model.image!,fit: BoxFit.cover):
                  Image.asset(
                      "assets/Background/avatar.png",fit: BoxFit.cover
                  ),
                ),
              ),

              SizedBox(
                width: screenWidth * 0.0093,
              ),

              ///expanded widget
              Expanded(
                child: Container(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ///full name of doctor
                      defaultText(
                          text: model.fullName!,
                          color: Color(0xff434343),
                          fontSize: 18,
                          fontFamily: "Roboto",
                          textAlign: TextAlign.start,
                          textHeight: 1.333,
                          boxFit: BoxFit.contain,
                          height:screenHeight * 0.0259,
                          context: context
                      ),

                      ///Row
                      Container(
                        height:screenHeight * 0.02159,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                            ///speciality
                            Expanded(
                              child:defaultTextWithoutFittedBox(
                                  text: model.speciality!,
                                  color: defaultBlueDarkColor.withOpacity(0.85),
                                  fontSize: 12,
                                  fontFamily: "Roboto",
                                  textAlign: TextAlign.start,
                                  textHeight: 1.333,
                                  height:screenHeight * 0.0272,
                                  context: context),
                              flex: 2,
                            ),

                            ///actions
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    ///favourites
                                    Expanded(
                                      child: Container(
                                        child: IconButton(
                                          iconSize: 35,
                                          alignment: AlignmentDirectional.center,
                                          padding: EdgeInsets.all(0),
                                          onPressed: () async{
                                            showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                            HomeCubit.get(context).getFavourites().then((value){
                                              navigateAndReplace(context: context,widget: FavouritesScreen(doctorModel: model,));
                                            });
                                          },
                                          icon: SvgPicture.asset(
                                            fit: BoxFit.contain,
                                            "assets/svgIcons/favourite.svg",
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ),

                                    ///booking
                                    Expanded(
                                      child: Container(
                                        child: IconButton(
                                          iconSize: 35,
                                          alignment: AlignmentDirectional.center,
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                            HomeCubit.get(context).getDoctorsReservation(clinicsUsersId: int.parse(model.clinicUserId.toString())).then((value){
                                              navigateAndReplace(context: context,widget: DoctorDetailsScreen(doctorModel: model,));
                                            });
                                          },
                                          icon: SvgPicture.asset(
                                            fit: BoxFit.contain,
                                            "assets/svgIcons/stethoscope-svgrepo-com.svg",
                                            color: defaultBlueDarkColor,
                                          ),
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
      ),
    );
  }

  List<Widget> screensOfChats = [];
  ///fun that split screens every screen have number of chats
  splitScreens(BuildContext context) {
    int _lengthOfTickets=HomeCubit.get(context).allDoctors.length;
    for (_i;_i < lengthOfPages!;_i++) {
      screensOfChats.add(
          Container(
            height: MediaQuery.sizeOf(context).height * 0.8693,
            child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  for (_n; _n < HomeCubit.get(context).allDoctors.length;) {
                    return _defaultContainer(model: HomeCubit.get(context).allDoctors[_n],context: context);
                  }
                  return null;
                },
                separatorBuilder:(context, index) => SizedBox(
                  height: screenHeight * 0.01619,
                ),
                itemCount:
                (_lengthOfTickets - ((_i) * _numberOfListOfItems)) > _numberOfListOfItems || (_lengthOfTickets - ((_i) * _numberOfListOfItems)) == _numberOfListOfItems
                    ? _numberOfListOfItems
                    : _lengthOfTickets % _numberOfListOfItems),
          )
      );
    }
  }
}
