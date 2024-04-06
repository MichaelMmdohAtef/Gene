
import 'dart:io';
import 'dart:typed_data';
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:http/http.dart' as http;
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/booking_user_information.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class MedicalPrescriptionScreen extends StatelessWidget {
  MedicalPrescriptionScreen({required this.model});

  late double screenWidth;
  BookingUserInformation? model;

  ///screen shot controller that control with screen shot widgets
  ScreenshotController screenshotController=ScreenshotController();

  var image;
  late double screenHeight;
  bool isImage=false;

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


            return Screenshot(
              controller: screenshotController,
              child: Scaffold(
                appBar: statusBar(),
                body: Stack(
                  children: [

                    /// first background
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

                    ///body
                    Container(
                      height: screenHeight,
                      width: screenWidth,
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

                          ///appbar
                          appBarWidget(
                              context: context,
                            height: MediaQuery.sizeOf(context).height * 0.2159,
                            width:MediaQuery.sizeOf(context).width,
                            titleAppBar: S.of(context).history_booking_button_text,
                            assetBackgroundImage:"assets/container_home_page/title appBar.png" ,
                            onPressLeading:() {
                              Navigator.pop(context);
                            },
                          ),

                          ///body
                          PositionedDirectional(
                              top: screenHeight * 0.09,
                              bottom: screenHeight * 0.1350,
                              start:screenWidth* 0.0327,
                              end: screenWidth* 0.0327,
                            child: Container(
                              height: screenHeight,
                              // width: screenWidth,
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
                                  top:screenHeight * 0.0239,
                                  start:screenWidth * 0.0208,
                                  end:screenWidth * 0.0208,
                                ),
                                child: SingleChildScrollView(
                                  child: Container(
                                    // height: screenHeight,
                                    width: screenWidth,
                                    child:ConditionalBuilder(
                                      condition: model != null,
                                      builder: (context) {
                                        return medicalPrescriptionWidget(context: context);
                                      },
                                      fallback: (context) => Container(),
                                    ),
                                  ),
                                ),
                              ),
                              // color: Colors.white,
                            ),
                          ),
                          // navBar

                        ],
                      ),
                    ),

                    ///nav bar
                    appNavBar(context: context),
                  ],
                ),
              ),
            );
          },
        );
      },
    );


  }
  ///widget that apper as screenshot on phone
  screenShot({
    required BuildContext context,
}){
    return Container(
      color: Colors.white,
      height: screenHeight,
      width: screenWidth,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start:screenWidth * 0.0408,
          end:screenWidth * 0.0408,
        ),
        child: Center(
          child: Container(
            alignment: AlignmentDirectional.center,
            color: Colors.white,
            width: screenWidth,
            child: widgetOfScreenShot(context: context),
          ),
        ),
      ),
    );
  }

  ///ui widget of table prescription
  widgetOfScreenShot({
    required BuildContext context,
}){
    isImage=false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        /// header Title of table
        Container(
          height: screenHeight * 0.0464,
          child: defaultText(width: screenWidth * 0.574,
              height: screenHeight * 0.0464,
              text:S.of(context).book_information_text,
              color: Color(0xff707070),
              boxFit: BoxFit.fill,
              alignment: AlignmentDirectional.center,
              textAlign: TextAlign.center,
              textHeight: 1.34,
              fontSize: 32,
              context: context),
        ),

        SizedBox(
          height: screenHeight * 0.0151,
        ),

        ///Table
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(
                color: Color(0xff707070),
                width: 2,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Column(
              children: [
                for(int i=0;i<model!.prescription!.prescriptionModel.length;i++)
                  if(model!.prescription!.prescriptionModel[i].name != null)
                  Column(
                    children: [
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff707070),
                              width: 2,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            )
                        ),
                      ),

                      ///Medicament name
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: defaultText(
                                        text: "Medicament name",
                                        color: defaultWhiteColor,
                                        // height:screenHeight * 0.0205,
                                        textAlign: TextAlign.center,
                                        fontFamily: "Roboto",
                                        alignment: AlignmentDirectional.center,
                                        textHeight: 1.357,
                                        fontSize: 14,
                                        context: context)
                                ),
                                Container(
                                  width: 2,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xff707070),
                                        width: 2,
                                        style: BorderStyle.solid,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                      ),
                                  ),
                                ),
                                Expanded(
                                    child: defaultText(
                                    text: model!.prescription!.prescriptionModel[i].name!,
                                    color: defaultWhiteColor,
                                    textAlign: TextAlign.center,
                                    fontFamily: "Roboto",
                                    alignment: AlignmentDirectional.center,
                                    textHeight: 1.357,
                                    fontSize: 14,
                                    context: context)),
                              ],
                            ),
                            height: screenHeight * 0.0529,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color:Color(0xff52C6D8),
                              // borderRadius: BorderRadiusDirectional.only(
                              //   topEnd: Radius.circular(24),
                              //   topStart: Radius.circular(24),
                              // ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff707070),
                              width: 2,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            )
                        ),
                      ),

                      ///notes on medicament
                      Container(
                        height: screenHeight * 0.0529,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color:Color(0xff52C6D8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: defaultText(
                                    text: "Time & Period",
                                    color: defaultWhiteColor,
                                    // height:screenHeight * 0.0205,
                                    textAlign: TextAlign.center,
                                    fontFamily: "Roboto",
                                    alignment: AlignmentDirectional.center,
                                    textHeight: 1.357,
                                    fontSize: 14,
                                    context: context),
                            ),
                            Container(
                              width: 2,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff707070),
                                    width: 2,
                                    style: BorderStyle.solid,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                  )
                              ),
                            ),
                            Expanded(
                                child: defaultText(
                                    text: model!.prescription!.prescriptionModel[i].note!,
                                    color: defaultWhiteColor,
                                    // height:screenHeight * 0.0205,
                                    textAlign: TextAlign.center,
                                    fontFamily: "Roboto",
                                    alignment: AlignmentDirectional.center,
                                    textHeight: 1.357,
                                    fontSize: 14,
                                    context: context)),
                          ],
                        ),
                      ),

                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff707070),
                              width: 2,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            )
                        ),
                      ),
                    ],
                )
              ],
            ),
          ),
        ),

        SizedBox(
          height: screenHeight * 0.003,
        ),
      ],
    );
  }


  ///ui widget of image prescription
  widgetImageOfPrescriptions({
    required BuildContext context,
  }){
    isImage=true;
    return Column(
      children: [
        ///list of prescription images
        ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
          return  Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: defaultWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: defaultBlackColor.withAlpha(8),
                  blurRadius: 25,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Image.network(model!.attachments[index],fit: BoxFit.fill,),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.0075,
          );
        },
        itemCount: model!.attachments.length),
      ],
    );
  }

  ///ui widget of body prescription
  medicalPrescriptionWidget({
    required BuildContext context,
  }){
    return Column(
      children:[

        if(model!.prescription!.prescriptionModel.isNotEmpty || (model!.prescription!.prescriptionModel.isNotEmpty && model!.attachments.length !=0))
        widgetOfScreenShot(context: context),

        if(model!.prescription!.prescriptionModel.isEmpty && model!.attachments.length !=0)
        widgetImageOfPrescriptions(context: context),

        SizedBox(
          height: screenHeight * 0.03,
        ),

        ///Qr image that view examination
        Container(
          width:screenWidth * 0.397,
          child: Column(
            children: [
              if(!isImage)
              QrImageView(
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(screenWidth * 0.34, screenHeight * 0.15)
                ),
                data: model!.pathologicalDescription!=null?model!.pathologicalDescription!:"wait for examination",
                version: QrVersions.auto,
                gapless: false,
              ),
              defaultText(
                  text: "Scan prescription",
                  color: Color(0xff030303),
                  fontFamily: "Roboto",
                  textAlign: TextAlign.center,
                  fontSize: 22,
                  textHeight: 1.318,
                  context: context)
            ],
          ),
        ),

        SizedBox(
          height: screenHeight * 0.03,
        ),

        ///download prescription button
        defaultMaterialButton(
        height: screenHeight * 0.0583,
        context: context,
        backgroundColor:defaultBlueAccentColor,
        textColor:defaultWhiteColor,
        text:"Download prescription",
        onPress: ()async{
          bool hasInternet=await NetworkConnection.getConnectivity();
          if(hasInternet){
            showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
            if(!isImage){
              await screenshotController.captureFromLongWidget(screenShot(context: context),constraints: BoxConstraints.tightFor(width: screenWidth,),delay: Duration(milliseconds: 100)).then((value)async{
                image=value;
                print(value);
                await saveImage(value);
              });
            }
            else{
              for(int i=0;i<model!.attachments.length;i++){
                http.Response response=await http.get(
                    Uri.parse(model!.attachments[i])
                );
                Uint8List image= response.bodyBytes;
                await saveImage(image);
              }
            }
            Navigator.pop(context);
          }else{
            showSnackBar(context: context, text: S.current.failedConnection);
          }
        },
         ),

        SizedBox(
          height: screenHeight * 0.03,
        ),

        ///share prescription button
        defaultMaterialButton(
        height: screenHeight * 0.0583,
        context: context,
        backgroundColor:defaultBlueAccentColor,
        textColor:defaultWhiteColor,
        text:"Share",
        onPress: ()async{
          if(!isImage){
            await screenshotController.captureFromLongWidget(screenShot(context: context),constraints: BoxConstraints.tight(Size(screenWidth,screenHeight)),delay: Duration(milliseconds: 100),).then((value)async{
              image=value;
              await saveImageAndShareIt(value);
                        });
          }else{
            for(int i=0;i<model!.attachments.length;i++){
              http.Response response=await http.get(
                  Uri.parse(model!.attachments[i])
              );
              Uint8List image= response.bodyBytes;
              await saveImageAndShareIt(image);
            }
          }
        },
         ),

        SizedBox(
          height: screenHeight * 0.0205,
        ),

      ],
    );
  }

  ///save image on phone
  saveImage(Uint8List value)async{
    await [Permission.storage].request();
    final time=DateTime.now()
    .toIso8601String()
    .replaceAll(".","-")
    .replaceAll(":","-");
    String name="screenshot_$time";
    await ImageGallerySaver.saveImage(value,name:name,isReturnImagePathOfIOS: true);
  }

  ///share image with other ways
  saveImageAndShareIt(Uint8List value)async{
    final directory=(await getApplicationCacheDirectory()).path;
    final image=File('$directory/flutter.png');
    image.writeAsBytesSync(value);
    // ignore: deprecated_member_use
    await Share.shareFiles([image.path]);
  }
}

