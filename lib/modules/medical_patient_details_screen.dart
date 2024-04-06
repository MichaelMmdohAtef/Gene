import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/modules/edit_medical_patient_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class MedicalPatientDetailsScreen extends StatelessWidget {
  MedicalPatientDetailsScreen({super.key});
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight =MediaQuery.sizeOf(context).height;
    screenWidth =MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {

        ///initialize variable of button sheet = false
        HomeCubit.get(context).changeButtonSheet(isShow: false);

        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {

          },
          builder: (context, state) {


            var cubit=HomeCubit.get(context);
            return Scaffold(
              extendBodyBehindAppBar: true,
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/Background/App Background-1.png",),fit: BoxFit.cover)
                  ),
                  child: Stack(
                    children: [

                      ///single child scroll view
                      SingleChildScrollView(
                        child: Stack(
                          children: [

                            /// appbar
                            appBarWidget(
                              context: context,
                              onPressLeading: (){
                                cubit.medicalHistoryModel=null;
                                Navigator.pop(context);
                              },
                              height: MediaQuery.sizeOf(context).height * 0.2159,
                              width:MediaQuery.sizeOf(context).width,
                              titleAppBar: S.of(context).medicalPatientFileText,
                              assetBackgroundImage:"assets/container_home_page/title appBar.png" ,
                            ),

                            ///body
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: screenHeight * 0.1133,
                                start:screenWidth* 0.0327,
                                end: screenWidth* 0.0327,
                                bottom: screenHeight * 0.1231,
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: screenHeight * (1.658)),
                                child: Container(
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
                                      top:screenHeight * 0.0431,
                                      start:screenWidth * 0.0443,
                                      end:screenWidth * 0.0443,
                                    ),
                                    child: Container(
                                      width: screenWidth,
                                      child:ConditionalBuilder(
                                        condition: cubit.medicalHistoryModel!=null,
                                        builder: (context) {
                                          return Column(
                                            children: [

                                              ///title of page
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).medicalPatientFileText,
                                                      fontFamily: "Roboto",
                                                      textHeight: 1.333,
                                                      alignment: AlignmentDirectional.center,
                                                      fontSize: 30,
                                                      color: Color(0xff707070),
                                                      height:screenHeight * 0.042,
                                                      context: context),
                                                  TextButton(onPressed: () {
                                                    navigateAndPush(context,EditMedicalPatientScreen());
                                                  },
                                                      child: Text(
                                                        S.of(context).editMedicalPatientButton,
                                                        style: TextStyle(
                                                            fontSize: 20
                                                        ),)
                                                  ),
                                                ],
                                              ),


                                              SizedBox(
                                                height:screenHeight * 0.0377,
                                              ),

                                              /// Have you had any vaccination?
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context, EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).vaccinationMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child:ConstrainedBox(
                                                      child:cubit.medicalHistoryModel!.vaccine!.isNotEmpty?
                                                      ListView.separated(
                                                          padding: EdgeInsets.all(0),
                                                          itemBuilder:(context, index) => Text("${index+1}-${getVaccinations(context: context)[index]}"),
                                                          separatorBuilder:(context, index) => SizedBox(
                                                            height: screenHeight * 0.0035,
                                                          ),
                                                          shrinkWrap: true,
                                                          itemCount: getVaccinations(context: context).length)
                                                          :
                                                      defaultText(
                                                          text: S.of(context).nullText,
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          textAlign: TextAlign.start,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context,
                                                      ),
                                                      constraints: BoxConstraints(
                                                        maxHeight: screenHeight * 1,
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0107,
                                              ),

                                              ///Have you had Coronavirus vaccination?
                                              Column(
                                                children: [

                                                  InkWell(
                                                    onTap: () {
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).askIfUserHaveCoronaVirusVaccine,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0237,
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child:defaultText(
                                                        text: cubit.medicalHistoryModel!.coronavirus??"No",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0237,
                                              ),


                                              ///Significant Medical History
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).medicalHistoryMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),


                                                  SizedBox(
                                                    height:screenHeight * 0.0194,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context, EditMedicalPatientScreen());
                                                    },
                                                    child: Container(
                                                      height:screenHeight * 0.1965,
                                                      width: screenWidth,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffC2EAFF).withOpacity(0.52),
                                                          border: Border.all(
                                                            color:Color(0xff3181AB).withOpacity(0.52),
                                                            width: 1,
                                                            style: BorderStyle.solid,
                                                            strokeAlign: BorderSide.strokeAlignOutside,
                                                          )
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          vertical:screenHeight * 0.0151,
                                                          horizontal: screenWidth * 0.0210,
                                                        ),
                                                        child: SingleChildScrollView(
                                                          child: Text(
                                                            cubit.medicalHistoryModel!.medicalHistory??"    ",
                                                            style: TextStyle(
                                                              color: Color(0xff707070),
                                                              height: 1.333,
                                                              fontFamily: "Roboto",
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              ///Medical Problems
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).medicalProblemsMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0194,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context, EditMedicalPatientScreen());
                                                    },
                                                    child: Container(
                                                      height:screenHeight * 0.1965,
                                                      width: screenWidth,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffC2EAFF).withOpacity(0.52),
                                                          border: Border.all(
                                                            color:Color(0xff3181AB).withOpacity(0.52),
                                                            width: 1,
                                                            style: BorderStyle.solid,
                                                            strokeAlign: BorderSide.strokeAlignOutside,
                                                          )
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          vertical:screenHeight * 0.0151,
                                                          horizontal: screenWidth * 0.0210,
                                                        ),
                                                        child: SingleChildScrollView(
                                                          child: Text(
                                                            cubit.medicalHistoryModel!.medicalProblems??"    ",
                                                            style: TextStyle(
                                                              color: Color(0xff707070),
                                                              height: 1.333,
                                                              fontFamily: "Roboto",
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0377,
                                              ),

                                              /// List any medication taken regularly
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).regularlyMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),
                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(padding: EdgeInsetsDirectional.only(
                                                    start:screenWidth * 0.0233,
                                                  ),
                                                    child:ConstrainedBox(
                                                      child:cubit.medicalHistoryModel!.regularly!.length!=0?
                                                      ListView.separated(
                                                          padding: EdgeInsets.all(0),
                                                          itemBuilder:(context, index) => Text("${index+1}-${getRegularly(context: context)[index]}"),
                                                          separatorBuilder:(context, index) => SizedBox(
                                                            height: screenHeight * 0.0035,
                                                          ),
                                                          shrinkWrap: true,
                                                          itemCount: getRegularly(context: context).length )
                                                          :defaultText(
                                                          text: "    ",
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          textAlign: TextAlign.start,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      constraints: BoxConstraints(maxHeight:screenHeight * 1 ),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0172,
                                              ),

                                              /// List any allergies
                                              Column(
                                                children: [

                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).allergiesMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child:ConstrainedBox(
                                                      child:cubit.medicalHistoryModel!.allergies!.length!=0?
                                                      ListView.separated(
                                                          padding: EdgeInsets.all(0),
                                                          itemBuilder:(context, index) => Text("${index+1}-${getAllergies(context: context)[index]}"),
                                                          separatorBuilder:(context, index) => SizedBox(
                                                            height: screenHeight * 0.0035,
                                                          ),
                                                          shrinkWrap: true,
                                                          itemCount: getAllergies(context: context).length )
                                                          :defaultText(
                                                          text: "    ",
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          textAlign: TextAlign.start,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      constraints: BoxConstraints(maxHeight:screenHeight * 1 ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0253,
                                              ),

                                              /// divider
                                              Container(
                                                height: 2,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(0xff707070),
                                                        width: 2
                                                    )
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0070,
                                              ),

                                              /// Medical Insurance Details
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).medicalInsuranceDetailsMedicalPatient,
                                                      alignment: AlignmentDirectional.center,
                                                      fontFamily: "Roboto",
                                                      textHeight: 1,
                                                      fontSize: 23,
                                                      color: Color(0xff707070),
                                                      height:screenHeight * 0.042,
                                                      context: context),
                                                  TextButton(onPressed: () {
                                                    navigateAndPush(context,EditMedicalPatientScreen());
                                                  },
                                                      child: Text(
                                                        S.of(context).editMedicalPatientButton,
                                                        style: TextStyle(
                                                            fontSize: 18
                                                        ),)
                                                  ),
                                                ],
                                              ),


                                              SizedBox(
                                                height: screenHeight * 0.0161,
                                              ),

                                              /// Do you have medical insurance?
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).insuranceMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0237,
                                                  ),
                                                  Padding(padding: EdgeInsetsDirectional.only(
                                                    start:screenWidth * 0.0233,
                                                  ),
                                                    child: defaultText(
                                                        text: cubit.medicalHistoryModel!.insurance??"    ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Insurance company name
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).companyNameMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child: defaultText(
                                                        text: cubit.medicalHistoryModel!.insuranceCompanyName??"    ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Policy Number
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).policyNumberMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child: defaultText(
                                                        text: cubit.medicalHistoryModel!.policyNumber??"    ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Expiry Date
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.of(context).expiryDateText,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child: defaultText(
                                                        text: cubit.medicalHistoryModel!.expiryDate??"    ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Files
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: S.current.filesMedicalPatient,
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0194,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child: Container(
                                                      height:screenHeight * 0.1965,
                                                      width: screenWidth,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffC2EAFF).withOpacity(0.52),
                                                          border: Border.all(
                                                            color:Color(0xff3181AB).withOpacity(0.52),
                                                            width: 1,
                                                            style: BorderStyle.solid,
                                                            strokeAlign: BorderSide.strokeAlignOutside,
                                                          )
                                                      ),
                                                      child: cubit.medicalHistoryModel!.gallery!.length != 0?
                                                      CarouselSlider(
                                                        items:List.generate(cubit.medicalHistoryModel!.gallery!.length,
                                                              (index) => Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                                            ),
                                                            width: MediaQuery.sizeOf(context).width* 0.5,
                                                            height: MediaQuery.sizeOf(context).height,
                                                            child: Image(image: NetworkImage(cubit.medicalHistoryModel!.gallery![index]),fit:BoxFit.fill),
                                                          ),),
                                                        options:CarouselOptions(
                                                          viewportFraction: 1,
                                                          scrollPhysics: BouncingScrollPhysics(),
                                                          reverse: false,
                                                          enableInfiniteScroll: false,
                                                        ),
                                                      ):
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          vertical:screenHeight * 0.0151,
                                                          horizontal: screenWidth * 0.0210,
                                                        ),
                                                        child: Text(
                                                          S.of(context).hintContainerFilesMedicalPatient,
                                                          style: TextStyle(
                                                            color: Color(0xff707070),
                                                            height: 1.333,
                                                            fontFamily: "Roboto",
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0194,
                                              ),

                                              ///edit medical patient button
                                              defaultMaterialButton(
                                                height: screenHeight * 0.0583,
                                                context: context,
                                                backgroundColor:defaultBlueAccentColor,
                                                textColor:defaultWhiteColor,
                                                text:S.of(context).editMedicalPatientButton,
                                                onPress: (){
                                                  navigateAndPush(context,EditMedicalPatientScreen());
                                                },
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0161,
                                              ),

                                            ],
                                          );
                                        },
                                        fallback: (context) {
                                          return Column(
                                            children: [

                                            ///title of medical patient file
                                            defaultText(
                                                text: S.of(context).medicalPatientFileText,
                                                fontFamily: "Roboto",
                                                textHeight: 1.333,
                                                fontSize: 24,
                                                color: Color(0xff707070),
                                                width:screenWidth * 0.605,
                                                height:screenHeight * 0.0345,
                                                context: context),

                                              SizedBox(
                                                height:screenHeight * 0.0377,
                                              ),

                                              /// Have you had any vaccination?
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context, EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: "Have you had any vaccination?",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child:ConstrainedBox(
                                                      child: defaultText(
                                                          text: "   ",
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          textAlign: TextAlign.start,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context
                                                      ),
                                                      constraints: BoxConstraints(
                                                        maxHeight: screenHeight * 0.1036,
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0107,
                                              ),

                                              // Have you had Coronavirus vaccination?
                                              // Column(
                                              //   children: [
                                              //     defaultText(
                                              //         text: "Have you had Coronavirus vaccination?",
                                              //         height:screenHeight * 0.02591,
                                              //         color: Color(0xff707070),
                                              //         fontSize: 18,
                                              //         textHeight: 1.333,
                                              //         fontFamily: "Roboto",
                                              //         boxFit: BoxFit.fitHeight,
                                              //         context: context),
                                              //     SizedBox(
                                              //       height:screenHeight * 0.0237,
                                              //     ),
                                              //     Padding(
                                              //       padding: EdgeInsetsDirectional.only(
                                              //         start:screenWidth * 0.0233,
                                              //       ),
                                              //       child:defaultText(
                                              //           text: "yes",
                                              //           height:screenHeight * 0.02591,
                                              //           color: Color(0xff707070),
                                              //           fontSize: 18,
                                              //           textHeight: 1.333,
                                              //           textAlign: TextAlign.start,
                                              //           fontFamily: "Roboto",
                                              //           boxFit: BoxFit.fitHeight,
                                              //           context: context),
                                              //     ),
                                              //
                                              //   ],
                                              // ),
                                              // SizedBox(
                                              //   height:screenHeight * 0.0237,
                                              // ),
                                              // Significant Medical History

                                              ///medical history
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: "Significant Medical History",
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),

                                                  SizedBox(
                                                    height:screenHeight * 0.0194,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context, EditMedicalPatientScreen());
                                                    },
                                                    child: Container(
                                                      height:screenHeight * 0.1965,
                                                      width: screenWidth,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffC2EAFF).withOpacity(0.52),
                                                          border: Border.all(
                                                            color:Color(0xff3181AB).withOpacity(0.52),
                                                            width: 1,
                                                            style: BorderStyle.solid,
                                                            strokeAlign: BorderSide.strokeAlignOutside,
                                                          )
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          vertical:screenHeight * 0.0151,
                                                          horizontal: screenWidth * 0.0210,
                                                        ),
                                                        child: SingleChildScrollView(
                                                          child: Text(
                                                            "    ",
                                                            style: TextStyle(
                                                              color: Color(0xff707070),
                                                              height: 1.333,
                                                              fontFamily: "Roboto",
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              /// List any Medical Problems
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: "List any Medical Problems",
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),
                                                  SizedBox(
                                                    height:screenHeight * 0.0194,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context, EditMedicalPatientScreen());
                                                    },
                                                    child: Container(
                                                      height:screenHeight * 0.1965,
                                                      width: screenWidth,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffC2EAFF).withOpacity(0.52),
                                                          border: Border.all(
                                                            color:Color(0xff3181AB).withOpacity(0.52),
                                                            width: 1,
                                                            style: BorderStyle.solid,
                                                            strokeAlign: BorderSide.strokeAlignOutside,
                                                          )
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          vertical:screenHeight * 0.0151,
                                                          horizontal: screenWidth * 0.0210,
                                                        ),
                                                        child: SingleChildScrollView(
                                                          child: Text(
                                                            "    ",
                                                            style: TextStyle(
                                                              color: Color(0xff707070),
                                                              height: 1.333,
                                                              fontFamily: "Roboto",
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0377,
                                              ),

                                              /// List any medication taken regularly
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: "List any medication taken regularly",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),
                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child:ConstrainedBox(
                                                      child:defaultText(
                                                          text: "    ",
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          textAlign: TextAlign.start,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      constraints: BoxConstraints(maxHeight:screenHeight * 0.1036 ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0172,
                                              ),

                                              /// List any allergies
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: "List any allergies",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child:ConstrainedBox(
                                                      child:defaultText(
                                                          text: "    ",
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          textAlign: TextAlign.start,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      constraints: BoxConstraints(maxHeight:screenHeight * 0.1036 ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0253,
                                              ),

                                              /// devider
                                              Container(
                                                height: 2,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(0xff707070),
                                                        width: 2
                                                    )
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0070,
                                              ),

                                              /// Medical Insurance Details
                                              defaultText(
                                                  text: "Medical Insurance Details",
                                                  alignment: AlignmentDirectional.center,
                                                  fontFamily: "Roboto",
                                                  textHeight: 1.333,
                                                  fontSize: 24,
                                                  color: Color(0xff707070),
                                                  height:screenHeight * 0.0345,
                                                  context: context),

                                              SizedBox(
                                                height: screenHeight * 0.0161,
                                              ),

                                              /// Do you have medical insurance?
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: "Do you have medical insurance?",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0237,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child: defaultText(
                                                        text: "   ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Insurance company name
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: "Insurance company name",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child: defaultText(
                                                        text: "    ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Policy Number
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: "Policy Number",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child: defaultText(
                                                        text: "    ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Expiry Date
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child:defaultText(
                                                        text: "Expiry Date",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                  SizedBox(
                                                    height:screenHeight * 0.0172,
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                      start:screenWidth * 0.0233,
                                                    ),
                                                    child: defaultText(
                                                        text: "    ",
                                                        height:screenHeight * 0.02591,
                                                        color: Color(0xff707070),
                                                        fontSize: 18,
                                                        textHeight: 1.333,
                                                        textAlign: TextAlign.start,
                                                        fontFamily: "Roboto",
                                                        boxFit: BoxFit.fitHeight,
                                                        context: context),
                                                  ),

                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0172,
                                              ),

                                              /// Files
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: "Files",
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),
                                                  SizedBox(
                                                    height:screenHeight * 0.0194,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      navigateAndPush(context,EditMedicalPatientScreen());
                                                    },
                                                    child: Container(
                                                      height:screenHeight * 0.1965,
                                                      width: screenWidth,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffC2EAFF).withOpacity(0.52),
                                                          border: Border.all(
                                                            color:Color(0xff3181AB).withOpacity(0.52),
                                                            width: 1,
                                                            style: BorderStyle.solid,
                                                            strokeAlign: BorderSide.strokeAlignOutside,
                                                          )
                                                      ),
                                                      child: cubit.files!.length!=0?
                                                      CarouselSlider(
                                                        items:List.generate(cubit.files!.length,
                                                              (index) => Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                                            ),
                                                            width: MediaQuery.sizeOf(context).width* 0.5,
                                                            height: MediaQuery.sizeOf(context).height,
                                                            child: Image(image: NetworkImage(cubit.files![index].path),fit:BoxFit.fill),
                                                          ),),
                                                        options:CarouselOptions(
                                                          viewportFraction: 1,
                                                          scrollPhysics: BouncingScrollPhysics(),
                                                          reverse: false,
                                                          enableInfiniteScroll: false,
                                                        ),
                                                      ):
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          vertical:screenHeight * 0.0151,
                                                          horizontal: screenWidth * 0.0210,
                                                        ),
                                                        child: Text(
                                                          "Files from data (Photos)",
                                                          style: TextStyle(
                                                            color: Color(0xff707070),
                                                            height: 1.333,
                                                            fontFamily: "Roboto",
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),


                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0194,
                                              ),

                                              ///edit medical Patient button
                                              defaultMaterialButton(
                                                height: screenHeight * 0.0583,
                                                context: context,
                                                backgroundColor:defaultBlueAccentColor,
                                                textColor:defaultWhiteColor,
                                                text:"Edit",
                                                onPress: (){
                                                  navigateAndPush(context,EditMedicalPatientScreen());
                                                },
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0161,
                                              ),

                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  // color: Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                      ///nav bar
                      appNavBar(context: context),

                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  ///get allergies of user
  List<String> getAllergies({
    required BuildContext context,
  }){
    List<String> allAllergies=[];
    for(int i=0;i<HomeCubit.get(context).medicalHistoryModel!.allergies!.length;i++){
      for(int n=0;n<HomeCubit.get(context).allAllergies.length;n++){
      if(int.parse(HomeCubit.get(context).medicalHistoryModel!.allergies![i])==HomeCubit.get(context).allAllergies[n].id){
        allAllergies.add("${HomeCubit.get(context).allAllergies[n].name}");
      }
      }
    }
    return allAllergies;
  }

  ///get vaccination of user
  List<String> getVaccinations({
    required BuildContext context,
  }){
    List<String>? allVaccinations=[];
    for(int i=0;i<HomeCubit.get(context).medicalHistoryModel!.vaccine!.length;i++){
      for(int n=0;n<HomeCubit.get(context).allVaccinations.length;n++){
        if(int.parse(HomeCubit.get(context).medicalHistoryModel!.vaccine![i])==HomeCubit.get(context).allVaccinations[n].id){
          allVaccinations.add("${HomeCubit.get(context).allVaccinations[n].name}");
        }
      }
    }
    return allVaccinations;
  }

  ///get regularly of user
  List<String> getRegularly({
    required BuildContext context,
  }){
    List<String> allRegularly=[];
    for(int i=0;i<HomeCubit.get(context).medicalHistoryModel!.regularly!.length;i++){
      for(int n=0;n<HomeCubit.get(context).allRegularly.length;n++){
        if(int.parse(HomeCubit.get(context).medicalHistoryModel!.regularly![i])==HomeCubit.get(context).allRegularly[n].id){
          allRegularly.add("${HomeCubit.get(context).allRegularly[n].name}");
        }
      }
    }
    return allRegularly;
  }


}
