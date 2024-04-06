import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/library/number_paginator/number_pagination_local.dart';
import 'package:Gene/models/ticket_model.dart';
import 'package:Gene/modules/ticket_details_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class MyTickets extends StatelessWidget {
  MyTickets({super.key});

  late double screenHeight;
  late double screenWidth;
  final int _numberOfListOfItems=5;
  int _i = 0;
  int _n = 0;
  int? lengthOfPages;

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          HomeCubit.get(context).onChangePageNumberOfTickets(value: 1);
          return BlocConsumer<HomeCubit,HomeStates>(
            listener: (context, state) {

            },
            builder:(context, state) {
              var cubit=HomeCubit.get(context);
              lengthOfPages = (HomeCubit.get(context).allTickets.length / _numberOfListOfItems).ceil();
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
                            titleAppBar: S.of(context).myTicketsButtonText,
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

                                    ///container that show tickets
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
                                        condition: HomeCubit.get(context).allTickets.length != 0,
                                        builder: (context) {
                                          return Padding(
                                              padding:  EdgeInsetsDirectional.only(
                                                top: screenHeight * 0.0237,
                                                bottom: screenHeight * 0.0302,
                                                start:screenWidth * 0.0490,
                                                end: screenWidth * 0.0490,
                                              ),
                                              child: screensOfTickets[cubit.selectedTicketsPageNumber-1]
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
                                    if(HomeCubit.get(context).allTickets.length >5)
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
                                            pageInit: cubit.selectedTicketsPageNumber,
                                            onPageChanged: (index){
                                              cubit.onChangePageNumberOfTickets(value:index);
                                              lengthOfPages = (HomeCubit.get(context).allTickets.length / _numberOfListOfItems).ceil();
                                              _i=HomeCubit.get(context).selectedTicketsPageNumber -1;
                                              if(HomeCubit.get(context).selectedTicketsPageNumber==1){
                                                _n=0;
                                              }else{
                                                _n= _i *_numberOfListOfItems;
                                              }
                                            },
                                            threshold: screensOfTickets.length > 4 ? 4: screensOfTickets.length,
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

  ///widget of ticket
  Widget _defaultContainer({
    required BuildContext context,
    required TicketModel model,
  }){
    _n++;
    return InkWell(
      onTap: () async{
        bool hasInternet=await NetworkConnection.getConnectivity();
        if(hasInternet){
          showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
          HomeCubit.get(context).getMyTicket(idOfTicket: model.id!).then((value){
            Navigator.pop(context);
            navigateAndPush(context,TicketDetailsScreen(idOfTicketModel: model.id,));
          });
        }else{
          showSnackBar(context: context, text: S.current.failedConnection);
        }
      },
      child: Container(
        height:screenHeight * 0.1501,
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
            start:screenWidth * 0.0584,
            bottom: screenHeight * 0.0215,
            top: screenHeight * 0.0215,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///title text
              defaultText(
                  text: "${S.of(context).titleContainerMyTicketsScreen} ${model.title!}",
                  color: Color(0xff434343),
                  fontSize: 18,
                  fontFamily: "Roboto",
                  textAlign: TextAlign.start,
                  textHeight: 1.333,
                  boxFit: BoxFit.contain,
                  height:screenHeight * 0.04,
                  context: context),

              SizedBox(
                height: screenHeight * 0.0194,
              ),

              ///sup title text
              defaultText(text: "${S.of(context).supTitleContainerMyTicketsScreen} ${model.type!}",
                  color: defaultBlueDarkColor.withOpacity(0.85),
                  fontSize: 12,
                  fontFamily: "Roboto",
                  width: screenWidth,
                  textAlign: TextAlign.start,
                  textHeight: 1.333,
                  height:screenHeight * 0.03,
                  context: context),
            ],
          ),
        ),
      ),
    );
  }


  List<Widget> screensOfTickets = [];
  ///fun that split screens every screen have five tickets
  splitScreens(BuildContext context) {
    int _lengthOfTickets=HomeCubit.get(context).allTickets.length;
    for (_i;_i < lengthOfPages!;_i++) {
      screensOfTickets.add(
          Container(
            height: MediaQuery.sizeOf(context).height * 0.8693,
            child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  for (_n; _n < HomeCubit.get(context).allTickets.length;) {
                    return _defaultContainer(model: HomeCubit.get(context).allTickets[_n],context: context);
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
