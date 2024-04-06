import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/booking_user_information.dart';
import 'package:Gene/modules/medical_patient_details_screen.dart';
import 'package:Gene/modules/medical_prescription_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class HistoryPage extends StatefulWidget {
  HistoryPage({super.key, required this.model});
  BookingUserInformation? model;

  @override
  State<HistoryPage> createState() => _HistoryPageState(model);
}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin {
  BookingUserInformation? model;
  _HistoryPageState(this.model);

  late double screenWidth;
  DateTime? date;
  late double screenHeight;

  ///scaffold controller that control with scaffold state
  var scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if(model!.date!=null) {
      date=DateTime.parse(model!.date!);
    }
    screenHeight =MediaQuery.sizeOf(context).height;
    screenWidth =MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        HomeCubit.get(context).changeButtonSheet(isShow: false);
        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {

          },
          builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
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

                  /// appbar
                  appBarWidget(
                    context: context,
                      onPressLeading: (){
                        Navigator.pop(context);
                      },
                      height: MediaQuery.sizeOf(context).height * 0.2159,
                      width:MediaQuery.sizeOf(context).width,
                      titleAppBar: S.of(context).history_booking_button_text,
                      assetBackgroundImage:"assets/container_home_page/title appBar.png",
                  ),

                  ///body
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight * 0.09,
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
                          )
                        ],
                      ),
                      child: Padding(
                        padding:  EdgeInsetsDirectional.only(
                          top:screenHeight * 0.0239 ,
                          start:screenWidth * 0.0408,
                          end:screenWidth * 0.0408,
                        ),
                        child: Container(
                          width: screenWidth,
                          child:ConditionalBuilder(
                            condition: model != null,
                            builder: (context) {
                              return widget.model!.status=="canceled"?canceledHistory(context: context,model: model!)
                                  :doneHistory(context: context,model: model!);
                            },
                            fallback: (context) => Container(),
                          ),
                        ),
                      ),
                      // color: Colors.white,
                    ),
                  ),

                  /// navBar
                  appNavBar(context: context,localIndex: 0),

                ],
              ),
            );
          },
        );
      },
    );


  }

  ///ui of canceled bookings and other
  canceledHistory({
    required BuildContext context,
    required BookingUserInformation model
})=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      /// Title
      defaultText(
          height: screenHeight * 0.0464,
          text:S.of(context).book_information_text,
          color: Color(0xff707070),
          alignment: AlignmentDirectional.center,
          boxFit: BoxFit.fill,
          textAlign: TextAlign.center,
          textHeight: 1.34,
          fontSize: 32,
          context: context),


      SizedBox(
        height: screenHeight * 0.0367,
      ),

      /// clinic
      Container(
        height:screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultText(width: screenWidth * 0.1028,
                      text: S.of(context).clinic_booking_text,
                      color: Color(0xff707070),
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.start,
                      context: context),
                  defaultText(
                      text: model.clinic!.name!,
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


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

      /// doctor
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      text: model.doctor!.fullName!,
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


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
      if(date!=null)
      Column(
        children: [
          Container(
            height: screenHeight * 0.04697,
            width:screenWidth,
            child:Column(
              children: [
                Container(
                  height: screenHeight * 0.0259,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      defaultText(
                          text: "${date!.day.toString()} - ${date!.month.toString()}",
                          color: defaultBlueDarkColor,
                          fontSize: 18,
                          height:screenHeight * 0.3061,
                          textHeight: 1.333,
                          // boxFit: ,
                          textAlign: TextAlign.end,
                          alignment: AlignmentDirectional.centerEnd,
                          context: context),


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
          //sized box
          SizedBox(
            height: screenHeight * 0.0080,
          ),
        ],
      ),

      /// beginning time of booking
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

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
                  defaultText(
                      text: "${model.reservationTime!.from}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


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

      /// ending time of booking
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      text: "${model.reservationTime!.to}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


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

      /// Payment method
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      // text: "${model.payment}",
                      text: "${S.current.cash_button_text}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),
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
        height: screenHeight * 0.0102,
      ),

      ///status
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultText(
                      width: screenWidth * 0.3177,
                      text: S.of(context).stateText,
                      color: Color(0xff707070),
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      textAlign: TextAlign.start,
                      context: context),
                  defaultText(
                      text: "${model.status}",
                      color: Color(0xffB54343),
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),
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
        height: screenHeight * 0.013498,
      ),

      ///reason
      Column(
        children: [
          defaultText(
              text: S.of(context).reasonText,
              color: Color(0xff707070),
              fontSize: 18,
              fontFamily: "Roboto",
              height: screenHeight * 0.0259,
              textHeight: 1.333,
              textAlign: TextAlign.start,
              context: context),

          SizedBox(
            height: screenHeight * 0.02159,
          ),

          defaultText(
              text: "${model.notes??""}",
              color: defaultBlueDarkColor,
              fontSize: 18,
              height:screenHeight * 0.09719,
              textHeight: 1.333,
              fontFamily: "Roboto",
              boxFit: BoxFit.contain,
              textAlign: TextAlign.start,
              alignment: AlignmentDirectional.topStart,
              context: context),
        ],
      ),

    ],
  );

  ///ui of done bookings
  doneHistory({
    required BuildContext context,
    required BookingUserInformation model
})=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      /// Title
      defaultText(
          height: screenHeight * 0.0464,
          text:S.of(context).book_information_text,
          color: Color(0xff707070),
          boxFit: BoxFit.fill,
          alignment: AlignmentDirectional.center,
          textAlign: TextAlign.center,
          textHeight: 1.34,
          fontSize: 32,
          context: context),

      SizedBox(
        height: screenHeight * 0.0367,
      ),

      /// clinic
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultText(width: screenWidth * 0.1028,
                      text: S.of(context).clinic_booking_text,
                      color: Color(0xff707070),
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.start,
                      context: context),
                  defaultText(
                      text: "${model.clinic!.name}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


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

      ///sized box
      SizedBox(
        height: screenHeight * 0.0080,
      ),

      /// doctor
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      text: "${model.doctor!.fullName}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01781,
            ),
            Container(
              height:screenHeight * 0.0021,
              width: screenWidth,
              color: Color(0xff707070),
            ),
          ],
        ),
      ),

      ///sized box
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      text: "${date!.day.toString()} - ${date!.month.toString()}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


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

      /// beginning time of booking
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      text: "${model.reservationTime!.from}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01673,
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

      /// ending time of booking
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth ,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      text: "${model.reservationTime!.to}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      // boxFit: ,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),


                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01673,
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

      /// Payment method
      Container(
        height: screenHeight * 0.04697,
        width:screenWidth,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  defaultText(
                      // text: "${model.payment}",
                      text: "${S.current.cash_button_text}",
                      color: defaultBlueDarkColor,
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01673,
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
        height: screenHeight * 0.0102,
      ),

      ///Booking state
      Container(
        height: screenHeight * 0.04697,
        child:Column(
          children: [
            Container(
              height: screenHeight * 0.0259,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultText(
                      width: screenWidth * 0.3177,
                      text: S.of(context).stateText,
                      color: Color(0xff707070),
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      textAlign: TextAlign.start,
                      context: context),
                  defaultText(
                      text: "${model.status}",
                      color: Color(0xff2DDB55),
                      fontSize: 18,
                      height:screenHeight * 0.3061,
                      textHeight: 1.333,
                      boxFit: BoxFit.fitHeight,
                      textAlign: TextAlign.end,
                      alignment: AlignmentDirectional.centerEnd,
                      context: context),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0156,
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
        height: screenHeight * 0.0221,
      ),

      ///Medical examination details Button
      defaultMaterialButton(
        height: screenHeight * 0.0583,
        context: context,
        backgroundColor:defaultBlueAccentColor,
        textColor:defaultWhiteColor,
        text: S.of(context).medicalExaminationDetailsButtonText,
        onPress: (){
          if(HomeCubit.get(context).shownButtonSheet){
            HomeCubit.get(context).changeButtonSheet(isShow: false);
          Navigator.pop(context);
          }else {
            scaffoldKey.currentState!.showBottomSheet((context) =>
                medicalExaminationSheet(context: context),
              transitionAnimationController: AnimationController(
                  vsync: this, duration: Duration(seconds: 2)),).closed.then((
                value) async {
              HomeCubit.get(context).changeButtonSheet(isShow: false);
            });
            HomeCubit.get(context).changeButtonSheet(isShow: true);
          }
        },
      ),

      SizedBox(height: screenHeight * 0.0194,),

      ///Medical patient file Button
      defaultMaterialButton(
        height: screenHeight * 0.0583,
        context: context,
        backgroundColor:defaultBlueAccentColor,
        textColor:defaultWhiteColor,
        text: S.of(context).medicalPatientFileButtonText,
        onPress: ()async{
            showDialog(context: context,builder:(context) => defaultCircleProgressBar(),);
            await HomeCubit.get(context).getMedicalProfile().then((value){
              Navigator.pop(context);
              navigateAndPush( context , MedicalPatientDetailsScreen() );
            });
        },
      ),

      SizedBox(height: screenHeight * 0.0194,),

      ///Medical prescription Button
      defaultMaterialButton(
        height: screenHeight * 0.0583,
        context: context,
        backgroundColor:defaultBlueAccentColor,
        textColor:defaultWhiteColor,
        text: S.of(context).medicalPrescriptionButtonText,
        onPress: ()async{
          showDialog(context: context,builder:(context) => defaultCircleProgressBar(),);
          await HomeCubit.get(context).getBookingForUser().then((value){
            Navigator.pop(context);
            navigateAndPush(context, MedicalPrescriptionScreen(model: model,));
          });
        },
      ),

    ],
  );


  ///ui of medical examination button sheet
  ///responsible of viewing The problem that the patient is suffering from
  medicalExaminationSheet({
    required BuildContext context,
  }){
    return Stack(
      children: [
        Container(
          height:screenHeight * 0.4794,
          width:screenWidth*0.9345,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color:defaultWhiteColor,
          ),

          child:Padding(
            padding:  EdgeInsetsDirectional.only(
              top:screenHeight *  0.0323,
              bottom:screenHeight *  0.0269,
              end:screenWidth * 0.0537,
              start:screenWidth *  0.0537,
            ),
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.0313,
                  child: Stack(
                    children: [
                      defaultText(text: S.of(context).medicalExaminationDetailsButtonText,
                          color: defaultGreyColor,
                          height: screenHeight * 0.0313,
                          textAlign: TextAlign.center,
                          fontSize: 22,
                          boxFit: BoxFit.fitHeight,
                          alignment: AlignmentDirectional.center,
                          textHeight: 1.3181,
                          fontFamily: "Roboto",
                          context: context),
                      Align(
                        alignment:AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding:  EdgeInsetsDirectional.only(
                            end: screenWidth * 0.0268,
                          ),
                          child: InkWell(
                            onTap: (){
                              HomeCubit.get(context).changeButtonSheet(isShow: false);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height:screenHeight * 0.0205,
                              width: screenWidth * 0.0443,
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Icon(Icons.close)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.0356),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    color: defaultBlueAccentColor.withOpacity(0.56),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.0490,
                        vertical: screenHeight * 0.0226,
                      ),
                      child: Text(model!.pathologicalDescription!=null?model!.pathologicalDescription!:"    ",
                      style: TextStyle(
                        color: Color(0xff030303),
                        height: 1.318,
                        fontSize: 22,
                        fontFamily: "Roboto",
                      ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}

