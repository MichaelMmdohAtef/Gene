import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/generated/l10n.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/patient_model.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';

// ignore: must_be_immutable
class EditPatientInformationScreen extends StatelessWidget {
  EditPatientInformationScreen({super.key});

  late double screenWidth;

  ///weight controller that control value of weight
  TextEditingController weightController=TextEditingController();
  ///height controller that control value of height
  TextEditingController heightController=TextEditingController();
  ///national id controller that control value of national id
  TextEditingController nationalIdController=TextEditingController();
  ///first name controller that control value of first name
  TextEditingController firstNameController=TextEditingController();
  ///last name controller that control value of last name
  TextEditingController lastNameController=TextEditingController();
  ///phone number controller that control value of phone number
  TextEditingController phoneNumberController=TextEditingController();
  ///address controller that control value of address
  TextEditingController addressController=TextEditingController();

  String? socialSituation;
  late double screenHeight;

  ///form controller that control value of form states in my information
  var formKey=GlobalKey<FormState>();

  ///form controller that control value of form states in case of emergency
  var formKey1=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight =MediaQuery.sizeOf(context).height;
    screenWidth =MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        ///initialize controllers with its data from api
        // fillTextFieldsWithData(context: context);
        setSocial(context: context);
        HomeCubit.get(context).changeButtonSheet(isShow: false);
        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {
            // if(state is OnSuccessUpdatePatientModel){
            //   if(state.value.statusCode==200){
            //     Navigator.pop(context);
            //   }
            // }

          },
          builder: (context, state) {
            var cubit=HomeCubit.get(context);
            return Scaffold(
              appBar: statusBar(),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
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
                          titleAppBar: S.of(context).editPatientInformationTitle,
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
                            child: Column(
                              children: [

                                ///container of edit patient information
                                ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: screenHeight*(0.62),maxWidth: screenWidth),
                                  child: Container(
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
                                      padding:EdgeInsetsDirectional.only(
                                        top:screenHeight * 0.0431,
                                        start:screenWidth * 0.0443,
                                        end:screenWidth * 0.0443,
                                      ),
                                      child: Container(
                                        width: screenWidth,
                                        child: Form(
                                          key: formKey1,
                                          child: Column(
                                            children: [
                                              ///header title of page
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).editPatientInformationTitle,
                                                      fontFamily: "Roboto",
                                                      textHeight: 1.333,
                                                      alignment: AlignmentDirectional.center,
                                                      fontSize: 30,
                                                      color: Color(0xff707070),
                                                      height:screenHeight * 0.042,
                                                      context: context),
                                                  TextButton(
                                                      onPressed: () async{
                                                        if(formKey.currentState!.validate()){
                                                          bool hasInternet=await NetworkConnection.getConnectivity();
                                                          if(hasInternet){
                                                            if(socialSituation!=null){
                                                              showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                              PatientInformationModel model=PatientInformationModel(
                                                                weight:weightController.text,
                                                                height:heightController.text,
                                                                socialSituation:socialSituation.toString(),
                                                                nationalID:nationalIdController.text,
                                                                firstname:firstNameController.text,
                                                                lastname: lastNameController.text,
                                                                phoneNumber:phoneNumberController.text,
                                                                address:addressController.text,
                                                              );
                                                              print(model.toJson().toString());
                                                              cubit.updatePatient(model: model,context: context);
                                                            }else{
                                                              showDialog(context: context, builder: (context) => defaultDialog(
                                                                  context: context,
                                                                  text: S.current.validatorToSelectSocialSituation),);
                                                            }

                                                          }
                                                          else{
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
                                              ///weight
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).weightPatientInformation,
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),
                                                  SizedBox(
                                                    height:screenHeight * 0.015,
                                                  ),
                                                  Directionality(textDirection: TextDirection.ltr,
                                                      child: defaultTextFormField(
                                                          context: context,
                                                          height:screenHeight * 0.07,
                                                          hint: "${cubit.patientInformationModel!.weight!=null?cubit.patientInformationModel!.weight:""}",
                                                          onTap: (){

                                                          },
                                                          onChange: (value) {
                                                            weightController.text=value??"";
                                                          },
                                                          controller:weightController,
                                                          keyboardType:TextInputType.number
                                                      ),),

                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              ///height
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).heightPatientInformation,
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),
                                                  SizedBox(
                                                    height:screenHeight * 0.015,
                                                  ),
                                                  Directionality(textDirection: TextDirection.ltr,
                                                      child: defaultTextFormField(
                                                          context: context,
                                                          height:screenHeight * 0.07,
                                                          hint: "${cubit.patientInformationModel!.height!=null?cubit.patientInformationModel!.height:""}",
                                                          onTap: (){

                                                          },
                                                          onChange: (value) {
                                                            heightController.text=value??"";
                                                          },
                                                          controller:heightController,
                                                          keyboardType:TextInputType.number),),

                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              /// Social Situation
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).socialSituationPatientInformation,
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
                                                    child: Container(
                                                      child: PopupMenuButton(
                                                        onOpened: (){
                                                          cubit.onOpenedDownListVaccination(opened: true);
                                                        },
                                                        onCanceled: (){
                                                          cubit.onOpenedDownListVaccination(opened: false);
                                                        },
                                                        onSelected: (index)async{
                                                          socialSituation= cubit.onChangeSocialSituations(index: index,);
                                                          cubit.onOpenedDownListVaccination(opened: false);
                                                        },
                                                        color: defaultWhiteColor,
                                                        elevation: 0,
                                                        splashRadius:15,

                                                        constraints: BoxConstraints(minWidth: screenWidth*0.852,
                                                            minHeight: screenHeight *0.07),
                                                        offset: Offset(0,screenHeight *0.04),
                                                        itemBuilder:(context) =>List.generate(
                                                          cubit.listOfSocialSituations.length,
                                                              (index) => PopupMenuItem(
                                                            child:Container(
                                                              height: screenHeight * 0.0259,
                                                              child:Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  defaultText(
                                                                      text: cubit.listOfSocialSituations[index].name!,
                                                                      height:screenHeight * 0.02591,
                                                                      color: Color(0xff707070),
                                                                      fontSize: 18,
                                                                      textHeight: 1.333,
                                                                      fontFamily: "Roboto",
                                                                      boxFit: BoxFit.fitHeight,
                                                                      context: context),
                                                                  BlocConsumer<HomeCubit,HomeStates>(
                                                                    builder:(context, state) {
                                                                      return Checkbox.adaptive(
                                                                        activeColor:Color(0xff707070) ,
                                                                        hoverColor: null,
                                                                        shape: CircleBorder(),
                                                                        value:cubit.listOfSocialSituations[index].check,
                                                                        onChanged: (check)async{
                                                                          print("vaccination"+check.toString());
                                                                          socialSituation=cubit.onChangeSocialSituations(index: index);
                                                                        },
                                                                      );
                                                                    },
                                                                    listener:(context, state){

                                                                    },),
                                                                ],
                                                              ),
                                                            ),
                                                            value: index,),),
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
                                                                    text: socialSituation!=null?socialSituation!:S.of(context).selectProblemText,
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
                                                        // padding: EdgeInsets.symmetric(horizontal: screenWidth *0.0443),
                                                      ),
                                                      width: screenWidth,
                                                      // * 0.852,
                                                      // height: screenHeight * 0.0583,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              ///national id
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).nationalIdPatientInformation,
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),
                                                  SizedBox(
                                                    height:screenHeight * 0.015,
                                                  ),
                                                  Directionality(textDirection: TextDirection.ltr,
                                                      child: defaultTextFormField(
                                                          context: context,
                                                          height:screenHeight * 0.07,
                                                          hint: "${cubit.patientInformationModel!.nationalID!=null?cubit.patientInformationModel!.nationalID:""}",
                                                          onTap: (){

                                                          },
                                                          onChange: (value) {
                                                            nationalIdController.text=value??"";
                                                          },
                                                          controller:nationalIdController,
                                                          keyboardType:TextInputType.number),),

                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                ///container of emergency
                                ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: screenHeight*(0.56),maxWidth: screenWidth),
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
                                      padding:EdgeInsetsDirectional.only(
                                        top:screenHeight * 0.0431,
                                        start:screenWidth * 0.0443,
                                        end:screenWidth * 0.0443,
                                      ),
                                      child: Container(
                                        width: screenWidth,
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            children: [

                                              ///header title of emergency
                                              defaultText(
                                                text: S.of(context).addressEmergencyTitle,
                                                fontFamily: "Roboto",
                                                textHeight: 1.333,
                                                alignment: AlignmentDirectional.centerStart,
                                                fontSize: 33,
                                                color: Color(0xff707070),
                                                // width:screenWidth * 0.605,
                                                height:screenHeight * 0.042,
                                                context: context,
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              Row(
                                                children: [
                                                  ///First Name
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        defaultText(
                                                            text: S.of(context).emergencyFirstName,
                                                            height:screenHeight * 0.02591,
                                                            color: Color(0xff707070),
                                                            fontSize: 18,
                                                            textHeight: 1.333,
                                                            fontFamily: "Roboto",
                                                            boxFit: BoxFit.fitHeight,
                                                            context: context),
                                                    
                                                        SizedBox(
                                                          height:screenHeight * 0.015,
                                                        ),
                                                    
                                                        defaultTextFormField(
                                                            context: context,
                                                            height:screenHeight * 0.07,
                                                            hint: "${cubit.patientInformationModel!.firstname!=null?cubit.patientInformationModel!.firstname:""}",
                                                            onTap: (){
                                                    
                                                            },
                                                            onChange: (value) {
                                                              firstNameController.text=value.toString();
                                                            },
                                                            controller:firstNameController,
                                                            keyboardType:TextInputType.text),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: screenWidth * 0.03,
                                                  ),

                                                  ///Last Name
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        defaultText(
                                                            text: S.of(context).emergencyLastName,
                                                            height:screenHeight * 0.02591,
                                                            color: Color(0xff707070),
                                                            fontSize: 18,
                                                            textHeight: 1.333,
                                                            fontFamily: "Roboto",
                                                            boxFit: BoxFit.fitHeight,
                                                            context: context),
                                                        SizedBox(
                                                          height:screenHeight * 0.015,
                                                        ),
                                                        defaultTextFormField(
                                                            context: context,
                                                            height:screenHeight * 0.07,
                                                            hint: "${cubit.patientInformationModel!.lastname!=null?cubit.patientInformationModel!.lastname:""}",
                                                            onTap: (){
                                                    
                                                            },
                                                            onChange: (value) {
                                                              lastNameController.text=value.toString();
                                                            },
                                                            controller:lastNameController,
                                                            keyboardType:TextInputType.text),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),



                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              ///phone number
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).phoneText,
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),
                                                  SizedBox(
                                                    height:screenHeight * 0.015,
                                                  ),
                                                  Directionality(textDirection: TextDirection.ltr,
                                                      child: defaultTextFormField(
                                                          context: context,
                                                          height:screenHeight * 0.07,
                                                          hint: "${cubit.patientInformationModel!.phoneNumber!=null?cubit.patientInformationModel!.phoneNumber:""}",
                                                          onTap: (){

                                                          },
                                                          onChange: (value) {
                                                            phoneNumberController.text=value.toString();
                                                          },
                                                          controller:phoneNumberController,
                                                          keyboardType:TextInputType.number),),

                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              ///Address
                                              Column(
                                                children: [
                                                  defaultText(
                                                      text: S.of(context).addressText,
                                                      height:screenHeight * 0.02591,
                                                      color: Color(0xff707070),
                                                      fontSize: 18,
                                                      textHeight: 1.333,
                                                      fontFamily: "Roboto",
                                                      boxFit: BoxFit.fitHeight,
                                                      context: context),
                                                  SizedBox(
                                                    height:screenHeight * 0.015,
                                                  ),
                                                  defaultTextFormField(
                                                      context: context,
                                                      height:screenHeight * 0.07,
                                                      hint: "${cubit.patientInformationModel!.address!=null?cubit.patientInformationModel!.address:""}",
                                                      onTap: (){

                                                      },
                                                      onChange: (value) {
                                                        addressController.text=value.toString();
                                                      },
                                                      controller:addressController,
                                                      keyboardType:TextInputType.text),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0129,
                                              ),

                                              ///buttons (save changes - cancel)
                                              Row(
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
                                                            if(socialSituation!=null){
                                                              showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                              PatientInformationModel model=PatientInformationModel(
                                                                weight:weightController.text,
                                                                height:heightController.text,
                                                                socialSituation:socialSituation.toString(),
                                                                nationalID:nationalIdController.text,
                                                                firstname:firstNameController.text,
                                                                lastname: lastNameController.text,
                                                                phoneNumber:phoneNumberController.text,
                                                                address:addressController.text,
                                                              );
                                                              print(model.toJson().toString());
                                                              cubit.updatePatient(model: model,context: context);
                                                            }else{
                                                              showDialog(context: context, builder: (context) => defaultDialog(
                                                                  context: context,
                                                                  text: S.current.validatorToSelectSocialSituation),);
                                                            }

                                                          }
                                                          else{
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
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              /// navBar
              bottomNavigationBar: appNavBarFixed(context: context),
              extendBody: true,
            );
          },
        );
      },
    );


  }

  ///fill field with it data
  fillTextFieldsWithData({
    required BuildContext context,
  }){
    var cubit=HomeCubit.get(context);
    if(cubit.patientInformationModel!=null){
      if (cubit.patientInformationModel!.weight != null) {
        weightController.text = cubit.patientInformationModel!.weight!;
      }
      if (cubit.patientInformationModel!.height != null) {
        heightController.text = cubit.patientInformationModel!.height!;
      }
      if (cubit.patientInformationModel!.nationalID != null) {
        nationalIdController.text = cubit.patientInformationModel!.nationalID!;
      }
      if (cubit.patientInformationModel!.firstname != null) {
        firstNameController.text = cubit.patientInformationModel!.firstname!;
      }
      if (cubit.patientInformationModel!.lastname != null) {
        lastNameController.text = cubit.patientInformationModel!.lastname!;
      }
      if (cubit.patientInformationModel!.phoneNumber != null) {
        phoneNumberController.text =
            cubit.patientInformationModel!.phoneNumber!;
      }
      if (cubit.patientInformationModel!.address != null) {
        addressController.text = cubit.patientInformationModel!.address!;
      }
    }
  }

  ///initial selection of social
  setSocial({
    required BuildContext context,
  }){
    if(HomeCubit.get(context).patientInformationModel!=null && HomeCubit.get(context).patientInformationModel!.socialSituation!=null){
      for(int i=0;i<HomeCubit.get(context).listOfSocialSituations.length;i++){
        if (HomeCubit.get(context).patientInformationModel!.socialSituation!.contains(HomeCubit.get(context).listOfSocialSituations[i].name!)) {
          socialSituation= HomeCubit.get(context).onChangeSocialSituations(index: i,);
        }

      }
    }

  }

}
