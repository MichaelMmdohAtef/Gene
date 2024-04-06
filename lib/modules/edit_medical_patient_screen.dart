import 'dart:io';

import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:Gene/generated/l10n.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/medical_history_model.dart';
import 'package:Gene/models/medical_setting_model.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';

class EditMedicalPatientScreen extends StatefulWidget {
  EditMedicalPatientScreen({super.key});

  @override
  State<EditMedicalPatientScreen> createState() => _EditMedicalPatientScreenState();
}

class _EditMedicalPatientScreenState extends State<EditMedicalPatientScreen> with TickerProviderStateMixin{

  late double screenWidth;

  ///medical history controller that control value of medical history
  TextEditingController medicalHistoryController=TextEditingController();

  ///medical Problems controller that control value of medical Problems
  TextEditingController medicalProblemsController=TextEditingController();

  ///medical company name controller that control value of medical company name
  TextEditingController medicalCompanyNameController=TextEditingController();

  ///medical policy number controller that control value of medical policy number
  TextEditingController medicalPolicyNumberController=TextEditingController();

  ///medical expiry date controller that control value of medical expiry date
  TextEditingController medicalExpiryDateController=TextEditingController();

  List<String> allAllergies=[];
  List<String> allVaccinations=[];
  List<String> allRegularly=[];
  late double screenHeight;
  var formKey=GlobalKey<FormState>();
  var scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    screenHeight =MediaQuery.sizeOf(context).height;
    screenWidth =MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        ///initialization of variables
        HomeCubit.get(context).changeButtonSheet(isShow: false);
        checkControllers(context: context);
        setAllergies(context: context);
        setRegularly(context: context);
        setInsurance(context: context);
        setCoronaVirusVaccine(context: context);
        setVaccine(context: context);
        HomeCubit.get(context).changeButtonSheet(isShow: false);
        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {
            if(state is OnSuccessUpdateMedicalProfile){
              if(state.value.statusCode==200){
                Navigator.pop(context);
                Navigator.pop(context);
                HomeCubit.get(context).onChangeListOfMedicalImages(lists: []);
                showDialog(context: context, builder: (context) =>
                defaultDialog(context: context, text: state.value.data['message']));
              }
            }else if(state is OnErrorUpdateMedicalProfile){
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            var cubit=HomeCubit.get(context);
            return  Scaffold(
              key: scaffoldKey,
              appBar: statusBar(),

              body: SafeArea(
                child: Stack(
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
                      top: MediaQuery.sizeOf(context).height * 1.41789,
                      left: 0,
                    ),

                    SingleChildScrollView(
                      child: Stack(
                        children: [

                          ///first background
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
                            top: MediaQuery.sizeOf(context).height * 1.41789,
                            left: 0,
                          ),

                          /// appbar
                          appBarWidget(
                            context: context,
                            height: MediaQuery.sizeOf(context).height * 0.2159,
                            width:MediaQuery.sizeOf(context).width,
                            titleAppBar: S.of(context).medicalPatientFileText,
                            assetBackgroundImage:"assets/container_home_page/title appBar.png",
                          ),

                          /// body
                          SafeArea(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: screenHeight * 0.1133,
                                start:screenWidth* 0.0327,
                                end: screenWidth* 0.0327,
                                bottom: screenHeight * 0.03,
                              ),
                              child: Container(
                                width: screenWidth,
                                height: screenHeight * (1.884+0.03),
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
                                  padding:EdgeInsetsDirectional.only(
                                    top:screenHeight * 0.03,
                                    start:screenWidth * 0.0443,
                                    end:screenWidth * 0.0443,
                                  ),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        ///header of page
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            defaultText(
                                                text: S.of(context).medicalPatientFileText,
                                                fontFamily: "Roboto",
                                                textHeight: 1.333,
                                                fontSize: 30,
                                                alignment: AlignmentDirectional.center,
                                                color: Color(0xff707070),
                                                height:screenHeight * 0.042,
                                                context: context),
                                            TextButton(
                                                onPressed: () async{
                                                  if(formKey.currentState!.validate()){
                                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                                    if(hasInternet){
                                                      showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                      MedicalHistoryModel model=MedicalHistoryModel(
                                                        vaccine: getVaccinations(context: context),
                                                        coronavirus:getCoronaVirusVaccine(context: context),
                                                        allergies: getAllergies(context:context),
                                                        regularly: getRegularly(context: context),
                                                        insurance:getInsurance(context: context),
                                                        // gallery:cubit.files,
                                                        expiryDate: medicalExpiryDateController.text,
                                                        medicalHistory: medicalHistoryController.text,
                                                        medicalProblems: medicalProblemsController.text,
                                                        insuranceCompanyName: medicalCompanyNameController.text,
                                                        policyNumber: medicalPolicyNumberController.text,
                                                        // galleryPost: cubit.files,
                                                      );
                                                      if(cubit.files!.length != 0 ){
                                                        var formData =FormData();
                                                        for(int i=0;i<cubit.files!.length;i++){
                                                          formData.files.add(MapEntry("gallery[]",  await MultipartFile.fromFile(
                                                            cubit.files![i].path,
                                                            contentType: MediaType("multipart/*","text/plain"),
                                                          ) ));
                                                        }
                                                        cubit.updateImageMedicalProfile(
                                                          context: context,
                                                          formData: formData,
                                                        ).then((value){
                                                          cubit.updateMedicalProfile(model: model).then((value){
                                                            ///complete on state
                                                          });
                                                        });

                                                      }
                                                      else{
                                                        cubit.updateMedicalProfile(model: model).then((value){
                                                          ///complete on state
                                                        });
                                                      }
                                                    }else{
                                                      showSnackBar(context: context, text: S.current.failedConnection);
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  S.of(context).saveText,
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
                                            defaultText(
                                                text: S.of(context).vaccinationMedicalPatient,
                                                height:screenHeight * 0.02591,
                                                color: Color(0xff707070),
                                                fontSize: 18,
                                                textHeight: 1.333,
                                                fontFamily: "Roboto",
                                                boxFit: BoxFit.fitHeight,
                                                context: context),
                                            SizedBox(
                                              height:screenHeight * 0.0172,
                                            ),

                                            InkWell(
                                              onTap: ()async{

                                                if(cubit.shownButtonSheet){
                                                  cubit.changeButtonSheet(isShow: false);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }else{
                                                  await showVaccinationButtonSheet(context: context);
                                                  cubit.changeButtonSheet(isShow: true);
                                                }
                                              },
                                              child:Container(
                                                height: screenHeight *0.0583,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: defaultBlueAccentColor
                                                    )
                                                ),
                                                child: Padding(
                                                  padding:EdgeInsetsDirectional.only(
                                                    start: screenWidth * 0.0373,
                                                    end: screenWidth * 0.0373,
                                                    top:screenHeight * 0.0151,
                                                    bottom:screenHeight * 0.0172,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      defaultText(
                                                          text: S.of(context).selectProblemText,
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      cubit.openedDownListVaccination==false?Icon(Icons.arrow_drop_down_sharp):
                                                      Icon(Icons.arrow_drop_up),
                                                    ],
                                                  ),
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
                                            defaultText(
                                                text: S.of(context).askIfUserHaveCoronaVirusVaccine,
                                                height:screenHeight * 0.02591,
                                                color: Color(0xff707070),
                                                fontSize: 18,
                                                textHeight: 1.333,
                                                fontFamily: "Roboto",
                                                boxFit: BoxFit.fitHeight,
                                                context: context),
                                            SizedBox(
                                              height:screenHeight * 0.0237,
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      cubit.onChangeCoronaVirus(index: 0);
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width:screenWidth * 0.0607,
                                                            child: Checkbox.adaptive(
                                                              // activeColor:Color(0xff707070),
                                                              hoverColor: null,
                                                              shape: CircleBorder(),
                                                              value:cubit.valueOfCoronaVirus![0],
                                                              onChanged: (check){
                                                                print(cubit.valueOfCoronaVirus![0]);
                                                                print("yes"+check.toString());
                                                                cubit.onChangeCoronaVirus(index: 0);
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: screenWidth *0.0186,),
                                                          defaultText(
                                                              text: S.of(context).yes_button_text,
                                                              height: screenHeight * 0.028,
                                                              width: screenWidth *0.0560,
                                                              color: Color(0xff707070),
                                                              fontSize: 18,
                                                              textHeight: 1.333,
                                                              alignment: AlignmentDirectional.centerStart,
                                                              textAlign: TextAlign.start,
                                                              fontFamily: "Roboto",
                                                              boxFit: BoxFit.fitHeight,
                                                              context: context),
                                                        ],
                                                      ),
                                                      height:screenHeight * 0.0280,
                                                      width:screenWidth * 0.1495,
                                                    ),
                                                  ),
                                                  SizedBox(width: screenWidth *0.1098),
                                                  InkWell(
                                                    onTap: (){
                                                      cubit.onChangeCoronaVirus(index: 1);
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width:screenWidth * 0.0607,
                                                            child: Checkbox.adaptive(
                                                              shape: CircleBorder(),
                                                              value:cubit.valueOfCoronaVirus![1]==true?true:false,
                                                              onChanged: (check){
                                                                print(cubit.valueOfCoronaVirus![1]);
                                                                print("no"+check.toString());
                                                                cubit.onChangeCoronaVirus(index: 1);
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: screenWidth *0.0186,),
                                                          defaultText(
                                                              text: S.of(context).no_button_text,
                                                              height: screenHeight * 0.028,
                                                              width: screenWidth *0.0560,
                                                              color: Color(0xff707070),
                                                              fontSize: 18,
                                                              textHeight: 1.333,
                                                              alignment: AlignmentDirectional.centerStart,
                                                              textAlign: TextAlign.start,
                                                              fontFamily: "Roboto",
                                                              boxFit: BoxFit.fitHeight,
                                                              context: context),
                                                        ],
                                                      ),
                                                      height:screenHeight * 0.0280,
                                                      width:screenWidth * 0.1495,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              width: screenWidth,
                                              height: screenHeight * 0.0280,
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height:screenHeight * 0.0237,
                                        ),

                                        ///Significant Medical History
                                        Column(
                                          children: [
                                            defaultText(
                                                text: S.of(context).medicalHistoryMedicalPatient,
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

                                            defaultTextFormField(
                                              context: context,
                                              height:screenHeight * 0.1447,
                                              isExpanded: true,
                                              hint: cubit.medicalHistoryModel!.medicalHistory??S.of(context).nullText,
                                              controller:medicalHistoryController,
                                              keyboardType:TextInputType.text,
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: screenHeight * 0.0129,
                                        ),

                                        /// Medical Problems
                                        Column(
                                          children: [
                                            defaultText(
                                                text: S.of(context).medicalProblemsMedicalPatient,
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
                                            defaultTextFormField(
                                                context: context,
                                                height:screenHeight * 0.1447,
                                                isExpanded: true,
                                                hint: cubit.medicalHistoryModel!.medicalProblems??S.of(context).nullText,
                                                controller:medicalProblemsController,
                                                keyboardType:TextInputType.text
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: screenHeight * 0.0377,
                                        ),

                                        ///List any medication taken regularly
                                        Column(
                                          children: [
                                            defaultText(
                                                text: S.of(context).regularlyMedicalPatient,
                                                height:screenHeight * 0.02591,
                                                color: Color(0xff707070),
                                                fontSize: 18,
                                                textHeight: 1.333,
                                                fontFamily: "Roboto",
                                                boxFit: BoxFit.fitHeight,
                                                context: context),
                                            SizedBox(
                                              height:screenHeight * 0.0172,
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                if(cubit.shownButtonSheet){
                                                  cubit.changeButtonSheet(isShow: false);
                                                  Navigator.pop(context);
                                                }else{
                                                  await showRegularlyButtonSheet(context: context);
                                                  cubit.changeButtonSheet(isShow: true);
                                                }
                                              },
                                              child: Container(
                                                height: screenHeight *0.0583,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: defaultBlueAccentColor
                                                    )
                                                ),
                                                child: Padding(
                                                  padding:EdgeInsetsDirectional.only(
                                                    start: screenWidth * 0.0373,
                                                    end: screenWidth * 0.0373,
                                                    top:screenHeight * 0.0151,
                                                    bottom:screenHeight * 0.0172,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      defaultText(
                                                          text: S.of(context).selectProblemText,
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      cubit.openedDownListVaccination==false?Icon(Icons.arrow_drop_down_sharp):
                                                      Icon(Icons.arrow_drop_up),
                                                    ],
                                                  ),
                                                ),
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
                                            defaultText(
                                                text: S.of(context).allergiesMedicalPatient,
                                                height:screenHeight * 0.02591,
                                                color: Color(0xff707070),
                                                fontSize: 18,
                                                textHeight: 1.333,
                                                fontFamily: "Roboto",
                                                boxFit: BoxFit.fitHeight,
                                                context: context),
                                            SizedBox(
                                              height:screenHeight * 0.0172,
                                            ),
                                            InkWell(
                                              onTap: ()async{
                                                if(cubit.shownButtonSheet){
                                                  cubit.changeButtonSheet(isShow: false);
                                                  Navigator.pop(context);
                                                }else{
                                                  await showAllergiesButtonSheet(context: context);
                                                  cubit.changeButtonSheet(isShow: true);
                                                }
                                              },
                                              child: Container(
                                                height: screenHeight *0.0583,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: defaultBlueAccentColor
                                                    )
                                                ),
                                                child: Padding(
                                                  padding:EdgeInsetsDirectional.only(
                                                    start: screenWidth * 0.0373,
                                                    end: screenWidth * 0.0373,
                                                    top:screenHeight * 0.0151,
                                                    bottom:screenHeight * 0.0172,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      defaultText(
                                                          text: S.of(context).selectProblemText,
                                                          height:screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      cubit.openedDownListVaccination==false?Icon(Icons.arrow_drop_down_sharp):
                                                      Icon(Icons.arrow_drop_up),
                                                    ],
                                                  ),
                                                ),
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
                                            text: S.of(context).medicalInsuranceDetailsMedicalPatient,
                                            alignment: AlignmentDirectional.center,
                                            fontFamily: "Roboto",
                                            textHeight: 1.333,
                                            fontSize: 30,
                                            color: Color(0xff707070),
                                            height:screenHeight * 0.042,
                                            context: context
                                        ),

                                        SizedBox(
                                          height: screenHeight * 0.0161,
                                        ),

                                        /// Do you have medical insurance?
                                        Column(
                                          children: [
                                            defaultText(
                                                text: S.of(context).insuranceMedicalPatient,
                                                height:screenHeight * 0.02591,
                                                color: Color(0xff707070),
                                                fontSize: 18,
                                                textHeight: 1.333,
                                                fontFamily: "Roboto",
                                                boxFit: BoxFit.fitHeight,
                                                context: context),
                                            SizedBox(
                                              height:screenHeight * 0.0237,
                                            ),
                                            Container(
                                              width: screenWidth,
                                              height: screenHeight * 0.0280,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      cubit.onChangeMedicalInsurance(index: 0);
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width:screenWidth * 0.0607,
                                                            child: Checkbox.adaptive(
                                                              // activeColor:Color(0xff707070),
                                                              // hoverColor: null,
                                                              shape: CircleBorder(),
                                                              // groupValue: cubit.valueOfCoronaViruse[0],
                                                              value:cubit.valueOfMedicalInsurance![0],
                                                              onChanged: (check){
                                                                cubit.onChangeMedicalInsurance(index: 0);
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: screenWidth *0.0186,),
                                                          defaultText(
                                                              text: S.of(context).yes_button_text,
                                                              height: screenHeight * 0.028,
                                                              width: screenWidth *0.0560,
                                                              color: Color(0xff707070),
                                                              fontSize: 18,
                                                              textHeight: 1.333,
                                                              alignment: AlignmentDirectional.centerStart,
                                                              textAlign: TextAlign.start,
                                                              fontFamily: "Roboto",
                                                              boxFit: BoxFit.fitHeight,
                                                              context: context),
                                                        ],
                                                      ),
                                                      height:screenHeight * 0.0280,
                                                      width:screenWidth * 0.1495,
                                                    ),
                                                  ),
                                                  SizedBox(width: screenWidth *0.1098),
                                                  InkWell(
                                                    onTap: (){
                                                      cubit.onChangeMedicalInsurance(index: 1);
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width:screenWidth * 0.0607,
                                                            child: Checkbox.adaptive(
                                                              // activeColor:Color(0xff707070),
                                                              shape: CircleBorder(),
                                                              // groupValue: cubit.valueOfCoronaViruse[1]?true:false,
                                                              value:cubit.valueOfMedicalInsurance![1]==true?true:false,
                                                              onChanged: (check){
                                                                cubit.onChangeMedicalInsurance(index: 1);
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(width: screenWidth *0.0186,),
                                                          defaultText(
                                                              text: S.of(context).no_button_text,
                                                              height: screenHeight * 0.028,
                                                              width: screenWidth *0.0560,
                                                              color: Color(0xff707070),
                                                              fontSize: 18,
                                                              textHeight: 1.333,
                                                              alignment: AlignmentDirectional.centerStart,
                                                              textAlign: TextAlign.start,
                                                              fontFamily: "Roboto",
                                                              boxFit: BoxFit.fitHeight,
                                                              context: context),
                                                        ],
                                                      ),
                                                      height:screenHeight * 0.0280,
                                                      width:screenWidth * 0.1495,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),

                                        SizedBox(
                                          height:screenHeight * 0.0172,
                                        ),

                                        /// Insurance company name
                                        Column(
                                          children: [
                                            defaultText(
                                              text: S.of(context).companyNameMedicalPatient,
                                              height:screenHeight * 0.02591,
                                              color: Color(0xff707070),
                                              fontSize: 18,
                                              textHeight: 1.333,
                                              fontFamily: "Roboto",
                                              boxFit: BoxFit.fitHeight,
                                              context: context,
                                            ),
                                            SizedBox(
                                              height:screenHeight * 0.0172,
                                            ),

                                            defaultTextFormField(
                                              context: context,
                                              hint: cubit.medicalHistoryModel!.insuranceCompanyName,
                                              onChange: (value){
                                                if(value!="")
                                                  cubit.onChangeMedicalInsurance(index: 0);
                                              },
                                              onValidate: (value){
                                                if ((medicalPolicyNumberController.text!="" || medicalExpiryDateController.text!=""|| cubit.valueOfMedicalInsurance![0]==true) && medicalCompanyNameController.text == "") {
                                                  return  S.of(context).validateOfInsurance;
                                                }
                                                return null;
                                              },
                                              controller:medicalCompanyNameController,
                                              keyboardType:TextInputType.text,
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height:screenHeight * 0.0172,
                                        ),

                                        /// Policy Number
                                        Column(
                                          children: [
                                            defaultText(
                                                text: S.of(context).policyNumberMedicalPatient,
                                                height:screenHeight * 0.02591,
                                                color: Color(0xff707070),
                                                fontSize: 18,
                                                textHeight: 1.333,
                                                fontFamily: "Roboto",
                                                boxFit: BoxFit.fitHeight,
                                                context: context),
                                            SizedBox(
                                              height:screenHeight * 0.0172,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                                child: defaultTextFormField(
                                                    context: context,
                                                    hint: cubit.medicalHistoryModel!.policyNumber??"231497",
                                                    onValidate: (value){
                                                      if ((medicalCompanyNameController.text!="" ||cubit.valueOfMedicalInsurance![0]==true||medicalExpiryDateController.text!="" )&& medicalPolicyNumberController.text== "") {
                                                        return  S.of(context).validateOfPolicyNumber;
                                                      }
                                                      return null;
                                                    },
                                                    onChange: (value){
                                                      if(value!="")
                                                        cubit.onChangeMedicalInsurance(index: 0);
                                                    },
                                                    controller:medicalPolicyNumberController,
                                                    keyboardType:TextInputType.number),),
                                          ],
                                        ),

                                        SizedBox(
                                          height:screenHeight * 0.0172,
                                        ),

                                        /// Expiry Date
                                        Column(
                                          children: [
                                            defaultText(
                                                text: S.of(context).expiryDateText,
                                                height:screenHeight * 0.02591,
                                                color: Color(0xff707070),
                                                fontSize: 18,
                                                textHeight: 1.333,
                                                fontFamily: "Roboto",
                                                boxFit: BoxFit.fitHeight,
                                                context: context),
                                            SizedBox(
                                              height:screenHeight * 0.0172,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: InkWell(
                                                onTap: () async{
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate:DateTime(2010),
                                                      initialEntryMode: DatePickerEntryMode.calendar,
                                                      initialDatePickerMode: DatePickerMode.day,
                                                      lastDate:DateTime(2040)).then((value){
                                                    medicalExpiryDateController.text="${value!.month}/${value.day}/${value.year}";
                                                  },
                                                  );
                                                },
                                                child:defaultTextFormField(
                                                    context:context,
                                                    isEnable: false,
                                                    hint: cubit.medicalHistoryModel!.expiryDate??"mm/dd/yyyy",
                                                    onValidate: (value){
                                                      if ((medicalCompanyNameController.text!="" || medicalPolicyNumberController.text!="" || cubit.valueOfMedicalInsurance![0]==true) && medicalExpiryDateController.text== "") {
                                                        return  S.of(context).validateOfExpiryDate;
                                                      }
                                                      return null;
                                                    },
                                                    onChange: (value){
                                                      if(value!="")
                                                        cubit.onChangeMedicalInsurance(index: 0);
                                                    },
                                                    suffixIconSvg: "assets/svgIcons/pickDate.png",
                                                    controller:medicalExpiryDateController,
                                                    keyboardType:TextInputType.datetime),
                                              ),
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
                                                text: S.of(context).filesMedicalPatient,
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
                                              onTap: ()async{
                                                await cubit.pickFilesFromGallery().then((value){

                                                });


                                              },
                                              child: Container(
                                                height:screenHeight * 0.1965,
                                                width: screenWidth,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    color: defaultWhiteColor,
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    border: Border.all(
                                                      color:defaultBlueAccentColor,
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                      strokeAlign: BorderSide.strokeAlignOutside,
                                                    )
                                                ),
                                                child:cubit.files!.length != 0?
                                                CarouselSlider(
                                                  items:List.generate(cubit.files!.length,
                                                        (index) => Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                      ),
                                                      width: MediaQuery.sizeOf(context).width* 0.5,
                                                      height: MediaQuery.sizeOf(context).height,
                                                      child: Image(image: FileImage(File(cubit.files![index].path)),fit:BoxFit.fill),
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
                                                  child:Center(
                                                    child: Text(
                                                      S.of(context).clickToBrowsePatientButton,
                                                      textAlign: TextAlign.center,
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
                                          height:screenHeight * 0.0194,
                                        ),

                                        ///buttons(save - cancel)
                                        Expanded(
                                          child: Row(
                                            children: [

                                              ///Save changes
                                              Expanded(
                                                child:defaultMaterialButton(
                                                  height: screenHeight * 0.0583,
                                                  context: context,
                                                  backgroundColor:defaultBlueAccentColor,
                                                  textColor:defaultWhiteColor,
                                                  text:S.of(context).saveChangesText,
                                                  onPress: ()async{
                                                    if(formKey.currentState!.validate()){
                                                      bool hasInternet=await NetworkConnection.getConnectivity();
                                                      if(hasInternet){
                                                        showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                        MedicalHistoryModel model=MedicalHistoryModel(
                                                          vaccine: getVaccinations(context: context),
                                                          coronavirus:getCoronaVirusVaccine(context: context),
                                                          allergies: getAllergies(context:context),
                                                          regularly: getRegularly(context: context),
                                                          insurance:getInsurance(context: context),
                                                          // gallery:cubit.files,
                                                          expiryDate: medicalExpiryDateController.text,
                                                          medicalHistory: medicalHistoryController.text,
                                                          medicalProblems: medicalProblemsController.text,
                                                          insuranceCompanyName: medicalCompanyNameController.text,
                                                          policyNumber: medicalPolicyNumberController.text,
                                                          // galleryPost: cubit.files,
                                                        );
                                                        if(cubit.files!.length != 0 ){
                                                          var formData =FormData();
                                                          for(int i=0;i<cubit.files!.length;i++){
                                                            formData.files.add(MapEntry("gallery[]",  await MultipartFile.fromFile(
                                                              cubit.files![i].path,
                                                              contentType: MediaType("multipart/*","text/plain"),
                                                            ) ));
                                                          }
                                                          cubit.updateImageMedicalProfile(
                                                            context: context,
                                                            formData: formData,
                                                          ).then((value){
                                                            cubit.updateMedicalProfile(model: model).then((value){
                                                              ///complete on state
                                                            });
                                                          });

                                                        }
                                                        else{
                                                          cubit.updateMedicalProfile(model: model).then((value){
                                                            ///complete on state
                                                          });
                                                        }
                                                      }else{
                                                        showSnackBar(context: context, text: S.current.failedConnection);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),

                                              SizedBox(
                                                width: screenWidth * 0.0443,
                                              ),

                                              ///cancel
                                              Expanded(
                                                child:defaultMaterialButton(
                                                  height: screenHeight * 0.0583,
                                                  context: context,
                                                  backgroundColor:Color(0xffFE1F8F),
                                                  textColor:defaultWhiteColor,
                                                  text:S.of(context).cancelButtonText,
                                                  onPress: (){
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height:screenHeight * 0.0161,
                                        ),

                                      ],
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
                ),
              ),
              /// navBar
              bottomNavigationBar: appNavBarFixed(context: context),
              extendBodyBehindAppBar: true,
              extendBody: true,
            );
          },
        );
      },
    );


  }

  ///get allergies
  List<String> getAllergies({
    required BuildContext context,
}){
    allAllergies=[];
    for(int i=0;i<HomeCubit.get(context).allAllergies.length;i++){
      if(HomeCubit.get(context).allAllergies[i].check==true){
        allAllergies.add("${HomeCubit.get(context).allAllergies[i].id}");
      }
    }
    return allAllergies;
  }

  ///initialize allergies
  setAllergies({
    required BuildContext context,
  }){
    for(int i=0;i<HomeCubit.get(context).allAllergies.length;i++){
      for(int n=0;n<HomeCubit.get(context).medicalHistoryModel!.allergies!.length;n++) {
        int id=int.parse(HomeCubit.get(context).medicalHistoryModel!.allergies![n]);
        if (HomeCubit.get(context).allAllergies[i].id == id) {
          HomeCubit.get(context).onChangeStateOFUserAllergies(index: i,check: true);
        }
      }
    }
  }

  ///get vaccination
  List<String> getVaccinations({
    required BuildContext context,
  }){
    allVaccinations=[];
    for(int i=0;i<HomeCubit.get(context).allVaccinations.length;i++){
      if(HomeCubit.get(context).allVaccinations[i].check==true){
        allVaccinations.add("${HomeCubit.get(context).allVaccinations[i].id}");
      }
    }
    return allVaccinations;
  }

  ///initialize vaccine
  setVaccine({
    required BuildContext context,
  }){
    for(int i=0;i<HomeCubit.get(context).allVaccinations.length;i++){
      for(int n=0;n<HomeCubit.get(context).medicalHistoryModel!.vaccine!.length;n++) {
        int id=int.parse(HomeCubit.get(context).medicalHistoryModel!.vaccine![n]);
        if (HomeCubit.get(context).allVaccinations[i].id == id) {
          HomeCubit.get(context).onChangeStateOFUserVaccination(index: i,check: true);
        }
      }
    }
  }

  ///get regularly
  List<String> getRegularly({
    required BuildContext context,
  }){
    allRegularly=[];
    for(int i=0;i<HomeCubit.get(context).allRegularly.length;i++){
      if(HomeCubit.get(context).allRegularly[i].check==true){
        allRegularly.add("${HomeCubit.get(context).allRegularly[i].id}");
      }
    }
    return allRegularly;
  }

  ///initialize regularly
  setRegularly({
    required BuildContext context,
  }){
    for(int i=0;i<HomeCubit.get(context).allRegularly.length;i++){
      for(int n=0;n<HomeCubit.get(context).medicalHistoryModel!.regularly!.length;n++) {
        int id=int.parse(HomeCubit.get(context).medicalHistoryModel!.regularly![n]);
        if (HomeCubit.get(context).allRegularly[i].id == id) {
          HomeCubit.get(context).onChangeStateOFUserRegularly(index: i,check: true);
        }
      }
    }
  }

  ///get insurance from api
  String? getInsurance({
    required BuildContext context,
  }){
    String? insurance;
      if(HomeCubit.get(context).valueOfMedicalInsurance![0]==true){
        insurance="Yes";
      }else{
        insurance="no";
      }

    return insurance;
  }

  ///get corona virus vaccine from api
  String? getCoronaVirusVaccine({
    required BuildContext context,
  }){
    String? vaccine;
    if(HomeCubit.get(context).valueOfCoronaVirus![0]==true){
      vaccine="Yes";
    }else{
      vaccine="No";
    }

    return vaccine;
  }

  ///initialize corona virus vaccine
  setCoronaVirusVaccine({
    required BuildContext context,
  }){
    if(HomeCubit.get(context).medicalHistoryModel!.coronavirus!=null){
      if(HomeCubit.get(context).medicalHistoryModel!.coronavirus!.contains("Yes")){
        HomeCubit.get(context).onChangeCoronaVirus(index: 0);
      }else{
        HomeCubit.get(context).onChangeCoronaVirus(index: 1);
      }
    }
  }

  ///initialize insurance
  setInsurance({
    required BuildContext context,
  }){
    if(HomeCubit.get(context).medicalHistoryModel!.insurance!=null){
      if(HomeCubit.get(context).medicalHistoryModel!.insurance!.contains("Yes")){
        HomeCubit.get(context).onChangeMedicalInsurance(index: 0);
      }else{
        HomeCubit.get(context).onChangeMedicalInsurance(index: 1);
      }
    }


  }

  ///initialization of controllers with its value from api
  checkControllers({
    required BuildContext context,
}){
    var cubit=HomeCubit.get(context);
    if(cubit.medicalHistoryModel!.medicalHistory!=null)
      medicalHistoryController.text=cubit.medicalHistoryModel!.medicalHistory!;
    if(cubit.medicalHistoryModel!.medicalProblems!=null)
      medicalProblemsController.text=cubit.medicalHistoryModel!.medicalProblems!;
    if(cubit.medicalHistoryModel!.insuranceCompanyName!=null)
      medicalCompanyNameController.text=cubit.medicalHistoryModel!.insuranceCompanyName!;
    if(cubit.medicalHistoryModel!.policyNumber!=null)
      medicalPolicyNumberController.text=cubit.medicalHistoryModel!.policyNumber!;
    if(cubit.medicalHistoryModel!.expiryDate!=null)
      medicalExpiryDateController.text=cubit.medicalHistoryModel!.expiryDate!;

  }

  ///show Vaccination Button Sheet
  showVaccinationButtonSheet({
    required BuildContext context,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => vaccinationButtonSheet(context: context),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(milliseconds: 1000)),).closed.then((value)async{
      HomeCubit.get(context).changeButtonSheet(isShow: false);
    });
  }

  ///Vaccination Button Sheet
  vaccinationButtonSheet({
    required BuildContext context,
  }){
    return Container(
      height:screenHeight * 0.82,
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
          top:screenHeight *  0.0302375809935205,
          bottom:screenHeight *  0.01835,
          end:screenWidth * 0.02336,
          start:screenWidth *  0.02336,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultText(
                    text: S.of(context).selectMedicationVaccinations,
                    color: defaultGreyColor,
                    height: screenHeight * 0.0313,
                    textAlign: TextAlign.center,
                    fontSize: 22,
                    alignment: AlignmentDirectional.center,
                    textHeight: 1.3181,
                    fontFamily: "Roboto",
                    context: context),
                TextButton(
                    onPressed: () {
                    Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).saveText,
                      style: TextStyle(
                          fontSize: 20
                      ),)
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02807),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => defaultVaccinationContainer(model: HomeCubit.get(context).allVaccinations[index],index: index,context:context),
                  separatorBuilder: (context, index) => SizedBox(
                    height: screenHeight * 0.01511,
                  ),
                  // shrinkWrap: true,
                  itemCount: HomeCubit.get(context).allVaccinations.length),
            ),
          ],
        ),
      ),
    );
  }

  ///default item in Vaccination Button Sheet
  Widget defaultVaccinationContainer({
    required MedicalSettingModel model,
    required int index,
    required BuildContext context,

  }){
    return InkWell(
      onTap: (){
        HomeCubit.get(context).onChangeStateOFUserVaccination(index: index);
      },
      child: Container(
        // height: screenHeight * 0.06479,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: defaultBlackColor.withAlpha(35),
                blurRadius: 15,
                blurStyle: BlurStyle.outer
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start:screenWidth * 0.07476,
            end:screenWidth * 0.03738,
            bottom:screenHeight * 0.01619,
            top:screenHeight * 0.01619,
          ),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    model.name!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color:defaultBlackColor,
                      height: 1.333,
                      fontFamily: "Roboto"
                    ),
                    maxLines: 3,
              ),
              ),

              BlocConsumer<HomeCubit,HomeStates>(builder:(context, state) {
                return Checkbox.adaptive(
                    value: HomeCubit.get(context).allVaccinations[index].check,
                    shape: CircleBorder(),
                    activeColor: Color(0xff1BDFFE),
                    side:HomeCubit.get(context).allVaccinations[index].check!?
                    BorderSide(color: defaultBlueAccentColor,
                      width: 3,
                    ):
                    BorderSide(color: Color(0xff8F8F8F),
                      width: 3,
                    ),
                    onChanged: (checked){
                      HomeCubit.get(context).onChangeStateOFUserVaccination(index: index,check: checked);
                    });
              }, listener: (context, state) {

              },)
            ],
          ),
        ),
      ),
    );
  }

  ///show Allergies Button Sheet
  showAllergiesButtonSheet({
    required BuildContext context,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => allergiesButtonSheet(context: context),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 1)),).closed.then((value)async{
      HomeCubit.get(context).changeButtonSheet(isShow: false);
    });
  }

  ///allergies Button Sheet
  allergiesButtonSheet({
    required BuildContext context,
  }){
    return Container(
      height:screenHeight * 0.82,
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
          top:screenHeight *  0.0302375809935205,
          bottom:screenHeight *  0.01835,
          end:screenWidth * 0.02336,
          start:screenWidth *  0.02336,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultText(
                    text: S.of(context).selectMedicationAllergies,
                    color: defaultGreyColor,
                    height: screenHeight * 0.0313,
                    textAlign: TextAlign.center,
                    fontSize: 22,
                    alignment: AlignmentDirectional.center,
                    textHeight: 1.3181,
                    fontFamily: "Roboto",
                    context: context),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).saveText,
                      style: TextStyle(
                          fontSize: 20
                      ),)
                ),
              ],
            ),
            // Container(
            //   height: screenHeight * 0.0313,
            //   child: Stack(
            //     children: [
            //       defaultText(
            //           text: S.of(context).selectMedicationAllergies,
            //           color: defaultGreyColor,
            //           height: screenHeight * 0.0313,
            //           textAlign: TextAlign.center,
            //           fontSize: 22,
            //           alignment: AlignmentDirectional.center,
            //           textHeight: 1.3181,
            //           fontFamily: "Roboto",
            //           context: context),
            //     ],
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.02807),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => defaultAllergiesContainer(model: HomeCubit.get(context).allAllergies[index],index: index,context:context),
                  separatorBuilder: (context, index) => SizedBox(
                    height: screenHeight * 0.01511,
                  ),
                  itemCount: HomeCubit.get(context).allAllergies.length),
            ),
          ],
        ),
      ),
    );
  }

  ///default item in Allergies Button Sheet
  Widget defaultAllergiesContainer({
    required MedicalSettingModel model,
    required int index,
    required BuildContext context,

  }){
    return InkWell(
      onTap: (){
        HomeCubit.get(context).onChangeStateOFUserAllergies(index: index);
        // Navigator.pop(context);
      },
      child: Container(
        // height: screenHeight * 0.06479,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: defaultBlackColor.withAlpha(35),
                blurRadius: 15,
                blurStyle: BlurStyle.outer
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start:screenWidth * 0.07476,
            end:screenWidth * 0.03738,
            bottom:screenHeight * 0.01619,
            top:screenHeight * 0.01619,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  model.name!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      color:defaultBlackColor,
                      height: 1.333,
                      fontFamily: "Roboto"
                  ),
                  maxLines: 3,
                ),
              ),
              // defaultText(text:model.name!,
              //     color: defaultBlackColor,
              //     height:screenHeight * 0.0345,
              //     fontSize: 24,
              //     fontFamily: "Roboto",
              //     textHeight: 1.333,
              //     context: context),
              // Spacer(),
              BlocConsumer<HomeCubit,HomeStates>(builder:(context, state) {
                return Checkbox.adaptive(
                    value: HomeCubit.get(context).allAllergies[index].check,
                    shape: CircleBorder(),
                    activeColor: Color(0xffff1BDFFE),
                    side:HomeCubit.get(context).allAllergies[index].check!?
                    BorderSide(color: defaultBlueAccentColor,
                      width: 3,
                    ):
                    BorderSide(color: Color(0xff8F8F8F),
                      width: 3,
                    ),
                    onChanged: (checked){
                      HomeCubit.get(context).onChangeStateOFUserAllergies(index: index,check: checked);
                    });
              }, listener: (context, state) {

              },)
            ],
          ),
        ),
      ),
    );
  }

  ///show Regularly Button Sheet
  showRegularlyButtonSheet({
    required BuildContext context,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => regularlyButtonSheet(context: context),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 1)),).closed.then((value)async{
      HomeCubit.get(context).changeButtonSheet(isShow: false);
    });
  }

  ///Regularly Button Sheet
  regularlyButtonSheet({
    required BuildContext context,
  }){
    return Container(
      height:screenHeight * 0.82,
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
          top:screenHeight *  0.0302375809935205,
          bottom:screenHeight *  0.01835,
          end:screenWidth * 0.02336,
          start:screenWidth *  0.02336,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultText(
                    text: S.of(context).selectMedicationRegularly,
                    color: defaultGreyColor,
                    height: screenHeight * 0.0313,
                    textAlign: TextAlign.center,
                    fontSize: 22,
                    alignment: AlignmentDirectional.center,
                    textHeight: 1.3181,
                    fontFamily: "Roboto",
                    context: context),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).saveText,
                      style: TextStyle(
                          fontSize: 20
                      ),)
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02807),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => defaultRegularlyContainer(model: HomeCubit.get(context).allRegularly[index],index: index,context:context),
                  separatorBuilder: (context, index) => SizedBox(
                    height: screenHeight * 0.01511,
                  ),
                  itemCount: HomeCubit.get(context).allRegularly.length),
            ),
          ],
        ),
      ),
    );
  }

  ///default item in Regularly Button Sheet
  Widget defaultRegularlyContainer({
    required MedicalSettingModel model,
    required int index,
    required BuildContext context,
  }){
    return InkWell(
      onTap: (){
        HomeCubit.get(context).onChangeStateOFUserRegularly(index: index);
      },
      child: Container(
        // height: screenHeight * 0.06479,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: defaultBlackColor.withAlpha(35),
                blurRadius: 15,
                blurStyle: BlurStyle.outer
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start:screenWidth * 0.07476,
            end:screenWidth * 0.03738,
            bottom:screenHeight * 0.01619,
            top:screenHeight * 0.01619,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  model.name!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20,
                      color:defaultBlackColor,
                      height: 1.333,
                      fontFamily: "Roboto"
                  ),
                  maxLines: 3,
                ),
              ),
              // defaultText(text:model.name!,
              //     color: defaultBlackColor,
              //     height:screenHeight * 0.0345,
              //     fontSize: 24,
              //     fontFamily: "Roboto",
              //     textHeight: 1.333,
              //     context: context),
              // Spacer(),
              BlocConsumer<HomeCubit,HomeStates>(builder:(context, state) {
                return Checkbox.adaptive(
                    value: HomeCubit.get(context).allRegularly[index].check,
                    shape: CircleBorder(),
                    activeColor: Color(0xff1BDFFE),
                    side:HomeCubit.get(context).allRegularly[index].check!?
                    BorderSide(color: defaultBlueAccentColor,
                      width: 3,
                    ):
                    BorderSide(color: Color(0xff8F8F8F),
                      width: 3,
                    ),
                    onChanged: (checked){
                      HomeCubit.get(context).onChangeStateOFUserRegularly(index: index,check: checked);
                    });
              }, listener: (context, state) {

              },)
            ],
          ),
        ),
      ),
    );
  }


}
