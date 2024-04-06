import 'package:Gene/modules/gene_clinics_screen.dart';
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Gene/models/book_information_model.dart';
import 'package:Gene/models/doctors_reservation_model.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/modules/booking_details_screen.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class DoctorDetailsScreen extends StatefulWidget {
  Doctors? doctorModel;
  bool? editable=false;
  int? bookingId;
  late double screenHeight;
  late double screenWidth;

  DoctorDetailsScreen({super.key,this.doctorModel,bool? this.editable,int? this.bookingId});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> with TickerProviderStateMixin{
  String? generalSpecialization;

  /// booking information model
  BookingInformationModel? bookingInformationModel;

  ///animation value
  AnimationController? animation;


  late BuildContext globalContext;

  ///scaffold container that control with scaffold state
  var scaffoldKey=GlobalKey<ScaffoldState>();
  late double screenHeight;
  late double screenWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animation=AnimationController(vsync:this ,duration: Duration(seconds: 2));

  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    HomeCubit.get(context).onChangeDateBooking(date: null,model: null);
    HomeCubit.get(context).changeButtonSheet(isShow: false);
    super.deactivate();
  }



  @override
  Widget build(BuildContext context){
    ///initial value of animation
    ///global context value
    globalContext=context;
    screenHeight=MediaQuery.sizeOf(context).height;
    screenWidth=MediaQuery.sizeOf(context).width;
    generalSpecialization=widget.doctorModel!.speciality ?? S.of(context).nullText;

    return Builder(
      builder: (context) {
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: widget.doctorModel != null,
              builder: (context) {
                return Scaffold(
                  key: scaffoldKey,
                  appBar: statusBar(),
                  body: Stack(
                    children: [
                      ///first background
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

                      SingleChildScrollView(
                        child: Stack(
                          children: [

                            ///first background
                            Positioned(
                              height:MediaQuery.sizeOf(context).height * 0.8218,
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
                            appBarWidget(
                                context: context,
                                height: MediaQuery.sizeOf(context).height * 0.4319,
                                width:MediaQuery.sizeOf(context).width,
                                textHeight:MediaQuery.sizeOf(context).height*0.04319,
                                textWidth:MediaQuery.sizeOf(context).width * 0.74,
                                assetBackgroundImage: "assets/Background/doctor app Bar.png",
                                titleAppBar: "Dr ${widget.doctorModel!.firstName} ${widget.doctorModel!.middleName}"
                            ),

                            ///body
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                bottom: screenHeight * 0.02159,
                                top: screenHeight * 0.08,
                                start: screenWidth * 0.0151,
                                end: screenWidth * 0.0151,
                              ),
                              child: Container(
                                decoration:BoxDecoration(color: Colors.transparent),
                                child: Stack(
                                  children: [

                                    ///body
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.1657
                                      ),
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: defaultWhiteColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            top: screenHeight * 0.07235,
                                            bottom: screenHeight * 0.0259,
                                            start: screenWidth * 0.0373,
                                            end: screenWidth * 0.03971,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [

                                              ///general information container
                                              Container(
                                                width: screenWidth,
                                                height: screenHeight * 0.2591,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [

                                                    ///general information text
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                              context)
                                                          .width,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.03239,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.00215,
                                                              color: Color(
                                                                  0xff707070),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .only(
                                                                start:
                                                                    screenWidth *
                                                                        0.0233,
                                                                end:
                                                                    screenWidth *
                                                                        0.0233,
                                                              ),
                                                              child: FittedBox(
                                                                fit:
                                                                    BoxFit.fill,
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .center,
                                                                child: Text(
                                                                  S.of(context).generalInformationText,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff7E7E7E),
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    height:
                                                                        1.3125,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.00215,
                                                              color: Color(
                                                                  0xff707070),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height:screenHeight * 0.0155,
                                                    ),

                                                    ///doctor name & actions
                                                    Container(
                                                      height: screenHeight *
                                                          0.05507,
                                                      child: Row(
                                                        children: [
                                                          ///doctor ( full name )
                                                          Expanded(
                                                              child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              ///doctor name text
                                                              Expanded(
                                                                child: defaultText(
                                                                    text: S.of(context).doctorNameText,
                                                                    fontSize: 14,
                                                                    fontFamily: "Roboto",
                                                                    boxFit: BoxFit.fitWidth,
                                                                    color: Color(0xff424242),
                                                                    context:
                                                                        context),
                                                              ),
                                                              ///doctor name
                                                              Expanded(
                                                                child: defaultText(
                                                                    text: widget.doctorModel!
                                                                        .fullName!,
                                                                    fontSize:
                                                                        20,
                                                                    fontFamily:
                                                                        "Roboto",
                                                                    boxFit: BoxFit.fitHeight,
                                                                    color: Color(0xff43A6B5),
                                                                    context: context),
                                                              ),
                                                            ],
                                                          )),
                                                          ///buttons (favourite button - clinic screen button)
                                                          Expanded(
                                                              child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Expanded(
                                                                  child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [

                                                                  ///favourite button
                                                                  Container(
                                                                    height: MediaQuery.sizeOf(context).height * 0.0215,
                                                                    width: MediaQuery.sizeOf(context).width * 0.0514,
                                                                    child:
                                                                        IconButton(
                                                                          padding: EdgeInsets.all(0),
                                                                          onPressed: () async{
                                                                                  bool hasInternet=await NetworkConnection.getConnectivity();
                                                                                  if(hasInternet){
                                                                                    showDialog(context: context, builder: (context) =>defaultCircleProgressBar());
                                                                                    if(widget.doctorModel!.favourite==true){
                                                                                      widget.doctorModel!.favourite=false;
                                                                                      ///delete doctor from favourites
                                                                                      await HomeCubit.get(context).deleteFavourite(doctorUserId:widget.doctorModel!.userId!).then((value)async{
                                                                                        Navigator.pop(context);
                                                                                        await showDialog(context: context, builder:(context) =>defaultDialog(context: context,text:S.of(context).doctorDeletedSuccessfully ));
                                                                                      });
                                                                                    }
                                                                                    else{
                                                                                      widget.doctorModel!.favourite=true;
                                                                                      ///add doctor in favourites
                                                                                      await HomeCubit.get(context)
                                                                                          .addFavourite(doctorUserId: widget.doctorModel!.userId!)
                                                                                          .then((value) async {
                                                                                        Navigator.pop(context);
                                                                                        await showDialog(context: context, builder: (context) => defaultDialog(
                                                                                            context: context,
                                                                                            text:
                                                                                            S.of(context).doctorAddedSuccessfully),);
                                                                                      });
                                                                                    }
                                                                                    await HomeCubit.get(context).getClinicsData();
                                                                                  }else{
                                                                                    showSnackBar(context: context, text: S.current.failedConnection);
                                                                                  }
                                                                                },
                                                                          icon: SvgPicture
                                                                              .asset(
                                                                            "assets/svgIcons/favourite.svg",
                                                                            color:
                                                                            widget.doctorModel!.favourite!=true?
                                                                            defaultBlueDarkColor
                                                                                :Color(0xffFE2290),
                                                                            // Color(0xffFE2290),
                                                                          ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                    width: MediaQuery.sizeOf(context).width * 0.0397,
                                                                  ),

                                                                  ///book now button
                                                                  Container(
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.0215,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.0467,
                                                                    child: IconButton(
                                                                      padding: EdgeInsets.all(0),
                                                                      onPressed: () async{
                                                                        bool hasInternet=await NetworkConnection.getConnectivity();
                                                                        if(hasInternet){
                                                                          showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                                          await HomeCubit.get(context).getClinicsData().then((value){
                                                                            navigateAndReplace(context: context,widget:GeneClinicsScreen());
                                                                          });
                                                                        }else{
                                                                          navigateAndPush(context, GeneClinicsScreen());
                                                                          showSnackBar(context: context, text: S.current.failedConnection);
                                                                        }
                                                                      },
                                                                      icon: SvgPicture.asset(
                                                                        "assets/svgIcons/stethoscope-svgrepo-com.svg",
                                                                        color: Color(0xff43A6B5),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              )),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: screenHeight * 0.0148,
                                                    ),

                                                    ///specialization
                                                    Container(
                                                      height: screenHeight *
                                                          0.05291,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///specialization text
                                                          Expanded(
                                                            child: defaultText(
                                                                text:
                                                                    S.of(context).specializationText,
                                                                fontSize: 14,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                fontFamily:
                                                                    "Roboto",
                                                                boxFit: BoxFit
                                                                    .fitWidth,
                                                                color: Color(
                                                                    0xff424242),
                                                                context: context),
                                                          ),
                                                          ///specialization
                                                          Expanded(
                                                            child: defaultText(
                                                                text:generalSpecialization!,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Roboto",
                                                                boxFit:
                                                                    BoxFit.fill,
                                                                color: Color(
                                                                    0xff43A6B5),
                                                                context:
                                                                    context),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: screenHeight * 0.0148,
                                                    ),

                                                    ///years of experience
                                                    Container(
                                                      height: screenHeight * 0.05291,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ///years of experience text
                                                          Expanded(
                                                            child: defaultText(
                                                                text: S.of(context).experienceText,
                                                                fontSize: 14,
                                                                textAlign: TextAlign.start,
                                                                fontFamily: "Roboto",
                                                                boxFit: BoxFit.fitWidth,
                                                                color: defaultGreyColor,
                                                                context: context,
                                                            ),
                                                          ),
                                                          ///years of experience
                                                          Expanded(
                                                            child: defaultText(
                                                                text: "+10 Years exp.",
                                                                fontSize: 18,
                                                                fontFamily: "Roboto",
                                                                boxFit: BoxFit.fill,
                                                                color: defaultBlueDarkColor,
                                                                context: context,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.01,
                                              ),

                                              ///contact info title
                                              Container(
                                                width: MediaQuery.sizeOf(
                                                    context)
                                                    .width,
                                                height: MediaQuery.sizeOf(
                                                    context)
                                                    .height *
                                                    0.03239,
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: MediaQuery
                                                            .sizeOf(
                                                            context)
                                                            .height *
                                                            0.00215,
                                                        color: Color(
                                                            0xff707070),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration:
                                                      BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .only(
                                                          start: screenWidth * 0.0233,
                                                          end: screenWidth * 0.0233,
                                                        ),
                                                        child: FittedBox(
                                                          fit: BoxFit.fill,
                                                          alignment: AlignmentDirectional.center,
                                                          child: Text(S.of(context).contactInfoSupportScreen,
                                                            style:
                                                            TextStyle(
                                                              color: Color(
                                                                  0xff7E7E7E),
                                                              fontFamily:
                                                              "Roboto",
                                                              height:
                                                              1.3125,
                                                              fontSize:
                                                              16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        height: MediaQuery
                                                            .sizeOf(
                                                            context)
                                                            .height *
                                                            0.00215,
                                                        color: Color(
                                                            0xff707070),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.01,
                                              ),

                                              ///chat info buttons (chat us - call us)
                                              Container(
                                                width: screenWidth,
                                                height: screenHeight * 0.0626,
                                                child: Row(
                                                  children: [

                                                    ///chat us button
                                                    Expanded(
                                                      child: defaultMaterialButton(
                                                        height: screenHeight * 0.0626,
                                                        context: context,
                                                        backgroundColor:defaultBlueAccentColor,
                                                        textColor:defaultGreyColor,
                                                        text:  S.of(context).chatUsTextSupportScreen,
                                                        onPress: ()async{
                                                          bool hasInternet=await NetworkConnection.getConnectivity();
                                                          if(hasInternet){

                                                          }else{
                                                            showSnackBar(context: context, text: S.current.failedConnection);
                                                          }
                                                        },
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: MediaQuery.sizeOf(context).width * 0.02,
                                                    ),

                                                    ///call us button
                                                    Expanded(
                                                      child: defaultMaterialButton(
                                                        height: screenHeight * 0.0626,
                                                        context: context,
                                                        backgroundColor:defaultBinkColor,
                                                        textColor:defaultGreyColor,
                                                        text:  S.of(context).callUsTextSupportScreen,
                                                        onPress: ()async{
                                                          bool hasInternet=await NetworkConnection.getConnectivity();
                                                          if(hasInternet){

                                                          }else{
                                                            showSnackBar(context: context, text: S.current.failedConnection);
                                                          }
                                                        },
                                                      ),),

                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.01,
                                              ),

                                              ///container of booking date
                                              Container(
                                                width: screenWidth,
                                                height: screenHeight * 0.4070,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    ///header booking text
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                              context)
                                                          .width,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.03239,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: MediaQuery.sizeOf(context).height * 0.00215,
                                                              color: Color(0xff707070),
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.only(
                                                                start:screenWidth * 0.0233,
                                                                end:screenWidth * 0.0233,
                                                              ),
                                                              child:FittedBox(
                                                                fit:BoxFit.fill,
                                                                alignment:AlignmentDirectional.center,
                                                                child: Text(S.of(context).bookingText,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(0xff7E7E7E),
                                                                    fontFamily:"Roboto",
                                                                    height: 1.3125,
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height:MediaQuery.sizeOf(context).height * 0.00215,
                                                              color:Color(0xff707070),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height:
                                                          screenHeight * 0.0151,
                                                    ),

                                                    ///choose day to book text
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                        start: screenWidth * 0.0385,
                                                      ),
                                                      child: defaultText(
                                                          height: screenHeight * 0.0255,
                                                          text: S.of(context).chooseDayOfBooking,
                                                          color: defaultBlueDarkColor,
                                                          textHeight: 1.357,
                                                          textAlign: TextAlign.start,
                                                          boxFit: BoxFit.fitHeight,
                                                          fontFamily: "Roboto",
                                                          fontSize: 16,
                                                          context: context),
                                                    ),

                                                    SizedBox(
                                                      height: screenHeight * 0.0075,
                                                    ),

                                                    /// date picker
                                                    Container(
                                                      width: screenWidth,
                                                      height: screenHeight * 0.3261,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Color(0xff000000).withAlpha(55),
                                                              blurStyle: BlurStyle.outer,
                                                              blurRadius: 15,
                                                              offset: Offset(0, 0)),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: screenWidth * 0.0350,
                                                          vertical: screenHeight * 0.0194,
                                                        ),
                                                        child: Container(
                                                          child: datePicker(
                                                              context: context),
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
                                    ),

                                    ///image of doctor
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: screenHeight * 0.2224,
                                        width: screenWidth * 0.4813,
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
                                          child: widget.doctorModel!.image !=null?
                                          Image.network(widget.doctorModel!.image!,fit: BoxFit.cover,):
                                          Image.asset("assets/Background/avatar.png",fit: BoxFit.cover),
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

                );
              },
              fallback: (context) => Scaffold(
                body: Stack(
                  children: [

                    /// first background when fixed
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

                    ///second background when fixed
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

                    ///backgrounds
                    SingleChildScrollView(
                      child: Stack(
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

                          ///third background
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
                            top: MediaQuery.sizeOf(context).height *
                                (0.8207 * 2),
                            left: 0,
                          ),

                        ],
                      ),
                    ),

                    ///body
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: screenHeight * (0.1339 - 0.0196),
                        top: screenHeight * 0.1241,
                        start: screenWidth * 0.0327,
                        end: screenWidth * 0.0327,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/Background/background_item_doctors.png"),
                              fit: BoxFit.fill),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: screenHeight * 0.0215,
                            bottom: screenHeight * 0.0551,
                            start: screenWidth * 0.0665,
                            end: screenWidth * 0.0665,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: screenWidth,
                                height: screenHeight,
                              ),
                            ],
                          ),
                        ),
                        // color: Colors.white,
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }



  ///get the list of chip
  List<Widget> listOfChips({
    required BuildContext context,
  }){
    List<ReservationModel> list=[];

    for(int i=0;i<HomeCubit.get(context).reservations.length;i++){
      if(HomeCubit.get(context).dayOfBooking!.compareTo(DateTime.parse(HomeCubit.get(context).reservations[i].date!))==0){
        for (int n = 0; n < HomeCubit.get(context).reservations[i].reservations.length; n++) {
          list.add(HomeCubit.get(context).reservations[i].reservations[n]);
        }
      }
    }
    lengthOfPages=(list.length / _numberOfListOfItems).ceil();
    lenghtOfChips=list.length;

    return orderListOfChips(list: list, context: context);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    animation!.dispose();
    dateTime=null;
    super.dispose();
  }

  int count=1;
  List<Widget> chips=[];
  int? lenghtOfChips;

  ///fun that order list of booking in the day
  List<Widget> orderListOfChips({
    required List<ReservationModel> list,
    required BuildContext context,
    // required int index,
  }){
    count=1;
    list.sort((a,b) => a.id!.compareTo(b.id!));
    chips=[];
      for (int i = 0; i < list.length ; i++) {
        chips.add(
            chipOfBooking(context: context, model: list[i], numberOfItem: count++,
        ));
      }
    return chips;
  }

  ///widget of booking chip
  chipOfBooking({
    required BuildContext context,
    required ReservationModel model,
    required int numberOfItem,
  }) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return !model.isSelected!?
    model.reserved!?
    Container(
      height: screenHeight * 0.0839,
      width: screenWidth * 0.1355,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          ///role of booking
          Container(
            height: screenHeight * 0.0539,
            width: screenWidth * 0.1168,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFE1F8F),
            ),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "$numberOfItem",
                style: TextStyle(
                  fontSize: 31,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  height: 1.290,
                  color: defaultWhiteColor,
                ),
              ),
            ),
          ),

          SizedBox(
            height: screenHeight * 0.0118,
          ),

          ///beginning date of booking
          defaultText(
              textAlign: TextAlign.center,
              height: screenHeight * 0.0280,
              width: screenWidth * 0.1355,
              text: model.startDate.toString(),
              color: Color(0xffFE1F8F),
              // color: defaultBlueDarkColor,
              context: context),

        ],
      ),
    )
    :GestureDetector(
      onTap: () {
        HomeCubit.get(context).onChangeTimeOfReservation(
          selected: true,
          reservationTimeId:model.id!,
        );
        listOfChips(context: context);
      },
      child: Container(
        height: screenHeight * 0.0939,
        width: screenWidth * 0.1355,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ///Role of booking
            Container(
              height: screenHeight * 0.0539,
              width: screenWidth * 0.1168,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: defaultBlueDarkColor,
                boxShadow: [
                ],
              ),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "$numberOfItem",
                  style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    height: 1.290,
                    color: defaultWhiteColor,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: screenHeight * 0.0118,
            ),
            ///beginning date of booking
            defaultText(
                textAlign: TextAlign.center,
                height: screenHeight * 0.0280,
                width: screenWidth * 0.1355,
                text: "${model.startDate}",
                boxFit: BoxFit.fitHeight,
                color: defaultBlueDarkColor,
                context: context),

          ],
        ),
      ),
    )
    :Container(
      height: screenHeight * 0.0939,
      width: screenWidth * 0.1355,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          ///Role of booking
          Container(
            height: screenHeight * 0.0539,
            width: screenWidth * 0.1168,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff19DFFE).withOpacity(0.72),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff008A94).withOpacity(0.72),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.inner,
                ),
                BoxShadow(
                  color: defaultBlackColor.withAlpha(38),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "$numberOfItem",
                style: TextStyle(
                  fontSize: 31,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  height: 1.290,
                  color: defaultWhiteColor,
                ),
              ),
            ),
          ),

          SizedBox(
            height: screenHeight * 0.0118,
          ),

          ///beginning date of booking
          defaultText(
              textAlign: TextAlign.center,
              height: screenHeight * 0.0280,
              width: screenWidth * 0.1355,
              text: model.startDate.toString(),
              color: Color(0xff55DFF4),
              context: context),

        ],
      ),
    );
  }


  DateTime? dateTime;
  ///date picker widget
  datePicker({
    required BuildContext context,
  }) {
    return BlocConsumer<HomeCubit,HomeStates>(
      builder: (context, state) {
      return CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.single,
          selectedDayTextStyle: TextStyle(
            color: defaultWhiteColor,
          ),
          centerAlignModePicker: true,
          selectedDayHighlightColor: Color(0xff1ADFFF),
          disabledDayTextStyle: TextStyle(color: Colors.red),
          currentDate:dateTime??null,
          selectableDayPredicate: (DateTime day) {
            int i=0;
            List date=[];
            for(i;i<HomeCubit.get(context).reservations.length;i++){
              date.add(DateTime.parse(HomeCubit.get(context).reservations[i].date!));
            }
            return date.contains(day);
          },
          firstDate: DateTime.now(),
        ),
        onDisplayedMonthChanged: (day){
          if(mounted){
            setState(() {
              dateTime=day;
            });
          }
          HomeCubit.get(context).onChangeDateBooking(date: day);
        },
        value: [
          dateTime
        ],
        ///on change value of booking
        onValueChanged: (List<DateTime?>? date) async{

          HomeCubit.get(context).onChangeDateBooking(date: date![0]);
          if(mounted){
            setState(() {
              dateTime=date[0]!;
            });
          }
          if(HomeCubit.get(context).shownButtonSheet){
            Navigator.pop(context);
            HomeCubit.get(context).changeButtonSheet(isShow: false);
          }else{
            await showBookingSheet(context: context);
            HomeCubit.get(context).changeButtonSheet(isShow: true);
          }
        },
      );
    }, listener: (context, state) {

    },);
  }

  ///fun that view the button sheet
  showBookingSheet({
    required BuildContext context,
  })async{

    scaffoldKey.currentState!.showBottomSheet((context) => defaultBottomSheet(context: context),transitionAnimationController: animation, enableDrag: true).closed.whenComplete(()async {
          HomeCubit.get(context).changeButtonSheet(isShow: false);
          if(mounted){
            setState(() {
              dateTime=null;
            });
          }
          HomeCubit.get(context).onDisposeTimeOfReservation();
    });
  }

  ///button sheet of booking
  defaultBottomSheet({
    required BuildContext context,
  }){
    double screenHeight=MediaQuery.sizeOf(context).height;
    double screenWidth=MediaQuery.sizeOf(context).width;
    var cubit=HomeCubit.get(context);
    return Builder(
      builder: (context) {
        HomeCubit.get(context).onDisposeTimeOfReservation();
        listOfChips(context: context);
        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {

          },
          builder: (context, state) {

            splitScreens(context);
            return AnimatedContainer(
              height:cubit.reservationModel != null?screenHeight * 0.5:screenHeight * 0.36,
              duration: Duration(milliseconds: 800),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color:defaultWhiteColor,
              ),
              child:Padding(
                padding:  EdgeInsetsDirectional.only(
                  top:screenHeight *  0.0302375809935205,
                  bottom:screenHeight *  0.01835,
                  end:screenWidth * 0.02336,
                  start:screenWidth *  0.02336,
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [

                      ///header of buuton sheet
                      Container(
                        height: screenHeight * 0.0313,
                        child: Stack(
                          children: [

                            ///title of button sheet
                            defaultText(
                                text: S.of(context).titleButtonSheetBookingRole,
                                color: defaultGreyColor,
                                height: screenHeight * 0.0313,
                                textAlign: TextAlign.center,
                                fontSize: 22,
                                alignment: AlignmentDirectional.center,
                                textHeight: 1.3181,
                                fontFamily: "Roboto",
                                context: context,
                            ),

                            ///close button
                            Align(
                              alignment:AlignmentDirectional.centerEnd,
                              child: Padding(
                                padding:  EdgeInsetsDirectional.only(
                                  end: screenWidth * 0.04672,
                                ),
                                child: InkWell(
                                  onTap: (){
                                    HomeCubit.get(context).changeButtonSheet(isShow: false);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height:screenHeight * 0.0183,
                                    width: screenWidth * 0.0397,
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

                      SizedBox(height: screenHeight * 0.02807),

                      ///page that contains list of booking
                      Column(
                          children: [
                            SizedBox(
                              height:screenHeight * 0.0161,
                            ),

                            ///pages of booking
                            Container(
                              width: screenWidth,
                              height:
                              screenHeight * 0.2289,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: defaultBlackColor.withAlpha(40),
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 15,
                                      offset:
                                      Offset(0, 0)),
                                ],
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.0327,
                                    vertical: screenHeight * 0.0151,
                                  ),
                                  child:PageView.builder(
                                    reverse: false,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (index){
                                      _i=HomeCubit.get(context).selectedFavouritePageNumber - 1;
                                    },
                                    itemBuilder:(context, index){
                                      return screens[index];
                                    },
                                    itemCount: screens.length,
                                  ),
                              ),
                            )
                          ],
                        ),

                      ///book now button
                      if (cubit.reservationModel != null || cubit.shownButtonSheet==false)
                        Column(
                          children: [

                            SizedBox(
                              height: screenHeight * 0.0161,
                            ),

                            Container(
                              width: screenWidth,
                              height:
                              screenHeight * 0.1209,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: defaultBlackColor.withAlpha(40),
                                      blurStyle:
                                      BlurStyle.outer,
                                      blurRadius: 15,
                                      offset:
                                      Offset(0, 0)),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                  screenWidth *
                                      0.1588,
                                  vertical: screenHeight *
                                      0.0226,
                                ),
                                child: widget.editable==true?
                                ///edit booking button
                                defaultMaterialButton(
                                    height: MediaQuery.sizeOf(context).height * 0.076,
                                    context: context,
                                    backgroundColor: defaultBlueAccentColor,
                                    textColor: defaultWhiteColor,
                                    text: S.of(context).edit_booking_button_text,
                                    svgassetImage: "assets/svgIcons/stethoscope-svgrepo-com.svg",
                                    onPress:(){
                                      showDialog(
                                        context: context,
                                        builder: (context) => dialog(
                                            image: languageApp!="ar"?
                                            dialogImageOfEditBookingConfirmationEN:
                                            dialogImageOfEditBookingConfirmationAR,
                                            context: context,
                                            heightContainer: screenHeight * 0.6144 ,
                                            child: confirmDialog(context: context)),
                                      );
                                    }
                                    ):
                                ///book now button
                                defaultMaterialButton(
                                  height: MediaQuery.sizeOf(context).height * 0.076,
                                  context: context,
                                  backgroundColor: defaultBlueAccentColor,
                                  textColor: defaultWhiteColor,
                                  text: S.of(context).book_now_button_text,
                                  svgassetImage: "assets/svgIcons/stethoscope-svgrepo-com.svg",
                                  onPress:() {
                                    showDialog(
                                        context: context,
                                        builder: (context) => dialog(
                                            image: languageApp!="ar"?
                                            dialogImageOfBookingNowConfirmationEN:
                                            dialogImageOfBookingNowConfirmationAR,
                                            context: context,
                                            heightContainer: screenHeight * 0.6144 ,
                                            child:confirmDialog(context: context))
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }


  ///dialog that ensure if user want to confirm process or not
   confirmDialog({
    required BuildContext context,
    }) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [

        SizedBox(
          height: screenHeight * 0.0356,
        ),

        ///text
        Container(
          height: screenHeight * 0.0626,
          child: defaultText(
                width: screenWidth,
                text: S.of(context).confirm_date_of_booking_text,
                fontSize: 22,
                textHeight: 1.3181,
                alignment: AlignmentDirectional.center,
                textAlign: TextAlign.center,
                boxFit: BoxFit.fitHeight,
                color: defaultGreyColor,
                context: context),
        ),

        SizedBox(
          height: screenHeight * 0.0302,
        ),
        ///row that contains on ()
        Container(
          height: screenHeight * 0.0626,
          child: Row(
            children: [

              ///yes button
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: defaultBlueAccentColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: MaterialButton(
                    onPressed: () async{
                    if(userTokenApi!=null) {
                      await showDialog(context: context, builder: (context) {
                          return  dialog(
                              image: languageApp!="ar"?
                              dialogImageOfPaymentStateConfirmationEN:
                              dialogImageOfPaymentStateConfirmationAR,
                              context: context,
                              heightContainer: screenHeight * 0.652,
                              child: paymentWayDialog(context: context));
                      });
                    } else{
                      navigateAndPush(context,SignInScreen(fromUser: true,widget: DoctorDetailsScreen(doctorModel: widget.doctorModel),));
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

              ///no button
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

  ///dialog that predicate payment state (cash - credit)
   paymentWayDialog({
   required BuildContext context,
    }){
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.0356,
        ),
        ///text
        Container(
          height: screenHeight * 0.0313,
          width: screenWidth * 0.5747,
          child: defaultText(
              width: screenWidth,
              text: S.of(context).choose_payment_text,
              fontSize: 22,
              textHeight: 1.3181,
              alignment: AlignmentDirectional.center,
              textAlign: TextAlign.center,
              boxFit: BoxFit.fitHeight,
              color: defaultGreyColor,
              context: context),
        ),

        SizedBox(
          height: screenHeight * 0.0377,
        ),
        ///credit card button
        Container(
          height:screenHeight * 0.0626,
          decoration: BoxDecoration(
            color: defaultBlueAccentColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: MaterialButton(
            onPressed: () async{
              bool hasInternet=await NetworkConnection.getConnectivity();
              if(hasInternet){

              }else{
                showSnackBar(context: context, text: S.current.failedConnection);
              }
              // navigateAndPush(context,PaymentScreen());
            },
            child: Center(
              child: Text(
                S.of(context).credit_card_button_text,
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

        SizedBox(
          height: screenHeight * 0.0183,
        ),
        ///cash button
        Container(
          height:screenHeight * 0.0626,
          decoration: BoxDecoration(
            color: Color(0xffFE3398),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: MaterialButton(
            onPressed: () async{
              bool hasInternet=await NetworkConnection.getConnectivity();
              if(hasInternet){
                showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                if(widget.editable ==true){
                  HomeCubit.get(context).updateBookingForUser(bookingId: widget.bookingId!, anotherReservationTimeId: HomeCubit.get(context).reservationModel!.id!).then((value)async{
                    await HomeCubit.get(context).getBookingForUser().then((value) {
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      navigateAndPush(context,BookingDetailsScreen(doctorUserId: widget.doctorModel!.userId.toString(),reservationId:HomeCubit.get(context).reservationModel!.id,));
                    });
                  });
                }
                else{
                  await HomeCubit.get(context).postBookingForDoctor(doctorId: int.parse(widget.doctorModel!.clinicUserId!),
                      reservationTimeId: HomeCubit.get(context).reservationModel!.id!,
                      clinicsUsersId:widget.doctorModel!.clinicUserId!).then((value)async{
                    await HomeCubit.get(context).getBookingForUser().then((value){
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      Navigator.pop(globalContext);
                      navigateAndPush(context,BookingDetailsScreen(doctorUserId: widget.doctorModel!.userId.toString(),reservationId:HomeCubit.get(context).reservationModel!.id,));
                    });
                  });
                }
              }
              else{
                Navigator.pop(context);
                Navigator.pop(context);
                showSnackBar(context: context, text: S.current.failedConnection);
              }
            },
            child: Center(
              child: Text(
                S.of(context).cash_button_text,
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
    );

  }

  ///number of item in page
  final int _numberOfListOfItems=10;

  ///initial variable of for loop
  int _i = 0;

  ///length of page view
  int? lengthOfPages;

  ///list of screens in page
  List<Widget> screens = [];


  ///fun that split number of booking in page
  ///every page contains 10 dates of booking
  splitScreens(BuildContext context) {
    screens=[];
    _i = 0;
    List<Widget> lists;
    for (_i;_i < lengthOfPages!;_i++) {
      ///the index of item that page first with
      int firstIndex= _i*_numberOfListOfItems;
      ///the index of item that page ends with
      int counterOfChip=(lenghtOfChips! - ((_i) * _numberOfListOfItems)) > _numberOfListOfItems || (lenghtOfChips! - ((_i) * _numberOfListOfItems)) == _numberOfListOfItems
    ? ((_i*_numberOfListOfItems)+_numberOfListOfItems)
        : lenghtOfChips!;
      ///length of booking in day
      lists =chips.sublist(firstIndex,counterOfChip);

      screens.add(
          Container(
            height: MediaQuery.sizeOf(context).height * 0.8693,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection:Axis.vertical,
              crossAxisSpacing:screenHeight * 0.0103,
              childAspectRatio:( screenWidth * 0.1355)/(screenHeight * 0.087) ,
              mainAxisSpacing: screenWidth * 0.015,
              semanticChildCount: 10,
              shrinkWrap: true,
              children: lists,
              crossAxisCount: 5,
            ),
            ),
      );
    }
  }

}
