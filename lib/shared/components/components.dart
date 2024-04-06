
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/library/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:Gene/library/rating_bar/rating.dart';
import 'package:Gene/models/Country%20Model/country_model.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/models/rating_model.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/modules/sup_categories_screen.dart';
import 'package:Gene/modules/doctor_details_screen.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/modules/gene_clinics_screen.dart';
import 'package:Gene/modules/setting_screen.dart';
import 'package:Gene/modules/sup_doctors.dart';
import 'package:Gene/modules/wallet_screen.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';


///asset small images of carousel slider in home screen english
List smallMedicalImageEN = [
  "assets/Background/images3.jpg",
  "assets/Background/slider1 (1).png",
  "assets/Background/slider2.png",
  "assets/Background/images4.jpg",
  "assets/Background/images5.jpg",
];

///asset small images of carousel slider in home screen arabic
List smallMedicalImageAR = [
  "assets/Background/images3.jpg",
  "assets/Background/slider1 (1).png",
  "assets/Background/slider2.png",
  "assets/Background/images4.jpg",
  "assets/Background/images5.jpg",
];

///asset big images of carousel slider in home screen english
List bigMedicalImageEN = [
  "assets/Background/images3.jpg",
  "assets/Background/slider1 (1).png",
  "assets/Background/slider2.png",
  "assets/Background/images4.jpg",
  "assets/Background/images5.jpg",
];

///asset big images of carousel slider in home screen arabic
List bigMedicalImageAR = [
  "assets/Background/images3.jpg",
  "assets/Background/slider1 (1).png",
  "assets/Background/slider2.png",
  "assets/Background/images4.jpg",
  "assets/Background/images5.jpg",
];

/// List Of Screens in navigation appBar
List<Widget> screens = [
  HomeScreen(),
  GeneClinicsScreen(),
  if (userTokenApi != null)
    WalletScreen()
  else
    SignInScreen(),
  SettingScreen(),
];

///navigate screen and push it in stack
navigateAndPush(BuildContext context, Widget screen) {
  return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen,)
  );
}

///navigate screen start it in stack and clear all screens from stack
navigateAndFinish(BuildContext context, Widget screen) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen,),
    (route) => false,
  );
}

///navigate screen and replace it with last screen in stack
navigateAndReplace({
  required BuildContext context,
  required Widget widget,
}){
  return Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => widget,));
}

///default material button of App
defaultMaterialButton({
  required double? height,
  required BuildContext context,
  required Color backgroundColor,
  required Color textColor,
  required String text,
  String? assetImageIcon,
  String? svgassetImage,
  required Function() onPress,
}) => Container(
      height: height ?? null,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (assetImageIcon != null)
              Row(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.044,
                    width: MediaQuery.sizeOf(context).width * 0.0957,
                    child: Image.asset(
                      assetImageIcon,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.0467,
                  ),
                ],
              ),
            if (svgassetImage != null)
              Row(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.044,
                    width: MediaQuery.sizeOf(context).width * 0.0957,
                    child: SvgPicture.asset(
                      svgassetImage,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.0467,
                  ),
                ],
              ),

            defaultText(
                text: text,
                color: textColor,
                height: MediaQuery.sizeOf(context).height * 0.0313,
                fontFamily: "Roboto",
                boxFit: BoxFit.fitHeight,
                textAlign: TextAlign.center,
                textHeight: 1.318,
                fontSize: 22,
                context: context),
          ],
        ),
      ),
    );

///default text field of app
defaultTextFormField({
  double? height,
  double? width,
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType keyboardType,
  String? Function(String?)? onValidate,
  Widget? prefixWidget,
  Function()? onTap,
  Function(String?)? onChange,
  String? suffixIconSvg,
  String? hint,
  String? lable,
  bool? isPassword,
  bool? isEnable,
  int? maxLength,
  bool isExpanded = false,
  GlobalKey<ScaffoldState>? scaffoldKey,
  VoidCallback? onSuffixIcon,
  Function()? onPrefixIcon,
}) => Container(
      height: height ?? MediaQuery.sizeOf(context).height * 0.072,
      width: width ?? MediaQuery.sizeOf(context).width,
      child: TextFormField(
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        keyboardType: keyboardType,
        expands: isExpanded ? isExpanded : false,
        validator: onValidate,
        obscureText: isPassword??false,
        autofocus: false,
        enabled: isEnable,
        onTap: onTap,
        maxLines: isExpanded ? null : 1,
        buildCounter: null,
        onChanged: onChange,
        maxLength: maxLength,
        style: TextStyle(
          color: Color(0xff656565),
          fontSize: 20,
          fontFamily: "Roboto",
          height: 1.3,
        ),

        decoration: InputDecoration(
          hintText: hint,
          counter: Container(
            height: 0,
            width: 0,
          ),

          label: lable != null ? Center(child: Text(lable)) : null,

          labelStyle: TextStyle(
            color: Color(0xff656565).withOpacity(0.45),
            fontSize: 20,
            fontFamily: "Roboto",
            height: 1.3,
          ),
          hintStyle: TextStyle(
            color: Color(0xff656565).withOpacity(0.45),
            fontSize: 20,
            fontFamily: "Roboto",
            height: 1.3,
          ),
          
          prefixIcon: prefixWidget != null
              ? Container(
            height: height != null ? height : MediaQuery.sizeOf(context).height * 0.07,
            clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(15),
                    bottomStart: Radius.circular(15),
                  )
                ),
                child: MaterialButton(
                    onPressed: onPrefixIcon,
                    padding: EdgeInsets.all(0),
                    child: prefixWidget),
              )
              : null,

          suffixIcon: suffixIconSvg != null
              ? IconButton(
                  onPressed: onSuffixIcon,
                  padding: EdgeInsetsDirectional.only(
                    end: MediaQuery.sizeOf(context).width * 0.0257,
                  ),
                  icon: Image.asset(
                    suffixIconSvg,
                    height: MediaQuery.sizeOf(context).height * 0.03995,
                    width: MediaQuery.sizeOf(context).width * 0.0864,
                    // colorBlendMode: BlendMode.darken,
                    color: defaultBlackColor.withOpacity(0.40),
                  ))
              : null,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultBlueDarkColor,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultBlueDarkColor,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),

          errorStyle: TextStyle(
            height: 0.1,
            fontSize: 15,
            fontFamily: "Roboto",
          ),

          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultBlueDarkColor,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),

          contentPadding: EdgeInsetsDirectional.only(
            top: 20,
            bottom: 0,
            start: 10,
          ),

        ),
      ),
    );


/// prefix widget of Country in ( sign up screen & register screen )
Widget countryPrefixIconOfTextField({
  required BuildContext context,
  required CountryModel country,
}) {
  return Padding(
    padding: EdgeInsetsDirectional.only(
      start: MediaQuery.sizeOf(context).width * 0.0443,
    ),
    child: Container(
      alignment: AlignmentDirectional.center,
      height: MediaQuery.sizeOf(context).height * 0.0259,
      width: MediaQuery.sizeOf(context).width * (0.2),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(15),
          topStart: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.0259,
            width: MediaQuery.sizeOf(context).width * 0.08411,
            child: FittedBox(
              fit: BoxFit.cover,
              child: country.emojiText(country),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.02,
          ),
          defaultText(
              text: "+${country.phoneCode}",
              boxFit: BoxFit.fitHeight,
              color: defaultGreyColor,
              context: context,
              fontSize: 20,
              fontFamily: "Roboto",
              textHeight: 1.3,
          ),
        ],
      ),
    ),
  );
}

///default text with special text style with fitted Box
Widget defaultText({
  double? height,
  double? width,
  required String text,
  String? fontFamily,
  required Color color,
  double? fontSize,
  double? textHeight,
  FontWeight fontWeight=FontWeight.normal,
  required BuildContext context,
  BoxFit? boxFit,
  AlignmentDirectional? alignment,
  TextAlign? textAlign,
}) => Container(
      alignment: alignment ?? AlignmentDirectional.centerStart,
      height: height ?? MediaQuery.sizeOf(context).height * 0.03131,
      width: width,
      child: FittedBox(
        fit: boxFit ?? BoxFit.contain,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          // maxLines: 3,
          textAlign: textAlign ?? TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? "Roboto",
            fontSize: fontSize ?? 22,
            height: textHeight ?? 1.318,
          ),
        ),
      ),
    );

///default text with special text style without fitted Box
defaultTextWithoutFittedBox({
  double? height,
  double? width,
  required String text,
  String? fontFamily,
  required Color color,
  double? fontSize,
  double? textHeight,
  required BuildContext context,
  BoxFit? boxFit,
  AlignmentDirectional? alignment,
  TextAlign? textAlign,
  int? maxLine,
}) => Container(
      alignment: alignment ?? AlignmentDirectional.centerStart,
      height: height ?? MediaQuery.sizeOf(context).height * 0.03131,
      width: width,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLine??1,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
          color: color,
           fontWeight: FontWeight.bold,
          fontFamily: fontFamily ?? "Roboto",
          fontSize: fontSize ?? 22,
          height: textHeight ?? 1.318,
        ),
      ),
    );

///get clinic model from list of clinics after update it
ClinicsModel getClinicModel({
  required BuildContext context,
  required int id,
}){
  late ClinicsModel clinicsModel;
  for(int i=0;i<HomeCubit.get(context).clinics.length;i++){
    if(HomeCubit.get(context).clinics[i].id == id){
      clinicsModel=HomeCubit.get(context).clinics[i];
    }
  }
  return clinicsModel;
}


/// widget of clinic container
Widget itemOfClinics({
  required BuildContext context,
  ClinicsModel? model,
}) => InkWell(
      onTap: () async{
        bool hasInternet=await NetworkConnection.getConnectivity();
        if(hasInternet){
          showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
          await HomeCubit.get(context).getClinicsData().then((value){
            ClinicsModel clinicsModel=getClinicModel(context: context, id: model.id!);
            if (model.supCategory!.length == 0) {
              navigateAndReplace(context: context,widget:  SupDoctor(model: clinicsModel,));
            } else {
              navigateAndReplace(context: context,widget:  SupCategoriesScreen(model: clinicsModel));
            }
          });
        }else{
          if (model.supCategory!.length == 0) {
            navigateAndPush(context,SupDoctor(model: model,));
          } else {
            navigateAndPush(context,SupDoctor(model: model,));
          }
          showSnackBar(context: context, text: S.current.failedConnection);
        }

      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.2593,
        height: MediaQuery.sizeOf(context).height * 0.1495,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.2593,
              height: MediaQuery.sizeOf(context).height * 0.1198,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(radiusItemImage)),
                border: Border.all(
                    color: Color(0xffFB5AAB),
                    width: 1,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside),
              ),
              child: model!.image != null
                  ? Image(
                      image: NetworkImage(
                        "https://clinic.megavisionagency.com/public/${model.image!}",
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            if (model.name != null)
              defaultTextWithoutFittedBox(
                  text: model.name!,
                  color: defaultGreyColor,
                  height: MediaQuery.sizeOf(context).height * 0.0275,
                  alignment: AlignmentDirectional.bottomCenter,
                  textAlign: TextAlign.center,
                  fontSize: 10,
                  maxLine: 1,
                  boxFit: BoxFit.fitHeight,
                  fontFamily: "Arial",
                  textHeight: 1.16,
                  context: context),
          ],
        ),
      ),
    );

/// widget of sup clinic container
Widget itemSupClinic({
  required BuildContext context,
  SupCategories? model,
  List<Doctors>? doctors,
  required ClinicsModel clinicModel,
}) => InkWell(
      onTap: () {
        navigateAndPush(context, SupDoctor(model: clinicModel));
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.2593,
        height: MediaQuery.sizeOf(context).height * 0.1495,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.2593,
              height: MediaQuery.sizeOf(context).height * 0.1198,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(radiusItemImage)),
                border: Border.all(
                    color: Color(0xffFB5AAB),
                    width: 1,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside),
              ),
              child: model!.image != null
                  ? Image(
                      image: NetworkImage(
                        "https://clinic.megavisionagency.com/public/${model.image!}",
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            if (model.name != null)
              defaultTextWithoutFittedBox(
                  text: model.name!,
                  color: defaultGreyColor,
                  height: MediaQuery.sizeOf(context).height * 0.0280,
                  alignment: AlignmentDirectional.bottomCenter,
                  textAlign: TextAlign.center,
                  fontSize: 10,
                  maxLine: 1,
                  boxFit: BoxFit.contain,
                  fontFamily: "Arial",
                  textHeight: 1.16,
                  context: context),
          ],
        ),
      ),
    );

/// widget of doctor container
Widget itemOfDoctors({
  required int index,
  required BuildContext context,
  required Doctors model,
  required Widget widgetScreen
}) {
  // Doctors model=HomeCubit.get(context).allDoctors[index];
  String speciality =model.speciality!=null?model.speciality!:"    ";
  bool userIsBookingInDoctor=checkIfUserIsBooking(context: context,model: model);
  return Container(
    height: MediaQuery.sizeOf(context).height * 0.2861,
    width: MediaQuery.sizeOf(context).width * 0.3808,
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    child: Stack(
      children: [

        ///bottom container of doctor
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height * 0.0896,
          ),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.196,
            width: MediaQuery.sizeOf(context).width * 0.380,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: defaultBlackColor.withAlpha(30),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.outer,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: defaultWhiteColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.1101),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///speciality of doctor
                        Expanded(
                            child:defaultTextWithoutFittedBox(
                              text: speciality,
                              color: defaultBlueDarkColor.withOpacity(0.85),
                              context: context,
                              maxLine: 1,
                              textAlign: TextAlign.center,
                              boxFit: BoxFit.fitHeight,
                              alignment: AlignmentDirectional.center,
                              height: MediaQuery.sizeOf(context).height * 0.0172,
                              fontFamily: "Roboto",
                              fontSize: 9,
                              textHeight: 1.33,
                            ),
                        ),
                        ///years of experience
                        Expanded(
                          child:defaultText(
                            text: "+5 years",
                            color: defaultBlueDarkColor.withOpacity(0.85),
                            context: context,
                            textAlign: TextAlign.center,
                            alignment: AlignmentDirectional.center,
                            height: MediaQuery.sizeOf(context).height * 0.0172,
                            fontFamily: "Roboto",
                            fontSize: 12,
                            textHeight: 1.33,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.0064,
                  ),
                  ///price of booking for doctor
                  if (model.price != null)
                    defaultText(
                      // width: MediaQuery.sizeOf(context).width * 0.182,
                      text:("${S.of(context).detectionPriceText} " + model.price!),
                      color: defaultBlueDarkColor.withOpacity(0.85),
                      context: context,
                      // textAlign: TextAlign.center,
                      alignment: AlignmentDirectional.center,
                      height: MediaQuery.sizeOf(context).height * 0.0172,
                      fontFamily: "Roboto",
                      fontSize: 12,
                      textHeight: 1.33,
                    ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.0161,
                  ),
                  ///actions
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.0215,
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///favourite button
                        Expanded(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.0215,
                            child: InkWell(
                              onTap: () async{
                                bool hasInternet=await NetworkConnection.getConnectivity();
                                if(userTokenApi != null){
                                  if(hasInternet){
                                    showDialog(context: context,builder:(context) =>defaultCircleProgressBar());
                                    if(model.favourite==true){
                                      model.favourite=false;
                                      await HomeCubit.get(context).deleteFavourite(doctorUserId:model.userId!).then((value)async{
                                        Navigator.pop(context);
                                        await showDialog(context: context, builder:(context) =>defaultDialog(context: context,text:S.of(context).doctorDeletedSuccessfully ));
                                      });
                                    }
                                    else{
                                      model.favourite=true;
                                      await HomeCubit.get(context)
                                          .addFavourite(doctorUserId: model.userId!)
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
                                }else{
                                  showDialog(context: context, builder:(context) => defaultDialog(context: context, text: S.of(context).mustSignIn,text2: S.of(context).thanksText,nextWidget: () {
                                    navigateAndPush(context, SignInScreen());
                                  },),);
                                }
                              },
                              child: SvgPicture.asset(
                                fit: BoxFit.contain,
                                "assets/svgIcons/favourite_disabled.svg",
                                color:
                                model.favourite!=true?
                                defaultBlueDarkColor
                                    :Color(0xffFE2290),
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ),
                        ),
                        ///book now button
                        Expanded(
                          child: InkWell(
                            onTap: () async{
                              bool hasInternet=await NetworkConnection.getConnectivity();
                              if(hasInternet){
                                showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                await HomeCubit.get(context).getDoctorsReservation(clinicsUsersId: int.parse(model.clinicUserId.toString())).then((value) {
                                  navigateAndReplace(context: context, widget: DoctorDetailsScreen(doctorModel: model,),);
                                });
                              }else{
                                showSnackBar(context: context, text: S.current.failedConnection);
                              }
                            },
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.0215,
                              child: SvgPicture.asset(
                                fit: BoxFit.contain,
                                "assets/svgIcons/stethoscope-svgrepo-com.svg",
                                color: defaultBlueDarkColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.007,
                  ),
                ],
              ),
            ),
          ),
        ),

        ///top container of doctor
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.3037,
            height: MediaQuery.sizeOf(context).height * 0.1922,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.0248),
                  child: Column(
                    children: [
                      ///image of doctor
                      InkWell(
                        onTap: () async{
                          bool hasInternet=await NetworkConnection.getConnectivity();
                          if(hasInternet){
                            showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                            await HomeCubit.get(context).getDoctorsReservation(clinicsUsersId: int.parse(model.clinicUserId.toString())).then((value) {
                              navigateAndReplace(context: context, widget: DoctorDetailsScreen(doctorModel: model,),);
                            });
                          }else{
                            showSnackBar(context: context, text: S.current.failedConnection);
                          }


                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.sizeOf(context).width * 0.2943,
                          height: MediaQuery.sizeOf(context).height * 0.1360,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(model.image!),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.0086,
                      ),
                      ///full name of doctor
                      InkWell(
                        onTap: () async{
                          bool hasInternet=await NetworkConnection.getConnectivity();
                          if(hasInternet){
                            showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                            await HomeCubit.get(context).getDoctorsReservation(clinicsUsersId: int.parse(model.clinicUserId.toString())).then((value) {
                              navigateAndReplace(context: context, widget: DoctorDetailsScreen(doctorModel: model,),);
                            });
                          }else{
                            showSnackBar(context: context, text: S.current.failedConnection);
                          }
                        },
                        child: defaultTextWithoutFittedBox(
                            text: model.fullName!,
                            boxFit: BoxFit.fitHeight,
                            textAlign: TextAlign.center,
                            color: defaultBlueDarkColor,
                            maxLine: 1,
                            height: MediaQuery.sizeOf(context).height * 0.0226,
                            textHeight: 1.3125,
                            fontFamily: "Roboto",
                            fontSize: 14,
                            context: context),
                      ),
                    ],
                  ),
                ),
                ///rating of doctor
                Align(
                  alignment: Alignment.topCenter,
                  child: Directionality(
                    textDirection:languageApp=="ar"?TextDirection.ltr:TextDirection.ltr ,
                    child: RatingBarLocal(
                        glowRadius: 6,
                        glow: true,
                        glowColor: Color(0xffFFFF00),
                        ratingWidget: RatingWidgetLocal(
                            full: Container(
                              height: MediaQuery.sizeOf(context).height * 0.0186,
                              width: MediaQuery.sizeOf(context).width * 0.0420,
                              child: FittedBox(
                                // fit: BoxFit.cover,
                                child: Image.asset(
                                  "assets/svgIcons/full.png",
                                  fit: BoxFit.cover,
                                  color: Color(0xffFFD700),
                                ),
                              ),
                            ),
                            half: Container(
                              height: MediaQuery.sizeOf(context).height * 0.0186,
                              width: MediaQuery.sizeOf(context).width * 0.0420,
                              child: FittedBox(
                                // fit: BoxFit.cover,
                                child: Image.asset(
                                  "assets/svgIcons/half.png",
                                  color: Color(0xffFFD700),
                                ),
                              ),
                            ),
                            empty: Container(
                              child: Image.asset(
                                "assets/svgIcons/star.png",
                                color: defaultBlueDarkColor,
                              ),
                            )),
                        itemCount: 5,
                        unratedColor: Colors.grey[300],
                        initialRating: double.parse(
                            HomeCubit.get(context).allDoctors[index].rating.toString()
                        ),
                        allowHalfRating: true,
                        isWrap:false,
                        updateOnDrag: true,
                        onRatingEnd: (value) async{

                          if(userTokenApi!=null){
                            RatingModel? ratingModel = getRatingOfDoctor(context: context, userIdOfDoctor: model.userId!);
                            showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                            await HomeCubit.get(context).getBookingForUser().then((value){
                              Navigator.pop(context);
                            });
                            userIsBookingInDoctor=checkIfUserIsBooking(context: context,model: model);

                            if(ratingModel!=null){
                              showDialog(context: context, builder:(context) => defaultDialog(context: context, text: S.of(context).ratingAfterAdded,text2: S.of(context).thanksText,
                                nextWidget: () async{
                                    Navigator.pop(context);
                                    navigateAndReplace(context: context, widget: widgetScreen);
                                },
                                haveCloseButton:false
                              ));
                            }
                            else{
                              if(userIsBookingInDoctor){
                                HomeCubit.get(context).onChangeRatingDoctor(rate: value);
                                showDialog(context: context, builder: (context) => dialogOfRating(context: context,rate: value,userId: model.userId!,widgetScreen: widgetScreen));
                              }
                              else{
                                showDialog(context:context, builder:(context) => defaultDialog(context: context,
                                    text: S.of(context).bookWithDoctor,
                                    text2:S.of(context).thanksText,
                                    nextWidget: () async{
                                        Navigator.pop(context);
                                        navigateAndReplace(context: context, widget: widgetScreen);
                                    },
                                    haveCloseButton: false,
                                ));
                              }
                            }

                          }
                          else{
                            await showDialog(context: context, builder:(context) => defaultDialog(context: context, text: S.of(context).mustSignIn,text2:S.of(context).thanksText,
                              nextWidget: () async{
                                  Navigator.pop(context);
                                  navigateAndReplace(context: context, widget: widgetScreen);
                                  navigateAndPush(context, SignInScreen());
                              },
                              closeFun: () {
                                Navigator.pop(context);
                                navigateAndReplace(context: context, widget: widgetScreen);
                              },
                            ));
                          }
                        },
                        onRatingUpdate: (value) async{

                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// get boolean value
/// check if user book for doctor before or not
bool checkIfUserIsBooking({
  Doctors? model,
  BuildContext? context,
}){
  bool value=false;
  for(int i=0;i<HomeCubit.get(context).bookingUserInformation.length;i++){
    if(HomeCubit.get(context).bookingUserInformation[i].doctor!.id==model!.userId){
      value=true;
    }
  }
  return value;
}


///dialog that show for user when user want to rate doctor
Widget dialogOfRating({
  required BuildContext context,
  required double rate,
  required int userId,
  required Widget widgetScreen,
}){
  var formKey=GlobalKey<FormState>();
  // RatingModel? ratingModel = getRatingOfDoctor(context: context, userIdOfDoctor: userId);
  TextEditingController commentRatingController = TextEditingController();
  return Dialog(
    elevation: 0,
    insetPadding: EdgeInsets.symmetric(
      horizontal: 10,
    ),
    backgroundColor: Colors.transparent,
    child: Padding(
      padding:  EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.16,
        bottom: MediaQuery.sizeOf(context).height * 0.16,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height * 0.4),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:defaultBlackColor.withAlpha(30),
                blurRadius: 15,
                blurStyle: BlurStyle.outer,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      defaultTextWithoutFittedBox(
                          text: S.of(context).titleOfRatingDialog,
                          maxLine: 2,
                          color: Color(0xff434343),
                          fontSize: 26,
                          fontFamily: "Roboto",
                          textAlign: TextAlign.center,
                          textHeight: 1.333,
                          alignment: AlignmentDirectional.center,
                          boxFit: BoxFit.fitHeight,
                          height:MediaQuery.sizeOf(context).height * 0.1,
                          context: context),
                      SizedBox(
                        height: MediaQuery.sizeOf(context)
                            .height *
                            0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar(
                            glowRadius: 6,
                            glow: true,
                            glowColor: Color(0xffFFFF00),
                            ratingWidget: RatingWidget(
                                full: Container(
                                  height: MediaQuery.sizeOf(context).height * 0.0186,
                                  width: MediaQuery.sizeOf(context).width * 0.0420,
                                  child: Image.asset(
                                    "assets/svgIcons/full.png",
                                    fit: BoxFit.cover,
                                    color: Color(0xffFFD700),
                                  ),
                                ),
                                half: Container(
                                  height: MediaQuery.sizeOf(context).height * 0.0186,
                                  width: MediaQuery.sizeOf(context).width * 0.0420,
                                  child: Image.asset(
                                    "assets/svgIcons/half.png",
                                    color: Color(0xffFFD700),
                                    fit: BoxFit.cover,

                                  ),
                                ),
                                empty: Container(
                                  height: MediaQuery.sizeOf(context).height * 0.0186,
                                  width: MediaQuery.sizeOf(context).width * 0.0420,
                                  child: Image.asset(
                                    "assets/svgIcons/star.png",
                                    color: defaultBlueDarkColor,
                                    fit: BoxFit.cover,

                                  ),
                                )),
                            itemCount: 5,
                            tapOnlyMode: false,
                            unratedColor: Colors.grey[300],
                            itemSize: 30,
                            initialRating: HomeCubit.get(context).ratingValue,
                            allowHalfRating: true,
                            onRatingUpdate: (value) {
                              HomeCubit.get(context).onChangeRatingDoctor(rate: value);
                            },

                          ),
                          defaultText(
                              text: "${HomeCubit.get(context).ratingValue}/5",
                              color: Color(0xff434343),
                              fontSize: 26,
                              fontFamily: "Roboto",
                              textAlign: TextAlign.start,
                              textHeight: 1.333,
                              alignment: AlignmentDirectional.center,
                              boxFit: BoxFit.fitHeight,
                              height:MediaQuery.sizeOf(context).height * 0.05,
                              context: context),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context)
                            .height *
                            0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                                color: defaultBlackColor.withAlpha(35),
                                blurRadius: 15,
                                blurStyle: BlurStyle.outer
                            ),
                          ],
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              defaultText(
                                  text: S.of(context).doctorReviewText,
                                  color: Color(0xff434343),
                                  fontSize: 26,
                                  fontFamily: "Roboto",
                                  textAlign: TextAlign.start,
                                  textHeight: 1.333,
                                  alignment: AlignmentDirectional.centerStart,
                                  boxFit: BoxFit.fitHeight,
                                  height:MediaQuery.sizeOf(context).height * 0.05,
                                  context: context),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.02,
                              ),

                              defaultTextFormField(
                                context: context,
                                height: MediaQuery.sizeOf(context).height * 0.08,
                                isExpanded: true,
                                controller:
                                commentRatingController,
                                hint: S.of(context).reviewTextField,
                                onValidate: (value){
                                  if(value!.isEmpty){
                                    return S.of(context).validatorReviewTextField;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.sizeOf(context)
                            .height *
                            0.0302,
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context)
                            .height *
                            0.0626,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffFE3398),
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          15)),
                                ),
                                child: MaterialButton(
                                  onPressed: () async{
                                      Navigator.pop(context);
                                      navigateAndReplace(context: context, widget: widgetScreen);
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(S.of(context).cancelButtonText,
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
                              width: MediaQuery.sizeOf(context).width * 0.0233,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: defaultBlueAccentColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                ),
                                child: MaterialButton(
                                  onPressed: () async {
                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                    if(formKey.currentState!.validate()){
                                      if(hasInternet){
                                        showDialog(context: context, builder: (context) =>defaultCircleProgressBar() ,);
                                        HomeCubit.get(context).createRating(doctorId: userId, rating: rate, comment: commentRatingController.text).then((value) async{
                                          await HomeCubit.get(context).getClinicsData();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          await showDialog(context: context, builder:(context) => defaultDialog(context: context, text: S.of(context).ratingAdeddSuccessfully,haveCloseButton: false,nextWidget: () {
                                            navigateAndReplace(context: context, widget: widgetScreen);
                                          },),);
                                        });
                                      }else{
                                        showSnackBar(context: context, text: S.current.failedConnection);
                                      }

                                    }else{
                                        Navigator.pop(context);
                                        navigateAndReplace(context: context, widget: widgetScreen);
                                      showDialog(context: context, builder: (context) =>
                                          defaultDialog(context: context, text: S.of(context).selectRatingText));
                                    }
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Text(S.of(context).submitButtonText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(
                                            0xffFFFFFF),
                                        fontFamily:
                                        "Roboto",
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
                    ]),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

///default action of circle progress bar
Widget defaultCircleProgressBar() {
    return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(
              child: Container(
                  color: Colors.transparent,
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                    backgroundColor: Color(0xffFE1F8F),
                    color: defaultBlueAccentColor,
                    // backgroundColor: Color(0xffFE1F8F),
                  ))),
        );
}

///get rating model from list of rating depending on id of doctor
RatingModel? getRatingOfDoctor({
  required BuildContext context,
  required int userIdOfDoctor,
}) {
  // showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
  HomeCubit.get(context).getRating().then((value) {
    // Navigator.pop(context);
  });
  RatingModel? rate;
  for (int i = 0; i < HomeCubit.get(context).listOfRatingModel.length; i++) {
    int doctorId = int.parse(HomeCubit.get(context).listOfRatingModel[i].doctorId!);
    if (userIdOfDoctor == doctorId) {
      rate = HomeCubit.get(context).listOfRatingModel[i];
    }
  }

  return rate;
}

///default dialog of App
defaultDialog({
  required BuildContext context,
  required String text,
  String? text2,
  VoidCallback? nextWidget,
  VoidCallback? closeFun,
  bool haveCloseButton=true,
}){
  double screenHeight = MediaQuery.sizeOf(context).height;
  double screenWidth = MediaQuery.sizeOf(context).width;
  return Dialog(
    insetPadding: EdgeInsets.all(0),
    child: Container(
      width: screenWidth,
      height: MediaQuery.sizeOf(context).height * 0.3,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: defaultBlackColor.withAlpha(16),
            offset: Offset(0, 0),
            blurStyle: BlurStyle.outer,
            blurRadius: 15,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: defaultWhiteColor,
      ),
      child: Stack(
        children: [
          if(haveCloseButton)
            PositionedDirectional(
              top: screenHeight * 0.0323,
              end: screenWidth * 0.0735,
              child: Container(
                height: screenHeight * 0.03,
                width: screenWidth * 0.045,
                // color: Colors.red,
                child: IconButton(
                  onPressed:closeFun!=null?closeFun:(){
                    Navigator.pop(context);
                  },
                  color: Color(0xff707070),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  icon: FittedBox(
                    fit: BoxFit.cover,
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
            padding: EdgeInsetsDirectional.only(
              top: screenHeight * 0.0961,
              end: screenWidth * 0.09,
              start: screenWidth * 0.09,
            ),
            child: Column(
              children: [
                defaultText(
                  text: text,
                  height: MediaQuery.sizeOf(context).height * 0.0440,
                  color: Colors.black,
                  alignment: AlignmentDirectional.center,
                  textAlign: TextAlign.center,
                  // boxFit: BoxFit.fill,
                  context: context,
                ),
                if(text2!=null)
                  defaultText(
                    text: text2,
                    height: MediaQuery.sizeOf(context).height * 0.0340,
                    color: Colors.black,
                    alignment: AlignmentDirectional.center,
                    textAlign: TextAlign.center,
                    context: context,
                  ),
                SizedBox(
                  height: screenHeight * 0.0377,
                ),
                Container(
                  height:screenHeight * 0.0626,
                  decoration: BoxDecoration(
                    color: Color(0xffFE3398),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: InkWell(
                    onTap:nextWidget!=null?nextWidget:(){
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "Ok",
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
        ],
      ),
    ),
  );
}

///default splash dialog of App
// Widget splashDialog({
//   required BuildContext context,
//   required String text,
//   String? text2,
//   Widget? nextWidget,
// }){
//      return Dialog(
//           elevation: 0,
//           clipBehavior: Clip.antiAlias,
//           backgroundColor: Colors.transparent,
//           child: Container(
//             clipBehavior: Clip.antiAlias,
//             height: MediaQuery.sizeOf(context).height * 0.1501,
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               boxShadow: [
//                 BoxShadow(
//                   color: defaultBlackColor.withAlpha(30),
//                   blurRadius: 15,
//                   blurStyle: BlurStyle.outer,
//                 ),
//               ],
//               // borderRadius: BorderRadius.all(Radius.circular(25))
//             ),
//             child: FlutterSplashScreen.scale(
//               animationDuration: Duration(seconds: 1),
//               backgroundColor: Colors.white,
//               animationCurve: Curves.bounceIn,
//               onEnd: () {
//                 Navigator.pop(context);
//               },
//               duration: Duration(seconds: 3),
//               nextScreen: nextWidget,
//               childWidget:Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   defaultText(
//                       text: text,
//                       height: MediaQuery.sizeOf(context).height * 0.0280,
//                       color: Colors.black,
//                       alignment: AlignmentDirectional.center,
//                       textAlign: TextAlign.center,
//                       // boxFit: BoxFit.fill,
//                       context: context,
//                   ),
//                   if(text2!=null)
//                   defaultText(
//                       text: text2,
//                       height: MediaQuery.sizeOf(context).height * 0.0280,
//                       color: Colors.black,
//                       alignment: AlignmentDirectional.center,
//                       textAlign: TextAlign.center,
//                       // boxFit: BoxFit.fill,
//                       context: context,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//      );
//     }

///default gridView in app
Widget defaultGridView({
  required BuildContext context,
  required int numberOfItemsHorizontally,
  required List list,
  ScrollController? controller,
  required double aspectRatio,
}) => GridView.count(
      crossAxisCount: numberOfItemsHorizontally,
      shrinkWrap: true,
      controller: controller,
      padding: EdgeInsets.all(5),
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
        list.length,
        (index) => list[index],
      ),
      primary: false,
      mainAxisSpacing: 5,
      crossAxisSpacing: 7,
      childAspectRatio: aspectRatio,
    );

///default action button in setting
defaultItemOfSetting({
  required BuildContext context,
  double? heightSVGIcon,
  String? prefixIconData,
  String? prefixIconDataSVG,
  String? title,
  Widget? suffixWidget,
  Function()? onTap,
}) => Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.06,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (prefixIconData != null)
                    Image.asset(
                      prefixIconData,
                      // height: MediaQuery.sizeOf(context).height * 0.04,
                      // width: MediaQuery.sizeOf(context).width * 0.08,
                      // fit: BoxFit.contain,
                      // color: Colors.black,
                    ),
                  if (prefixIconData == null && prefixIconDataSVG!=null)
                    SvgPicture.asset(
                      prefixIconDataSVG,
                      // height:heightSVGIcon ?? MediaQuery.sizeOf(context).height * 0.04,
                      // width: MediaQuery.sizeOf(context).width * 0.08,
                      // fit: BoxFit.contain,
                      color: Colors.black,
                    ),

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.05168,
                  ),

                  if (title != null)
                    defaultText(
                        text: title,
                        color: defaultGreyColor,
                        fontFamily: "Roboto",
                        fontSize: 22,
                        textHeight: 1.3181,
                        height: MediaQuery.sizeOf(context).height * 0.0313,
                        context: context),

                  Spacer(),

                  Row(
                    children: [
                      if (suffixWidget != null)
                        Row(
                          children: [
                            suffixWidget,
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.0257,
                            ),
                          ],
                        ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 25,
                        color: defaultBlueDarkColor,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 2,
            color: Color(0xff707070).withOpacity(0.40),
          ),
        ],
      ),
    );

/// container that contains default action button in setting
defaultSettingContainer({
  required BuildContext context,
  double? heightContainer,
  required String titleContainer,
  List<Widget>? child,
}) => Container(
      height: heightContainer!,
      width: MediaQuery.sizeOf(context).width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: defaultWhiteColor,
        boxShadow: [
          BoxShadow(
              color: defaultBlackColor.withAlpha(50),
              blurRadius: 15,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: MediaQuery.sizeOf(context).height * 0.0097,
          start: MediaQuery.sizeOf(context).width * 0.0350,
          end: MediaQuery.sizeOf(context).width * 0.0340,
          bottom: MediaQuery.sizeOf(context).height * 0.01457,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            defaultText(
                text: titleContainer,
                color: defaultGreyColor,
                height: MediaQuery.sizeOf(context).height * 0.025,
                fontFamily: "Arial",
                fontSize: 23,
                textHeight: 1.3125,
                textAlign: TextAlign.start,
                context: context
            ),
            Spacer(),
            if (child != null)
              Column(
                children: child,
              ),
          ],
        ),
      ),
    );

/// App Bar Widget With Prefix Icon
Widget appBarWidget({
  required BuildContext context,
  required double? height,
  double? textHeight,
  double? textWidth,
  required double? width,
  double? iconHeight,
  double? iconWidth,
  String? assetBackgroundImage,
  required String titleAppBar,
  String? assetPNGIcon,
  String? assetSVGIcon,
  VoidCallback? onPressLeading,
}) {
  double screenHeight = MediaQuery.sizeOf(context).height;
  return Container(
    height: height,
    width: width,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: assetBackgroundImage != null ? null : Colors.white,
      image: assetBackgroundImage != null
          ? DecorationImage(
        image: AssetImage(
          assetBackgroundImage,
        ),
        fit: BoxFit.fill,
      )
          : null,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        top: screenHeight *0.01,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: screenHeight * 0.05,
            child:Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // if (assetSVGIcon != null || assetPNGIcon != null)
                    //   Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       if (assetPNGIcon != null)
                    //         Image.asset(
                    //           assetPNGIcon,
                    //           height: iconHeight ?? screenHeight * 0.04,
                    //           // width: iconWidth != null
                    //           //     ? iconWidth
                    //           //     : screenWidth * 0.09345,
                    //           fit: BoxFit.fill,
                    //           color: Colors.black,
                    //         ),
                    //       if (assetSVGIcon != null)
                    //         Container(
                    //           height: iconHeight ?? screenHeight * 0.04,
                    //           // width: iconWidth != null
                    //           //     ? iconWidth
                    //           //     : screenWidth * 0.09345,
                    //           color: Colors.transparent,
                    //           child: SvgPicture.asset(
                    //             assetSVGIcon,
                    //             fit: BoxFit.fill,
                    //           ),
                    //         ),
                    //       SizedBox(
                    //         width: screenWidth * 0.02336,
                    //       ),
                    //     ],
                    //   ),
                      defaultText(
                        context: context,
                        height:textHeight ?? screenHeight * 0.05,
                        width:textWidth,
                        textAlign: TextAlign.center,
                        alignment: AlignmentDirectional.center,
                        // boxFit: BoxFit.fitHeight,
                        text: titleAppBar,
                        fontSize: 25,
                        boxFit: BoxFit.fill,
                        // fontWeight: FontWeight.bold,
                        textHeight: 1.343,
                        fontFamily: "Roboto",
                        color: defaultWhiteColor,
                      ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    onPressed: onPressLeading ?? () => Navigator.pop(context),
                    padding: EdgeInsetsDirectional.only(start: 10),
                    icon: Icon(Icons.arrow_back_sharp),
                    iconSize: 48,
                    color: defaultWhiteColor,
                    style: ButtonStyle(
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// App Bar Widget Without Prefix Icon
Widget appBarWidgetWithoutIcon({
  required BuildContext context,
  required double? height,
  double? textHeight,
  double? textWidth,
  required double? width,
  String? assetBackgroundImage,
  required String titleAppBar,
  VoidCallback? onPressLeading,
}) {
  double screenHeight = MediaQuery.sizeOf(context).height;
  double screenWidth = MediaQuery.sizeOf(context).width;
  return Container(
    height: height,
    width: width,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: assetBackgroundImage != null ? null : Colors.white,
      image: assetBackgroundImage != null
          ? DecorationImage(
        image: AssetImage(
          assetBackgroundImage,
        ),
        fit: BoxFit.fill,
      )
          : null,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        top: screenHeight *0.01,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: screenHeight * 0.09,
            child:Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  defaultTextWithoutFittedBox(
                    context: context,
                    maxLine: 2,
                    height:textHeight ?? screenHeight * 0.09,
                    width:screenWidth * 0.7,
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.center,
                    // boxFit: BoxFit.fitHeight,
                    text: titleAppBar,
                    fontSize: 22,
                    boxFit: BoxFit.fill,
                    // fontWeight: FontWeight.bold,
                    textHeight: 1.343,
                    fontFamily: "Roboto",
                    color: defaultWhiteColor,
                  ),
                ],
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    onPressed: onPressLeading ?? () => Navigator.pop(context),
                    padding: EdgeInsetsDirectional.only(start: 10),
                    icon: Icon(Icons.arrow_back_sharp),
                    iconSize: 31,
                    color: defaultWhiteColor,
                    style: ButtonStyle(
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

///default status bar for screens
PreferredSize statusBar(){
  return  PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar());
}

///APP Navigation Bar
Widget appNavBar({
  required BuildContext context,
  int? localIndex,
}) {
  var cubit = HomeCubit.get(context);
  return Align(
    alignment: AlignmentDirectional.bottomCenter,
    child: Container(
      height: MediaQuery.sizeOf(context).height * 0.0842,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: FluidNavBarLocal(
        isArabic: HomeCubit.get(context).localLanguage.contains("ar")?true:false,
        localIndex: localIndex,
        icons: [
          FluidNavBarIcon(
            svgPath: "assets/svgIcons/hospital.svg",
            extras: {
              S.of(context).labelNavBar: S.of(context).homeTitleNavBar
            },
            selectedForegroundColor: Colors.white,
            backgroundColor: Colors.transparent,
          ),
          FluidNavBarIcon(
            svgPath: "assets/svgIcons/stethoscope-svgrepo-com.svg",
            backgroundColor: Colors.transparent,
            selectedForegroundColor: Colors.white,
            extras: {
              S.of(context).labelNavBar: S.of(context).bookTitleNavBar
            },
          ),
          FluidNavBarIcon(
            svgPath: "assets/svgIcons/wallet-svgrepo-com.svg",
            backgroundColor: Colors.transparent,
            selectedForegroundColor: Colors.white,
            extras: {
              S.of(context).labelNavBar: S.of(context).walletTitleNavBar
            },
          ),
          FluidNavBarIcon(
            svgPath: "assets/svgIcons/profile.svg",
            selectedForegroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            extras: {
              S.of(context).labelNavBar:
                  S.of(context).accountTitleNavBar
            },
          ),
        ],
        style: FluidNavBarStyle(
          iconUnselectedForegroundColor: Color(0xffB6F4FE),
          iconSelectedForegroundColor: Color(0xffFE1F8F),
          barBackgroundColor: defaultBlueDarkColor,
        ),
        defaultIndex: cubit.currentIndexNavBar,
        onChange: (index) async {
          bool hasInternet=await NetworkConnection.getConnectivity();
          HomeCubit.get(context).onChangeNavBar(index: index, context: context);
          if (index == 0) {
            if (userTokenApi != null) {
              if(hasInternet){
                showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                await SignInCubit.get(context).refreshData(context: context).then((value){
                  Navigator.pop(context);
                });
              }else{
                showSnackBar(context: context, text: S.current.failedConnection);
              }
            }
            else{
              if(hasInternet){

              }else{
                showSnackBar(context: context, text: S.current.failedConnection);
              }
            }
          }
          else if (index == 1) {
            if(hasInternet){
              showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
              await HomeCubit.get(context).getClinicsData().then((value) {Navigator.pop(context);});
            }
            else{
              showSnackBar(context:context, text: S.current.failedConnection);
            }
          }



        },
      ),
    ),
  );
}


///APP Navigation Bar
Widget appNavBarFixed({
  required BuildContext context,
  int? localIndex,
}) {
  var cubit = HomeCubit.get(context);
  return Stack(
    children: [
      Container(
        height: MediaQuery.sizeOf(context).height * 0.0842,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: FluidNavBarLocal(
          isArabic: HomeCubit.get(context).localLanguage.contains("ar")?true:false,
          localIndex: localIndex,
          icons: [
            FluidNavBarIcon(
              svgPath: "assets/svgIcons/hospital.svg",
              extras: {
                S.of(context).labelNavBar: S.of(context).homeTitleNavBar
              },
              selectedForegroundColor: Colors.white,
              backgroundColor: Colors.transparent,
            ),
            FluidNavBarIcon(
              svgPath: "assets/svgIcons/stethoscope-svgrepo-com.svg",
              backgroundColor: Colors.transparent,
              selectedForegroundColor: Colors.white,
              extras: {
                S.of(context).labelNavBar: S.of(context).bookTitleNavBar
              },
            ),
            FluidNavBarIcon(
              svgPath: "assets/svgIcons/wallet-svgrepo-com.svg",
              backgroundColor: Colors.transparent,
              selectedForegroundColor: Colors.white,
              extras: {
                S.of(context).labelNavBar: S.of(context).walletTitleNavBar
              },
            ),
            FluidNavBarIcon(
              svgPath: "assets/svgIcons/profile.svg",
              selectedForegroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              extras: {
                S.of(context).labelNavBar:
                S.of(context).accountTitleNavBar
              },
            ),
          ],
          style: FluidNavBarStyle(
            iconUnselectedForegroundColor: Color(0xffB6F4FE),
            iconSelectedForegroundColor: Color(0xffFE1F8F),
            barBackgroundColor: defaultBlueDarkColor,
          ),
          defaultIndex: cubit.currentIndexNavBar,
          onChange: (index) async {
            bool hasInternet=await NetworkConnection.getConnectivity();
            HomeCubit.get(context).onChangeNavBar(index: index, context: context);
            if (index == 0) {
              if (userTokenApi != null) {
                if(hasInternet){
                  showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                  await SignInCubit.get(context).refreshData(context: context).then((value){
                    Navigator.pop(context);
                  });
                }else{
                  showSnackBar(context: context, text: S.current.failedConnection);
                }
              }
              else{
                if(hasInternet){

                }else{
                  showSnackBar(context: context, text: S.current.failedConnection);
                }
              }
            }
            else if (index == 1) {
              if(hasInternet){
                showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                await HomeCubit.get(context).getClinicsData().then((value) {Navigator.pop(context);});
              }
              else{
                showSnackBar(context:context, text: S.current.failedConnection);
              }
            }



          },
        ),
      ),
    ],
  );
}

///default dialog to check process
Widget dialog({
  required BuildContext context,
  double? heightContainer,
  double? paddingHorizontal,
  String? image,
  bool? isJustDialog,
  required Widget child,
}){
  double screenHeight = MediaQuery.sizeOf(context).height;
  double screenWidth = MediaQuery.sizeOf(context).width;
  return Stack(
    children: [
      PositionedDirectional(
        top: screenHeight * 0.1555,
        start: paddingHorizontal ?? screenWidth * 0.0327,
        end: paddingHorizontal ?? screenWidth * 0.0327,
        child: Dialog(
          insetPadding: EdgeInsets.all(0),
          child: Container(
            width: screenWidth,
            height: heightContainer,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: defaultBlackColor.withAlpha(16),
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 15,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: defaultWhiteColor,
            ),
            child: Stack(
              children: [
                // PositionedDirectional(
                //   top: screenHeight * 0.0323,
                //   end: screenWidth * 0.0735,
                //   child: Container(
                //     height: screenHeight * 0.0183,
                //     width: screenWidth * 0.0397,
                //     child: IconButton(
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //         color: Color(0xff707070),
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.all(0),
                //         icon: FittedBox(
                //           fit: BoxFit.contain,
                //           child: Icon(
                //             Icons.close,
                //           ),
                //         )),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenHeight * 0.0961,
                    // bottom:screenHeight* 0.0507,
                    end: screenWidth * 0.1168,
                    start: screenWidth * 0.1168,
                  ),
                  child: Column(
                    children: [
                      if(isJustDialog!=true)
                      Container(
                        height: screenHeight * 0.2764,
                        width: screenWidth * 0.7009,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              // BoxShadow(
                              //   color: defaultBlackColor.withAlpha(18),
                              //   blurRadius: 25,
                              //   blurStyle: BlurStyle.outer,
                              // ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: image == null
                            ? Image.asset(
                                "assets/Background/default_dialog_image.png",
                                fit: BoxFit.fill,
                              )
                            : Image.asset(image,fit: BoxFit.fill),
                      ),
                      child,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

showSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
    // padding: EdgeInsets.all(15),
      duration: Duration(seconds: 6),
      dismissDirection: DismissDirection.endToStart,
      content: Center(
    // height: MediaQuery.sizeOf(context).height * 0.07,
    // width: MediaQuery.sizeOf(context).width * 0.1,
    child: Text(text),
    // color: Colors.red,
  )));
}
