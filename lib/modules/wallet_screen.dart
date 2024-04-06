
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {
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
                titleAppBar: S.of(context).walletTitleNavBar,
                assetBackgroundImage: "assets/container_home_page/title appBar.png",
              ),

              ///body
              Stack(
                children: [
                  PositionedDirectional(
                    height:screenHeight * 0.73,
                    start: screenWidth * 0.0327,
                    end: screenWidth * 0.0327,
                    top: screenHeight * 0.1133,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: defaultBlackColor.withAlpha(60),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 15,
                          ),
                        ],
                        color: defaultWhiteColor,
                      ),
                      child: Padding(
                        padding:  EdgeInsetsDirectional.only(
                          start:screenWidth * 0.0677,
                          end: screenWidth * 0.0677,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///text of body
                            defaultText(
                                text: S.of(context).contentOfWalletScreen,
                                boxFit: BoxFit.fill,
                                textAlign: TextAlign.center,
                                color: defaultBlueDarkColor,
                                alignment: AlignmentDirectional.center,
                                height: MediaQuery.sizeOf(context).height * 0.1,
                                textHeight: 1.3125,
                                fontFamily: "Arial",
                                fontSize: 45,
                                context: context,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///navbar
              appNavBar(context: context,localIndex: 2)

            ],
          ),
        );
      },
    );
  }
}
