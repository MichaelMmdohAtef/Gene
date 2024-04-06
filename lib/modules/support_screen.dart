import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/modules/open_ticket.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class SupportScreen extends StatelessWidget {
   SupportScreen({super.key});
  late double screenHeight;
  late double screenWidth;
  Uri phoneUrl=Uri.parse(phoneNumberSupport);
  Uri whatsAppUrl=Uri.parse(whatsAppNumberSupport);
  String assetSVGIcon="assets/svgIcons/support.png";
  String? assetPNGIcon="";
  BuildContext? glopalContext;
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
                titleAppBar: S.of(context).titleSupportPage,
                assetPNGIcon: "assets/svgIcons/support.png",
                assetBackgroundImage: "assets/container_home_page/title appBar.png",
              ),

              ///body
              Stack(
                children: [
                  PositionedDirectional(
                    height:screenHeight * 0.8,
                    start: screenWidth * 0.0327,
                    end: screenWidth * 0.0327,
                    top: screenHeight * 0.13,
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
                          start:screenWidth * 0.0677,
                          end: screenWidth * 0.0677,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            ///header title of screen
                            defaultText(
                                alignment: AlignmentDirectional.center,
                                text:S.of(context).contentTextSupportScreen,
                                color: Color(0xff656565),
                                height: screenHeight * 0.0345,
                                fontFamily: "Roboto",
                                fontSize: 24,
                                textHeight: 1.333,
                                context: context),

                            SizedBox(
                              height:screenHeight * 0.09719,
                            ),

                            ///columns that contain on buttons of contact
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    ///call us button
                                    _container(
                                      context: context,
                                      svgImage: "assets/svgIcons/callUs.svg",
                                      text: S.of(context).callUsTextSupportScreen,
                                      onTap: () {
                                        launchUrl(phoneUrl);
                                      },
                                    ),

                                    ///open ticket button
                                    _container(
                                      context: context,
                                      svgImage: "assets/svgIcons/openTicketSvg.svg",
                                      text: S.of(context).openTicketsButtonText,
                                      onTap: () {
                                        navigateAndPush(context, OpenTicketScreen());
                                      },
                                    ),

                                  ],
                                ),

                                SizedBox(
                                  height: screenHeight * 0.0464,
                                ),

                                ///whatsapp button
                                _container(
                                  context: context,
                                  svgImage: "assets/svgIcons/whatapp.svg",
                                  text: S.of(context).whatsappTextSupportScreen,
                                  onTap: () {
                                    launchUrl(whatsAppUrl);
                                  },
                                ),

                              ],
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

  ///default button that use in support screen
   Widget _container({
     required BuildContext context,
     required String text,
     required String svgImage,
     required Function() onTap,
   }){
     return MaterialButton(
       padding: EdgeInsets.all(0),
       onPressed:onTap,
       child: Container(
         width: screenWidth * 0.299,
         height:screenHeight * 0.1706,
         child: Column(
           children: [
             Container(
               width: screenWidth * 0.299,
               height:screenHeight * 0.1382,
               decoration: BoxDecoration(
                 color: defaultBlueAccentColor,
                 boxShadow: [
                   BoxShadow(
                     color: defaultBlackColor.withAlpha(60),
                     blurRadius: 12,
                     blurStyle: BlurStyle.outer,
                   ),
                 ],
                 borderRadius: BorderRadius.all(Radius.circular(20)),
               ),
               child: Center(
                 child: Container(
                   height:screenHeight * 0.0691,
                   width:screenWidth * 0.1495,
                   child: FittedBox(
                     fit: BoxFit.fill,
                     child: SvgPicture.asset(
                       svgImage,
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(
               height: screenHeight * 0.01079,
             ),
             defaultText(
                 height:screenHeight * 0.02159,
                 text: text,
                 alignment: AlignmentDirectional.center,
                 textHeight: 1.333,
                 textAlign: TextAlign.center,
                 color: Color(0xff717171),
                 context: context),
           ],
         ),
       ),
     );
   }

}
