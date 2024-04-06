import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/modules/edit_patient_information_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class PatientInformationScreen extends StatelessWidget {
  PatientInformationScreen({super.key});
  late double screenWidth;
  late double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight =MediaQuery.sizeOf(context).height;
    screenWidth =MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        HomeCubit.get(context).changeButtonSheet(isShow: false);
        return BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {

          },
          builder: (context, state) {

            var cubit=HomeCubit.get(context);
            return Scaffold(
              appBar: statusBar(),
              body: Stack(
                children: [

                  ///single child scroll view
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

                        ///appbar
                        appBarWidget(
                          context: context,
                          onPressLeading: (){
                            Navigator.pop(context);
                          },
                          height: MediaQuery.sizeOf(context).height * 0.2159,
                          width:MediaQuery.sizeOf(context).width,
                          titleAppBar: S.of(context).patientInformationTitle,
                          assetBackgroundImage:"assets/container_home_page/title appBar.png" ,
                        ),

                        ///body
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: screenHeight * 0.1133,
                              start:screenWidth* 0.0327,
                              end: screenWidth* 0.0327,
                              bottom: screenHeight * 0.1231,
                            ),
                            child: Column(
                              children: [

                                ///container that contains information of user
                                ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: screenHeight * (0.49)),
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
                                        child:Column(
                                          children: [

                                            ///title text
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    navigateAndPush(context, EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                    text: S.of(context).patientInformationTitle,
                                                    fontFamily: "Roboto",
                                                    textHeight: 1.333,
                                                    alignment: AlignmentDirectional.center,
                                                    fontSize: 33,
                                                    color: Color(0xff707070),
                                                    // width:screenWidth * 0.605,
                                                    height:screenHeight * 0.042,
                                                    context: context,
                                                  ),
                                                ),
                                                TextButton(onPressed: () {
                                                  navigateAndPush(context,EditPatientInformationScreen());
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

                                            /// weight container
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    navigateAndPush(context, EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).weightPatientInformation,
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
                                                defaultText(
                                                    text: "${cubit.patientInformationModel!.weight!=null?cubit.patientInformationModel!.weight.toString():"   "}",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),


                                              ],
                                            ),

                                            SizedBox(
                                              height:screenHeight * 0.0129,
                                            ),

                                            /// height container
                                            Column(
                                              children: [

                                                InkWell(
                                                  onTap: () {
                                                    navigateAndPush(context, EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).heightPatientInformation,
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

                                                defaultText(
                                                    text: cubit.patientInformationModel!.height!=null?cubit.patientInformationModel!.height.toString():"  ",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),
                                              ],
                                            ),

                                            SizedBox(
                                              height: screenHeight * 0.0129,
                                            ),

                                            /// Social Situation
                                            Column(
                                              children: [

                                                InkWell(
                                                  onTap: () {
                                                    navigateAndPush(context, EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).socialSituationPatientInformation,
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

                                                defaultText(
                                                    text: cubit.patientInformationModel!.socialSituation!=null?cubit.patientInformationModel!.socialSituation.toString():"   ",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context,
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: screenHeight * 0.0129,
                                            ),

                                            /// National ID
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    navigateAndPush(context,EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).nationalIdPatientInformation,
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
                                                defaultText(
                                                    text: cubit.patientInformationModel!.nationalID!=null?cubit.patientInformationModel!.nationalID.toString():"   ",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),
                                              ],
                                            ),

                                            SizedBox(
                                              height: screenHeight * 0.0129,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    // color: Colors.white,
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                ///container that contains emergency information of user
                                ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: screenHeight * (0.55)),
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
                                        child:Column(
                                          children: [
                                            ///title text
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    navigateAndPush(context,EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                    text: S.of(context).addressEmergencyTitle,
                                                    fontFamily: "Roboto",
                                                    textHeight: 1.333,
                                                    alignment: AlignmentDirectional.center,
                                                    fontSize: 33,
                                                    color: Color(0xff707070),
                                                    // width:screenWidth * 0.605,
                                                    height:screenHeight * 0.042,
                                                    context: context,
                                                  ),
                                                ),
                                              ],
                                            ),


                                            SizedBox(
                                              height:screenHeight * 0.0377,
                                            ),

                                            /// first name container
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    navigateAndPush(context,EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).emergencyFirstName,
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
                                                defaultText(
                                                    text: cubit.patientInformationModel!.firstname!=null?cubit.patientInformationModel!.firstname.toString():"   ",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),
                                              ],
                                            ),

                                            SizedBox(
                                              height: screenHeight * 0.0129,
                                            ),

                                            /// last name container
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    navigateAndPush(context,EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).emergencyLastName,
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
                                                defaultText(
                                                    text: cubit.patientInformationModel!.lastname!=null?cubit.patientInformationModel!.lastname.toString():"   ",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),
                                              ],
                                            ),

                                            SizedBox(
                                              height: screenHeight * 0.0129,
                                            ),

                                            /// phone container
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    navigateAndPush(context,EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).phoneText,
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
                                                defaultText(
                                                    text: cubit.patientInformationModel!.phoneNumber!=null?cubit.patientInformationModel!.phoneNumber.toString():"   ",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),
                                              ],
                                            ),

                                            SizedBox(
                                              height:screenHeight * 0.0129,
                                            ),

                                            /// address
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    navigateAndPush(context,EditPatientInformationScreen());
                                                  },
                                                  child:defaultText(
                                                      text: S.of(context).addressText,
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
                                                defaultText(
                                                    text: cubit.patientInformationModel!.address!=null?cubit.patientInformationModel!.address.toString():"   ",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),
                                              ],
                                            ),

                                            SizedBox(
                                              height:screenHeight * 0.0194,
                                            ),

                                            ///edit patient button
                                            ///navigate to edit medical patient screen
                                            defaultMaterialButton(
                                              height: screenHeight * 0.0583,
                                              context: context,
                                              backgroundColor:defaultBlueAccentColor,
                                              textColor:defaultWhiteColor,
                                              text:S.of(context).editMedicalPatientButton,
                                              onPress: (){
                                                navigateAndPush(context,EditPatientInformationScreen());
                                              },
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///navbar
                  appNavBar(context: context,localIndex: 3),
                ],
              ),
            );

          },
        );
      },
    );
  }

}
