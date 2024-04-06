import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/modules/payment_screen.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

class PaymentStateScreen extends StatelessWidget {
  const PaymentStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {

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

                  ///body
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: screenHeight * 0.0334,
                      top: screenHeight * 0.0140,
                      start: screenWidth * 0.0327,
                      end: screenWidth * 0.0327,
                    ),
                    child: Container(
                      width:screenWidth,
                      height: screenHeight,
                      decoration:
                      BoxDecoration(
                          color: defaultWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: defaultBlackColor.withAlpha(20),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child:Padding(
                        padding:  EdgeInsetsDirectional.only(
                          start:screenWidth* 0.0630,
                          end:screenWidth* 0.0630,
                          bottom:screenHeight* 0.096,
                          top:screenHeight* 0.070,
                        ),
                        child: successState(context: context),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }
}

  ///ui of success payment state
  Widget successState({
    required BuildContext context,
  }){
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        ///header image
        Container(
          height:screenHeight * 0.2764,
          width:screenWidth * 0.7009,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.transparent,
              // boxShadow: [
              //   BoxShadow(
              //     color: defaultBlackColor.withAlpha(18),
              //     blurRadius: 25,
              //     blurStyle: BlurStyle.outer,
              //   ),
              // ],
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child:
          Image.asset(
            languageApp!="ar"?imageOfSuccessPaymentStateEN:imageOfSuccessPaymentStateAR,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.0442,
        ),
        Container(
          height: screenHeight * 0.239,
          child: defaultText(
              width: screenWidth,
              text:S.of(context).waiting_while_pay_complete_text,
              fontSize: 28,
              textHeight: 1.3214,
              textAlign: TextAlign.center,
              boxFit: BoxFit.fill,
              color: Color(0xff707070),
              context: context),
        ),
        SizedBox(
          height: screenHeight * 0.0896,
        ),
        Container(
          height: screenHeight * 0.136,
          width: screenWidth * 0.247,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              defaultText(
                width: screenWidth * 0.247,
                height:screenHeight * 0.0399,
                text: S.of(context).successStateText,
                fontSize: 28,
                textHeight: 1.3214,
                textAlign: TextAlign.center,
                boxFit: BoxFit.fill,
                color: Color(0xff707070),
                context: context,),

              SizedBox(
                height: screenHeight * 0.014,
              ),

              Container(
                height:screenHeight * 0.082,
                width:screenWidth * 0.1775,
                child: Image.asset("assets/svgIcons/success.png",fit: BoxFit.fill),
              ),

            ],
          ),
        ),
      ],
    );
  }

  ///ui of failed payment state
  Widget errorState({
    required BuildContext context,
  }){
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        ///header image
        Container(
          height:screenHeight * 0.2764,
          width:screenWidth * 0.7009,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.transparent,
              // boxShadow: [
              //   BoxShadow(
              //     color: defaultBlackColor.withAlpha(18),
              //     blurRadius: 25,
              //     blurStyle: BlurStyle.outer,
              //   ),
              // ],
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child:
          Image.asset(
            languageApp!="ar"?imageOfErrorPaymentStateEN:imageOfErrorPaymentStateAR,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.0442,
        ),
        Container(
          height: screenHeight * 0.239,
          child:Column(
            children: [
              defaultText(
                  height:screenHeight * 0.103,
                  width: screenWidth,
                  text:S.of(context).decline_transaction_text,
                  fontSize: 24,
                  textHeight: 1.33,
                  textAlign: TextAlign.center,
                  boxFit: BoxFit.fill,
                  color: Color(0xff707070),
                  context: context),
              SizedBox(
                height: screenHeight * 0.0723,
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.0583,
                decoration: BoxDecoration(
                  color: defaultBlueAccentColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    navigateAndFinish(context,PaymentScreen());
                  },
                  child: Center(
                    child: Text(
                      S.of(context).back_to_checkout_button_text,
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
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.0896,
        ),
        Container(
          height: screenHeight * 0.136,
          width: screenWidth * 0.1775,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              defaultText(
                width: screenWidth * 0.1775,
                height:screenHeight * 0.0399,
                text: S.of(context).failStateText,
                fontSize: 28,
                textHeight: 1.3214,
                textAlign: TextAlign.center,
                boxFit: BoxFit.fill,
                color: Color(0xff707070),
                context: context,),
              SizedBox(
                height: screenHeight * 0.014,
              ),
              Container(
                height:screenHeight * 0.082,
                width:screenWidth * 0.1775,
                child: Image.asset("assets/svgIcons/failed.png",fit: BoxFit.fill),
              ),

            ],
          ),
        ),
      ],
    );
  }
