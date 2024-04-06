import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/modules/my_tickets.dart';
import 'package:Gene/modules/open_ticket.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class TicketsScreen extends StatelessWidget {
  TicketsScreen({super.key});

  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {

          },
          builder:(context, state) {
            screenHeight=MediaQuery.sizeOf(context).height;
            screenWidth=MediaQuery.sizeOf(context).width;
            ///scaffold
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
                    onPressLeading: (){
                      Navigator.pop(context);
                    },
                    height:MediaQuery.sizeOf(context).height * 0.2159,
                    width:MediaQuery.sizeOf(context).width,
                    titleAppBar:S.of(context).titleOfTicketsScreen,
                    assetBackgroundImage: "assets/container_home_page/title appBar.png",
                  ),

                  ///body
                  Stack(
                    children: [
                      PositionedDirectional(
                        height:screenHeight * 0.86285,
                        start: screenWidth * 0.0327,
                        end: screenWidth * 0.0327,
                        top: screenHeight * 0.1133,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                              top: screenHeight * 0.1004,
                              bottom: screenHeight * 0.2429,
                              start:screenWidth * 0.0677,
                              end: screenWidth * 0.0677,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                ///open ticket button
                                defaultMaterialButton(
                                  height: screenHeight * 0.0583,
                                  context: context,
                                  backgroundColor:defaultBlueAccentColor,
                                  textColor:defaultWhiteColor,
                                  text:S.of(context).openTicketsButtonText,
                                  onPress: ()async{
                                    navigateAndPush( context,OpenTicketScreen());
                                  },
                                ),

                                SizedBox(
                                  height:screenHeight * 0.09719,
                                ),

                                ///my tickets button
                                defaultMaterialButton(
                                  height: screenHeight * 0.0583,
                                  context: context,
                                  backgroundColor:defaultBlueAccentColor,
                                  textColor:defaultWhiteColor,
                                  text:S.of(context).myTicketsButtonText,
                                  onPress: ()async{
                                    if(userTokenApi!=null){
                                      bool hasInternet=await NetworkConnection.getConnectivity();
                                      if(hasInternet){
                                        showDialog(context: context, builder:(context) =>defaultCircleProgressBar());
                                        await HomeCubit.get(context).getAllTickets().then((value){
                                          Navigator.pop(context);
                                          navigateAndPush( context,MyTickets());
                                        });
                                      }else{
                                        navigateAndPush( context,MyTickets());
                                        showSnackBar(context: context, text: S.current.failedConnection);
                                      }

                                    }else{
                                      navigateAndPush(context,SignInScreen(fromUser: true,widget: MyTickets(),));
                                    }
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            );
          },
        );
      }
    );
  }

}
