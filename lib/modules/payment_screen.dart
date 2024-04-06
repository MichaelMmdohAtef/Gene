import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/modules/payment_state_screen.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  ClinicsModel? model;
  PaymentScreen({super.key,this.model});

  ///card number controller that control number of card written by user
  final TextEditingController cardNumberController=TextEditingController();

  ///holder name controller that control holder name written by user
  final TextEditingController holderNameController=TextEditingController();

  ///expiry date controller that control expiry date written by user
  final TextEditingController expiryDateController=TextEditingController();

  ///CVC controller that control CVC number written by user
  final TextEditingController cvcNumberController=TextEditingController();

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
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.2159,
                    width:MediaQuery.sizeOf(context).width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:AssetImage("assets/container_home_page/title appBar.png",),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(
                        top:screenHeight*0.0064,
                      ),
                      child: PreferredSize(
                          preferredSize:Size(screenWidth,screenHeight*0.0431),
                          child: AppBar(
                            automaticallyImplyLeading: true,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            scrolledUnderElevation: 0,
                            title:Container(
                              height:screenHeight * 0.0431,
                              width:screenWidth * 0.380,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: screenHeight* 0.0431,
                                    width: screenWidth * 0.093,
                                    child: Image.asset("assets/svgIcons/icon_payment.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth*0.011,
                                  ),
                                  defaultText(
                                    context: context,
                                    height: screenHeight*0.0399,
                                    width: screenWidth * 0.275,
                                    boxFit: BoxFit.fill,
                                    text: S.of(context).titleCheckoutPage,
                                    fontSize: 28,
                                    textHeight: 1.3214,
                                    fontFamily: "Roboto",
                                    color: defaultWhiteColor,
                                  ),
                                ],
                              ),
                            ),


                            centerTitle: true,
                            titleSpacing: 0,
                            leading: IconButton(
                              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              padding: EdgeInsetsDirectional.only(start: 10),
                              icon: Icon(Icons.arrow_back_sharp),
                              iconSize: 31,
                              color: defaultWhiteColor,
                              style: ButtonStyle(
                                alignment: Alignment.center,
                              ),
                            ),
                          )),
                    ),
                  ),

                  ///body
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: screenHeight* 0.0215,
                      top: screenHeight * 0.1133,
                      start:screenWidth* 0.0327,
                      end: screenWidth* 0.0327,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        height: screenHeight * 0.8650,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: defaultWhiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                                color: defaultBlackColor.withAlpha(40),
                                blurRadius: 15,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(0,0)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(
                            top:screenHeight* 0.0453,
                            bottom:screenHeight* 0.0183,
                            start:screenWidth* 0.0350,
                            end:screenWidth* 0.0350,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              ///header image of screen
                              Container(
                                height:screenHeight * 0.0529,
                                width:screenWidth * 0.3948,
                                child: Image.asset("assets/svgIcons/image_getways.png"),
                              ),

                              SizedBox(
                                height: screenHeight * 0.0431,
                              ),

                              ///card number container
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.030,
                                        ),
                                        defaultText(
                                            width: screenWidth * 0.268,
                                            height: screenHeight * 0.028,
                                            text: S.of(context).cardNumberText,
                                            fontSize: 20,
                                            color: defaultGreyColor,
                                            context: context),
                                        SizedBox(
                                          width: screenWidth * 0.0116,
                                        ),
                                        Container(
                                          width: screenWidth * 0.0210,
                                          height: screenHeight * 0.028,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text("*",
                                              style: TextStyle(
                                                color: Color(0xffFF0000),
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                height: 1.3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight *.015,
                                    ),
                                    defaultTextFormField(
                                        context: context,
                                        controller: cardNumberController,
                                        hint: "1234 1234 1234 1234",
                                        keyboardType: TextInputType.number,
                                        onValidate: (value) {
                                          if (value!.isEmpty) {
                                            return "Card number context can not be empty";
                                          }
                                          return null;
                                        })
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: screenHeight * 0.0248,
                              ),

                              ///holder name container
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [

                                        SizedBox(
                                          width: screenWidth * 0.030,
                                        ),
                                        defaultText(
                                            width: screenWidth * 0.268,
                                            height: screenHeight * 0.028,
                                            text: S.of(context).holderNameText,
                                            fontSize: 20,
                                            color: defaultGreyColor,
                                            context: context),
                                        SizedBox(
                                          width: screenWidth * 0.0116,
                                        ),
                                        Container(
                                          width: screenWidth * 0.0210,
                                          height: screenHeight * 0.028,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text("*",
                                              style: TextStyle(
                                                color: Color(0xffFF0000),
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                height: 1.3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight *.015,
                                    ),
                                    defaultTextFormField(
                                        context: context,
                                        controller: holderNameController,
                                        hint: "Ahmed Mohamed",
                                        keyboardType: TextInputType.name,
                                        onValidate: (value) {
                                          if (value!.isEmpty) {
                                            return "Holder Name context can not be empty";
                                          }
                                          return null;
                                        })
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: screenHeight * 0.0248,
                              ),

                              ///expiry date container
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.030,
                                        ),
                                        defaultText(
                                            width: screenWidth * 0.228,
                                            height: screenHeight * 0.028,
                                            text: S.of(context).expiryDateText,
                                            fontSize: 20,
                                            color: defaultGreyColor,
                                            context: context),
                                        SizedBox(
                                          width: screenWidth * 0.0116,
                                        ),
                                        Container(
                                          width: screenWidth * 0.0210,
                                          height: screenHeight * 0.028,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text("*",
                                              style: TextStyle(
                                                color: Color(0xffFF0000),
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                height: 1.3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight *.015,
                                    ),
                                    defaultTextFormField(
                                        context: context,
                                        controller: expiryDateController,
                                        hint: "MM/YY",
                                        onTap: ()async{
                                          DateTime? time;

                                          time=await showMonthYearPicker(context: context,
                                              initialDate: DateTime.now(),
                                              firstDate:DateTime(2000),
                                              lastDate:DateTime(2050));
                                          expiryDateController.text="${time!.month}/${time.year}";

                                        },
                                        keyboardType: TextInputType.number,
                                        onValidate: (value) {
                                          if (value!.isEmpty) {
                                            return "Expiry Date context can not be empty";
                                          }
                                          return null;
                                        })
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: screenHeight * 0.0248,
                              ),

                              ///CVC container
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.030,
                                        ),
                                        defaultText(
                                            width: screenWidth * 0.091,
                                            height: screenHeight * 0.028,
                                            text: S.of(context).cvcText,
                                            fontSize: 20,
                                            color: defaultGreyColor,
                                            context: context),
                                        SizedBox(
                                          width: screenWidth * 0.0116,
                                        ),
                                        Container(
                                          width: screenWidth * 0.0210,
                                          height: screenHeight * 0.028,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text("*",
                                              style: TextStyle(
                                                color: Color(0xffFF0000),
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                height: 1.3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight *.015,
                                    ),
                                    defaultTextFormField(
                                        context: context,
                                        controller: cvcNumberController,
                                        hint: "123",
                                        keyboardType: TextInputType.number,
                                        onValidate: (value) {
                                          if (value!.isEmpty) {
                                            return "CVC context can not be empty";
                                          }
                                          return null;
                                        })
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: screenHeight * 0.0248,
                              ),

                              ///cost container
                              Container(
                                height: screenHeight * 0.0313 ,
                                width: screenWidth,
                                child: Row(
                                  children: [
                                    defaultText(width:screenWidth* 0.392,
                                        text: S.of(context).payCostText,
                                        fontSize: 22,
                                        textHeight: 1.318,

                                        color: Color(0xff707070),
                                        context: context),
                                    Spacer(),
                                    defaultText(width:screenWidth* 0.1869,
                                        text: "\$200.00",
                                        fontSize: 22,
                                        textHeight: 1.318,

                                        color: Color(0xff707070),
                                        context: context),

                                  ],
                                ),
                              ),

                              Spacer(),

                              ///pay now button that complete booking
                              ///take cost of book from credit card
                              Container(
                                height: MediaQuery.sizeOf(context).height * 0.0583,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  color: defaultBlueAccentColor,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    showDialog(context: context, builder:(context) => dialog(
                                        image: languageApp!="ar"?
                                        dialogImageOfPayNowConfirmationEN:
                                        dialogImageOfPayNowConfirmationAR,
                                    context: context,
                                        heightContainer:screenHeight * 0.6144,
                                        child:confirmPaymentDialog(context: context)),);
                                  },
                                  child: Center(
                                    child: Text(
                                      S.of(context).pay_now_button_text,
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
                        // color: Colors.white,
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

  ///dialog to confirm process of payment
  confirmPaymentDialog({
    required BuildContext context,
  }) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.0356,
        ),

        ///confirm payment text
        Container(
          height: screenHeight * 0.0626,
          child: defaultText(
              width: screenWidth,
              text: S.of(context).confirm_pay_text,
              fontSize: 22,
              alignment: AlignmentDirectional.center,
              textHeight: 1.3181,
              textAlign: TextAlign.center,
              boxFit: BoxFit.fitHeight,
              color: defaultGreyColor,
              context: context),
        ),

        SizedBox(
          height: screenHeight * 0.0302,
        ),

        ///row of buttons (yes - no)
        Container(
          height: screenHeight * 0.0626,
          child: Row(
            children: [

              /// confirm payment button
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: defaultBlueAccentColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: MaterialButton(
                    onPressed: () async{
                        navigateAndFinish(context, PaymentStateScreen());
                    },
                    child: Center(
                      child: Text(
                        S.of(context).yes_button_text,
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
              ),

              SizedBox(
                width: screenWidth * 0.0233,
              ),

              /// cancel payment button
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFE3398),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        S.of(context).no_button_text,
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
              ),

            ],
          ),
        ),
      ],
    );
  }
}
