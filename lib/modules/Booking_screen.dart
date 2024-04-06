import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/models/booking_user_information.dart';
import 'package:Gene/modules/History_page.dart';
import 'package:Gene/modules/booking_details_screen.dart';
import 'package:Gene/modules/gene_clinics_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class BookingScreen extends StatelessWidget {

  BookingScreen({super.key});

  ///list of history booking like (canceled, completed, waiting, elc...)
  List<BookingUserInformation>? listOfCanceledBooking;

  ///list of current booking
  List<BookingUserInformation>? listOfCurrentBooking;

  ///clinic of booking screen
  ClinicsModel? model;

  @override
  Widget build(BuildContext context) {

    listOfCanceledBooking=[];

    listOfCurrentBooking=[];


    double screenHeight =MediaQuery.sizeOf(context).height;
    double screenWidth =MediaQuery.sizeOf(context).width;

    return userTokenApi !=null?
    Builder(
      builder: (context) {

        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {

          },
          builder: (context, state) {
            splitListOfBookings(context: context);
            var cubit=HomeCubit.get(context);
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

                  /// appbar
                  appBarWidget(
                      context: context,
                      height: MediaQuery.sizeOf(context).height * 0.2159,
                      width:MediaQuery.sizeOf(context).width,
                      assetBackgroundImage: "assets/container_home_page/title appBar.png",
                      titleAppBar: S.of(context).titleMyBookingPage),

                  ///body
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight * 0.1133,
                      start:screenWidth* 0.0327,
                      end: screenWidth* 0.0327,
                    ),
                    child: Container(
                      width: screenWidth,
                      height: screenHeight*0.7602,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color:Colors.transparent,
                      ),
                      child: Stack(
                        children: [

                          ///tap Bar (current booking button, history booking button)
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.0701,
                              color: Colors.transparent,
                              child:
                              Row(
                                children: [

                                  ///current booking button
                                  Expanded(
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                        decoration: BoxDecoration(
                                          color: Color(0xffFE3398),
                                          borderRadius: BorderRadiusDirectional.only(
                                            topEnd: cubit.currentIndexTapBar==0?Radius.circular(15):Radius.circular(0),
                                            topStart: Radius.circular(15),
                                          ),),
                                        transform:cubit.currentIndexTapBar ==0?
                                        Matrix4.translationValues(0, 0, 0):
                                        Matrix4.translationValues(0, 15, 100),
                                        child:MaterialButton(
                                          onPressed: () {
                                            cubit.onChangeTapBar(index: 0);
                                          },
                                          child:Padding(
                                            padding: EdgeInsetsDirectional.only(
                                              bottom: cubit.currentIndexTapBar ==0?0:10,
                                            ),
                                            child:AnimatedContainer(
                                              duration: Duration(milliseconds: 500),
                                              child:defaultText(
                                                text: S.of(context).current_booking_button_text,
                                                textHeight: 1.318,
                                                color: defaultWhiteColor,
                                                context: context,
                                                alignment: AlignmentDirectional.center,
                                                boxFit: BoxFit.fill,
                                                height:cubit.currentIndexTapBar ==0?screenHeight * 0.04:screenHeight * 0.05,
                                                fontFamily: "Roboto",
                                              ),
                                            ),


                                          ),

                                        )
                                    ),
                                  ),

                                  ///history booking button
                                  Expanded(
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      decoration: BoxDecoration(
                                        color: defaultBlueAccentColor,
                                        borderRadius: BorderRadiusDirectional.only(
                                          topEnd: Radius.circular(15),
                                          topStart:cubit.currentIndexTapBar==1?Radius.circular(15):Radius.circular(0),
                                        ),
                                      ),
                                      transform:cubit.currentIndexTapBar == 1?
                                      Matrix4.translationValues(0, 0, 0)
                                      :Matrix4.translationValues(0, 15, 100),
                                      child: MaterialButton(
                                        onPressed: () async{
                                          cubit.onChangeTapBar(index: 1);
                                          // navigateAndFinish(context, PaymentStateScreen());
                                        },
                                        child:Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              bottom: cubit.currentIndexTapBar ==1?0:10,
                                          ),
                                          child:AnimatedContainer(
                                            duration: Duration(milliseconds: 500),
                                            child: defaultText(
                                              text: S.of(context).history_booking_button_text,
                                              textHeight: 1.318,
                                              color: defaultWhiteColor,
                                              alignment: AlignmentDirectional.center,
                                              context: context,
                                              boxFit: BoxFit.fill,
                                              height:cubit.currentIndexTapBar ==1?screenHeight * 0.04:screenHeight * 0.05,
                                              fontFamily: "Roboto",
                                            ),
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          ///page view for view booking
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: screenHeight * 0.6900,
                              width: screenWidth,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: defaultWhiteColor,
                              ),
                              child:Padding(
                                padding:  EdgeInsetsDirectional.only(
                                  top:screenHeight* 0.0064,
                                  bottom:screenHeight* 0.0183,
                                  end:screenWidth* 0.0467,
                                  start:screenWidth* 0.0467,
                                ),
                                child:cubit.currentIndexTapBar==0?
                                RefreshIndicator(
                                  onRefresh: () async{
                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                    if(hasInternet){
                                      // showDialog(context:context,builder:(context) => defaultCircleProgressBar(),);
                                      await HomeCubit.get(context).getBookingForUser().then((value){
                                        // Navigator.pop(context);
                                        navigateAndReplace(context:context,widget:BookingScreen());
                                      });
                                    }else{
                                      showSnackBar(context: context, text: S.current.failedConnection);
                                    }
                                  },
                                  child: ListView.separated(itemBuilder: (context, index) {
                                    return currentBookingItem(context: context,model: listOfCurrentBooking![index]);
                                  },
                                      separatorBuilder: (context, index) => SizedBox(
                                        height: screenHeight * 0.0215,
                                      ),
                                      itemCount:listOfCurrentBooking!.length),
                                ):
                                RefreshIndicator(
                                  onRefresh: ()  async{
                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                      if(hasInternet){
                                        // showDialog(context:context,builder:(context) => defaultCircleProgressBar(),);
                                        await HomeCubit.get(context).getBookingForUser().then((value){
                                          // Navigator.pop(context);
                                          navigateAndReplace(context:context,widget:BookingScreen());
                                        });
                                      }else{
                                        showSnackBar(context: context, text: S.current.failedConnection);
                                      }
                                  },
                                  child: ListView.separated(itemBuilder: (context, index) {
                                    return historyItem(context: context,model: listOfCanceledBooking![index]);
                                  },
                                      separatorBuilder: (context, index) => SizedBox(
                                        height: screenHeight * 0.0215,
                                      ),
                                      itemCount: listOfCanceledBooking!.length),
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// navBar
                  appNavBar(context: context,localIndex: 3),

                ],
              ),
            );
          },
        );
      },
    ):
    GeneClinicsScreen();
  }

  ///ui of current booking screen for user
  currentBookingItem({
    required BuildContext context,
    required BookingUserInformation model,
  }){
    double screenHeight =MediaQuery.sizeOf(context).height;
    double screenWidth =MediaQuery.sizeOf(context).width;
    return MaterialButton(
      onPressed: ()async{
        bool hasInternet=await NetworkConnection.getConnectivity();
        if(hasInternet){
          navigateAndPush(context,BookingDetailsScreen(bookingUserInformation: model,doctorUserId: model.doctorId!,));
        }else{
          navigateAndPush(context,BookingDetailsScreen(bookingUserInformation: model,doctorUserId: model.doctorId!,));
          showSnackBar(context: context, text: S.current.failedConnection);
        }
      },
      padding: EdgeInsets.all(0),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height:screenHeight * 0.1501,
          width:screenWidth * 0.8364,
          decoration: BoxDecoration(
            color: defaultWhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: defaultBlackColor.withAlpha(25),
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child:Padding(
            padding: EdgeInsetsDirectional.only(
              start:screenWidth* 0.0397,
              end:screenWidth* 0.0327,
              top:screenHeight * 0.01403,
              bottom:screenHeight * 0.0172,
            ),
            child: Column(
              children: [

                /// clinic name
                Container(
                  height: screenHeight * 0.0226,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          width: screenWidth * 0.0934,
                          text: S.of(context).clinic_booking_text,
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.0226,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      defaultText(
                          text: model.clinic!.name!,
                          color: defaultBlueDarkColor,
                          fontSize: 16,
                          textHeight: 1.312,
                          height:screenHeight * 0.0226,
                          textAlign: TextAlign.end,
                          alignment: AlignmentDirectional.centerEnd,
                          context: context),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.009,
                ),

                /// doctor (full name)
                Container(
                  height: screenHeight * 0.022,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          width: screenWidth * 0.1121,
                          text:S.of(context).doctor_booking_text ,
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.022,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      defaultText(
                          text: model.doctor!.fullName!,
                          color: defaultBlueDarkColor,
                          fontSize: 16,
                          textHeight: 1.312,
                          height:screenHeight * 0.022,
                          textAlign: TextAlign.end,
                          alignment: AlignmentDirectional.centerEnd,
                          context: context),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.0086,
                ),

                /// beginning date of booking
                Container(
                  height: screenHeight * 0.022,
                  width:screenWidth,
                  child:Row(
                    children: [
                      defaultText(
                          width: screenWidth * 0.0747,
                          text: S.of(context).date_my_booking_text,
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.022,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      Expanded(
                        child:defaultText(
                            text: "${model.date} , ${model.reservationTime!.from}",
                            color: defaultBlueDarkColor,
                            fontSize: 16,
                            textHeight: 1.312,
                            height:screenHeight * 0.022,
                            textAlign: TextAlign.end,
                            alignment: AlignmentDirectional.centerEnd,
                            context: context),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.009,
                ),

                /// Payment method
                Container(
                  height: screenHeight * 0.022,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          width: screenWidth * 0.1448,
                          text: S.of(context).payment_my_booking_text,
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.022,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      defaultText(
                          // text: "\$${model.price} - ${model.payment}",
                          text: "${S.current.cash_button_text} - \$${model.price}",
                          color: defaultBlueDarkColor,
                          fontSize: 16,
                          textHeight: 1.312,
                          textAlign: TextAlign.end,
                          height:screenHeight * 0.022,
                          alignment: AlignmentDirectional.centerEnd,
                          context: context),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }

  ///ui of history booking screen for user like (cancel, waiting, completed)
  historyItem({
    required BuildContext context,
    required BookingUserInformation model,
  }){
    double screenHeight =MediaQuery.sizeOf(context).height;
    double screenWidth =MediaQuery.sizeOf(context).width;
    return MaterialButton(
      onPressed: ()async{
        bool hasInternet=await NetworkConnection.getConnectivity();
        if(hasInternet){
          navigateAndPush(context,HistoryPage(model: model,));
        }else{
          navigateAndPush(context,HistoryPage(model: model,));
          showSnackBar(context: context, text: S.current.failedConnection);
        }
      },
      padding: EdgeInsets.all(0),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height:screenHeight * 0.1501,
          width:screenWidth * 0.8364,
          decoration: BoxDecoration(
            color: defaultWhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: defaultBlackColor.withAlpha(25),
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child:Padding(
            padding: EdgeInsetsDirectional.only(
              start:screenWidth* 0.0397,
              end:screenWidth* 0.0327,
              top:screenHeight * 0.01403,
              bottom:screenHeight * 0.0172,
            ),
            child: Column(
              children: [

                ///clinic name
                Container(
                  height: screenHeight * 0.0226,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          width: screenWidth * 0.0934,
                          text: S.of(context).clinic_booking_text,
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.0226,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      defaultText(
                          text: "${model.clinic!.name}",
                          color: defaultBlueDarkColor,
                          fontSize: 16,
                          textHeight: 1.312,
                          height:screenHeight * 0.0226,
                          textAlign: TextAlign.end,
                          alignment: AlignmentDirectional.centerEnd,
                          context: context),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.009,
                ),

                ///doctor (full name)
                Container(
                  height: screenHeight * 0.022,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          width: screenWidth * 0.1121,
                          text: S.of(context).doctor_booking_text,
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.022,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      defaultText(
                          text: "${model.doctor!.fullName}",
                          color: defaultBlueDarkColor,
                          fontSize: 16,
                          textHeight: 1.312,
                          height:screenHeight * 0.022,
                          textAlign: TextAlign.end,
                          alignment: AlignmentDirectional.centerEnd,
                          context: context),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.0086,
                ),

                /// beginning date of booking
                Container(
                  height: screenHeight * 0.022,
                  width:screenWidth,
                  child:Row(
                    children: [
                      defaultText(
                          width: screenWidth * 0.0747,
                          text: S.of(context).date_my_booking_text,
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.022,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      Expanded(
                        child:defaultText(
                            text: "${model.date} , ${model.reservationTime!.from}",
                            color: defaultBlueDarkColor,
                            fontSize: 16,
                            textHeight: 1.312,
                            height:screenHeight * 0.022,
                            textAlign: TextAlign.end,
                            alignment: AlignmentDirectional.centerEnd,
                            context: context),
                      ),
                    ],
                  ),
                ),


                SizedBox(
                  height: screenHeight * 0.009,
                ),

                /// Payment method
                Container(
                  height: screenHeight * 0.022,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          width: screenWidth * 0.1448,
                          text: "State",
                          color: Color(0xff707070),
                          fontSize: 16,
                          height:screenHeight * 0.022,
                          textHeight: 1.312,
                          textAlign: TextAlign.start,
                          context: context),
                      defaultText(
                          text: model.status!,
                          color: defaultBlueDarkColor,
                          fontSize: 16,
                          textHeight: 1.312,
                          textAlign: TextAlign.end,
                          height:screenHeight * 0.022,
                          alignment: AlignmentDirectional.centerEnd,
                          context: context),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }

  ///split fun
  ///fun to separate booked , other booking like (cancel, waiting, completed)
  splitListOfBookings({
    required BuildContext context
  }){
    listOfCurrentBooking=[];
    listOfCanceledBooking=[];
    for(int i=0;i<HomeCubit.get(context).bookingUserInformation.length;i++){
      if(HomeCubit.get(context).bookingUserInformation[i].status!.compareTo("booked")==0){
        listOfCurrentBooking!.add(HomeCubit.get(context).bookingUserInformation[i]);
      }else{
        listOfCanceledBooking!.add(HomeCubit.get(context).bookingUserInformation[i]);
      }
    }
  }

}

