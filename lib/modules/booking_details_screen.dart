import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/models/booking_user_information.dart';
import 'package:Gene/modules/doctor_details_screen.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class BookingDetailsScreen extends StatelessWidget {
  ///booking user model of doctor
  BookingUserInformation? bookingUserInformation;
  ///doctor user id
  String? doctorUserId;
  ///date of user booking
  DateTime? date;
  ///reservation id in apis
  int? reservationId;
  BookingDetailsScreen({super.key, BookingUserInformation? this.bookingUserInformation,required String this.doctorUserId,int? this.reservationId});


  @override
  Widget build(BuildContext context) {
    double screenHeight =MediaQuery.sizeOf(context).height;
    double screenWidth =MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        if(bookingUserInformation==null){
          getBookingInformation(context: context);
        }
        date=DateTime.parse(bookingUserInformation!.date!);
        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {

          },
          builder: (context, state) {


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
                      padding:  EdgeInsets.only(top:screenHeight*0.0280),
                      child: PreferredSize(
                          preferredSize:Size(screenWidth,screenHeight*0.0464),
                          child: AppBar(
                            automaticallyImplyLeading: true,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            scrolledUnderElevation: 0,
                            title: defaultText(
                              context: context,
                              height: screenHeight*0.0464,
                              width: screenWidth * 0.4906,
                              text: S.of(context).date_information_text,
                              fontSize: 28,
                              textHeight: 1.32,
                              fontFamily: "Roboto",
                              color: defaultWhiteColor,
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
                      top: screenHeight * 0.1133,
                      start:screenWidth* 0.0327,
                      end: screenWidth* 0.0327,
                    ),
                    child: Container(
                      width: screenWidth,
                      height: screenHeight*0.7526,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: defaultWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: defaultBlackColor.withAlpha(40),
                            blurRadius: 15,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:  EdgeInsetsDirectional.only(
                          top:screenHeight* 0.0539 ,
                          start:screenWidth* 0.0408,
                          end:screenWidth* 0.0408,
                        ),
                        child: Container(
                          width: screenWidth,
                          child:ConditionalBuilder(
                            condition: bookingUserInformation !=null,
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  /// Title
                                  Container(
                                    height: screenHeight * 0.0464,
                                    width:screenWidth * 0.574,
                                    child: defaultText(width: screenWidth * 0.574,
                                        height: screenHeight * 0.0464,
                                        text:S.of(context).book_information_text,
                                        color: Color(0xff707070),
                                        boxFit: BoxFit.fill,
                                        textAlign: TextAlign.center,
                                        textHeight: 1.34,
                                        fontSize: 32,
                                        context: context),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0367,
                                  ),

                                  /// clinic name
                                  Container(
                                    height: screenHeight * 0.04697,
                                    width:screenWidth ,
                                    child:Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.0259,
                                          child: Row(
                                            children: [
                                              defaultText(
                                                  width: screenWidth * 0.1028,
                                                  text: S.of(context).clinic_booking_text,
                                                  color: Color(0xff707070),
                                                  fontSize: 18,
                                                  height:screenHeight * 0.3061,
                                                  textHeight: 1.333,
                                                  // boxFit: ,
                                                  textAlign: TextAlign.start,
                                                  context: context),
                                              Expanded(
                                                child:defaultText(
                                                    text: "${bookingUserInformation!.clinic!.name}",
                                                    color: defaultBlueDarkColor,
                                                    fontSize: 18,
                                                    height:screenHeight * 0.3061,
                                                    textHeight: 1.333,
                                                    // boxFit: ,
                                                    textAlign: TextAlign.end,
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    context: context),
                                              ),


                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.018,
                                        ),
                                        Container(
                                          height:screenHeight * 0.002,
                                          width: screenWidth,
                                          color: Color(0xff707070),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0080,
                                  ),

                                  /// doctor (full name)
                                  Container(
                                    height: screenHeight * 0.04697,
                                    width:screenWidth ,
                                    child:Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.0259,
                                          child: Row(
                                            children: [
                                              defaultText(width: screenWidth * 0.1261,
                                                  text: S.of(context).doctor_booking_text,
                                                  color: Color(0xff707070),
                                                  fontSize: 18,
                                                  height:screenHeight * 0.3061,
                                                  textHeight: 1.333,
                                                  // boxFit: ,
                                                  textAlign: TextAlign.start,
                                                  context: context),
                                              Expanded(
                                                child:defaultText(
                                                    text: "${bookingUserInformation!.doctor!.fullName}",
                                                    color: defaultBlueDarkColor,
                                                    fontSize: 18,
                                                    height:screenHeight * 0.3061,
                                                    textHeight: 1.333,
                                                    // boxFit: ,
                                                    textAlign: TextAlign.end,
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    context: context),
                                              ),


                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.0188,
                                        ),
                                        Container(
                                          height:screenHeight * 0.0021,
                                          width: screenWidth,
                                          color: Color(0xff707070),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0080,
                                  ),

                                  /// day of booking
                                  Container(
                                    height: screenHeight * 0.04697,
                                    width:screenWidth ,
                                    child:Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.0259,
                                          child: Row(
                                            children: [
                                              defaultText(
                                                  width: screenWidth * 0.2242,
                                                  text: S.of(context).day_booking_text,
                                                  color: Color(0xff707070),
                                                  fontSize: 18,
                                                  height:screenHeight * 0.3061,
                                                  textHeight: 1.333,
                                                  textAlign: TextAlign.start,
                                                  context: context),
                                              Expanded(
                                                child:defaultText(
                                                    text: "${date!.day} - ${date!.month}",
                                                    color: defaultBlueDarkColor,
                                                    fontSize: 18,
                                                    height:screenHeight * 0.3061,
                                                    textHeight: 1.333,
                                                    // boxFit: ,
                                                    textAlign: TextAlign.end,
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    context: context),
                                              ),


                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.0188,
                                        ),
                                        Container(
                                          height:screenHeight * 0.0021,
                                          width: screenWidth,
                                          color: Color(0xff707070),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0080,
                                  ),

                                  /// beginning date of booking
                                  Container(
                                    height:screenHeight * 0.04697,
                                    width:screenWidth,
                                    child:Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.0259,
                                          child: Row(
                                            children: [
                                              defaultText(
                                                  width: screenWidth * 0.0841,
                                                  text: S.of(context).fromText,
                                                  color: Color(0xff707070),
                                                  fontSize: 18,
                                                  height:screenHeight * 0.3061,
                                                  textHeight: 1.333,
                                                  textAlign: TextAlign.start,
                                                  context: context),
                                              Expanded(
                                                child:defaultText(
                                                    text: bookingUserInformation!.reservationTime!.from!,
                                                    color: defaultBlueDarkColor,
                                                    fontSize: 18,
                                                    height:screenHeight * 0.3061,
                                                    textHeight: 1.333,
                                                    // boxFit: ,
                                                    textAlign: TextAlign.end,
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    context: context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.0188,
                                        ),
                                        Container(
                                          height:screenHeight * 0.0021,
                                          width: screenWidth,
                                          color: Color(0xff707070),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0080,
                                  ),

                                  /// ending date of booking
                                  Container(
                                    height: screenHeight * 0.04697,
                                    width:screenWidth ,
                                    child:Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.0259,
                                          child: Row(
                                            children: [
                                              defaultText(
                                                  width: screenWidth * 0.0934,
                                                  text: S.of(context).toText,
                                                  color: Color(0xff707070),
                                                  fontSize: 18,
                                                  height:screenHeight * 0.3061,
                                                  textHeight: 1.333,
                                                  textAlign: TextAlign.start,
                                                  context: context),
                                              Expanded(
                                                child:defaultText(
                                                    text: "${bookingUserInformation!.reservationTime!.to}",
                                                    color: defaultBlueDarkColor,
                                                    fontSize: 18,
                                                    height:screenHeight * 0.3061,
                                                    textHeight: 1.333,
                                                    // boxFit: ,
                                                    textAlign: TextAlign.end,
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    context: context),
                                              ),


                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.0188,
                                        ),
                                        Container(
                                          height:screenHeight * 0.0021,
                                          width: screenWidth,
                                          color: Color(0xff707070),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0080,
                                  ),

                                  /// Payment state method
                                  Container(
                                    height: screenHeight * 0.04697,
                                    width:screenWidth ,
                                    child:Column(
                                      children: [
                                        Container(
                                          height: screenHeight * 0.0259,
                                          child: Row(
                                            children: [
                                              defaultText(
                                                  width: screenWidth * 0.3177,
                                                  text: S.of(context).pay_method_booking_text,
                                                  color: Color(0xff707070),
                                                  fontSize: 18,
                                                  height:screenHeight * 0.3061,
                                                  textHeight: 1.333,
                                                  textAlign: TextAlign.start,
                                                  context: context),
                                              Expanded(
                                                child:defaultText(
                                                    // text:"${bookingUserInformation!.payment}",
                                                    text:"${S.current.cash_button_text}",
                                                    color: defaultBlueDarkColor,
                                                    fontSize: 18,
                                                    height:screenHeight * 0.3061,
                                                    textHeight: 1.333,
                                                    textAlign: TextAlign.end,
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    context: context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.0188,
                                        ),
                                        Container(
                                          height:screenHeight * 0.0021,
                                          width: screenWidth,
                                          color: Color(0xff707070),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0080,
                                  ),

                                  Spacer(),

                                  ///edit book button
                                  defaultMaterialButton(
                                      height: screenHeight* 0.0583,
                                      context: context,
                                      backgroundColor: defaultBlueAccentColor,
                                      textColor: defaultWhiteColor,
                                      text: S.of(context).edit_booking_button_text,
                                      onPress: ()async{
                                        Doctors model=getDoctorModel(context: context)!;
                                        bool hasInternet=await NetworkConnection.getConnectivity();
                                        if(hasInternet){
                                          showDialog(context: context,builder:(context) => defaultCircleProgressBar(),);
                                          await HomeCubit.get(context).getDoctorsReservation(clinicsUsersId: int.parse(model.clinicUserId.toString())).then((value) {
                                            Navigator.pop(context);
                                            navigateAndReplace(context: context,widget: DoctorDetailsScreen(doctorModel: model,editable: true,bookingId: bookingUserInformation!.id,),);
                                          });
                                        }else{
                                          showSnackBar(context: context, text: S.current.failedConnection);
                                        }

                                      },
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0215,
                                  ),

                                  /// cancel book button
                                  defaultMaterialButton(
                                    height: screenHeight* 0.0583,
                                    context: context,
                                    backgroundColor: Color(0xffFE3398),
                                    textColor: defaultWhiteColor,
                                    text: S.of(context).cancel_booking_button_text,
                                    onPress:() async{
                                        await showDialog(context: context, builder:(context) => dialog(
                                            image: languageApp!="ar"?
                                            dialogImageOfCancelBookingConfirmationEN:
                                            dialogImageOfCancelBookingConfirmationAR,
                                            context: context,
                                            heightContainer:screenHeight * 0.6144,
                                            child: confirmCancelDialog(context: context,) ),);
                                    },
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0215,
                                  ),

                                  /// go to home page button
                                  defaultMaterialButton(
                                    height: screenHeight * 0.0583,
                                    context: context,
                                    backgroundColor: defaultBlueAccentColor,
                                    textColor: defaultWhiteColor,
                                    text: S.of(context).homeTitleNavBar,
                                    onPress: ()async{
                                      bool hasInternet=await NetworkConnection.getConnectivity();
                                      if(!hasInternet){
                                        showSnackBar(context: context, text: S.current.failedConnection);
                                      }
                                      navigateAndFinish(context,HomeScreen());
                                    },
                                  ),

                                  SizedBox(
                                    height: screenHeight * 0.0161,
                                  ),

                                ],
                              );
                            },
                            fallback: (context) => Container(),
                          ),
                        ),
                      ),
                      // color: Colors.white,
                    ),
                  ),

                  ///navBar
                  appNavBar(context: context,localIndex: 0),

                ],
              ),
            );
          },
        );
      },
    );
  }

  /// get booking information from list user booking information depending on doctor id
  getBookingInformation({
    required BuildContext context,
  }){
    for(int i=0;i<HomeCubit.get(context).bookingUserInformation.length;i++){
      if(HomeCubit.get(context).bookingUserInformation[i].doctorId!.compareTo(doctorUserId!)==0 && HomeCubit.get(context).bookingUserInformation[i].reservationTime!.id==reservationId){
        bookingUserInformation=HomeCubit.get(context).bookingUserInformation[i];
      }
    }
  }

  ///dialog to confirm cancel
  confirmCancelDialog({
    required BuildContext context,
  }){
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [

        SizedBox(
          height: screenHeight * 0.0356,
        ),

        ///confirm text
        Container(
          height: screenHeight * 0.0626,
          child: defaultText(
              text: S.of(context).confirm_cancellation_booking_text,
              fontSize: 22,
              textHeight: 1.3181,
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.center,
              boxFit: BoxFit.fitHeight,
              color: defaultGreyColor,
              context: context),
        ),

        SizedBox(
          height: screenHeight * 0.0302,
        ),

        ///confirm cancel booking
        Container(
          height: screenHeight * 0.0626,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: defaultBlueAccentColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: MaterialButton(
                    onPressed: () async{
                      bool hasInternet=await NetworkConnection.getConnectivity();
                      if(hasInternet){
                        showDialog(context: context,builder:(context) => defaultCircleProgressBar(),);
                        HomeCubit.get(context).cancelBookingForUser(bookingId:bookingUserInformation!.id!,context: context);
                      }else{
                        Navigator.pop(context);
                        showSnackBar(context: context, text: S.current.failedConnection);
                      }

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

  ///get data of doctor depending on doctor user id
  Doctors? getDoctorModel({
    required BuildContext context,
  }){
    Doctors? model;
    for(int i=0;i<HomeCubit.get(context).allDoctors.length;i++){
      if(doctorUserId!.compareTo(HomeCubit.get(context).allDoctors[i].userId.toString())==0){
        model=HomeCubit.get(context).allDoctors[i];
      }
    }
    return model;
  }

}
