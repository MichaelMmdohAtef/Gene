import 'dart:io';
import 'package:Gene/modules/chat/chats_screen.dart';
import 'package:Gene/shared/components/splash_dialog.dart';
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:Gene/models/Country%20Model/country_model.dart';
import 'package:Gene/models/languageModel.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/sign_up.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/modules/medical_patient_details_screen.dart';
import 'package:Gene/modules/my_profile.dart';
import 'package:Gene/modules/gene_clinics_screen.dart';
import 'package:Gene/modules/patient_information_screen.dart';
import 'package:Gene/models/login_model.dart';
import 'package:Gene/modules/support_screen.dart';
import 'package:Gene/modules/ticket_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/modules/Booking_screen.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/shared/components/components_2.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:Gene/shared/network/cache_memory/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../generated/l10n.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with TickerProviderStateMixin{
  late double screenHeight;
  late double screenWidth;
  TextEditingController countryController=TextEditingController();
  var scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState


    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (context) {

        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {

          },
          builder:(context, state) {
            var cubit=HomeCubit.get(context);
            CountryModel? country;
            if(cubit.localCountry != null){
              country=cubit.localCountry!;
            }else{
              country=cubit.countryList[66];
            }
            screenHeight = MediaQuery.sizeOf(context).height;
            screenWidth = MediaQuery.sizeOf(context).width;

            ///scaffold
            return Scaffold(
              appBar: statusBar(),
              key: scaffoldKey,
              body:Stack(
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
                    iconHeight: screenHeight * 0.0615550,
                    iconWidth: screenWidth * 0.13317,
                    onPressLeading: () {
                      Navigator.pop(context);
                    },
                    height:MediaQuery.sizeOf(context).height * 0.2159,
                    width:MediaQuery.sizeOf(context).width,
                    titleAppBar: S.of(context).titleSettingPage,
                    assetPNGIcon: "assets/svgIcons/settingPNG.png",
                    assetBackgroundImage: "assets/container_home_page/title appBar.png",
                  ),

                  ///body
                  PositionedDirectional(
                        top: screenHeight * 0.1133,
                        bottom: 0,
                        width: screenWidth,
                        start: 0,
                        child:SingleChildScrollView(
                          child: Container(
                            width: screenWidth,
                            child: Column(
                              children: [

                                ///container of setting screen
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: screenWidth * 0.0327,
                                    end: screenWidth * 0.0327,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      ///container language & country
                                      defaultSettingContainer(
                                        context: context,
                                        heightContainer: MediaQuery.sizeOf(context).height*0.2149,
                                        titleContainer: S.of(context).languageAndCountry,
                                        child: [

                                          ///language container
                                          defaultItemOfSetting(
                                              context: context,
                                              prefixIconData:"assets/svgIcons/languagePNG.png",
                                              title:S.of(context).languageTitle,
                                              suffixWidget: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  defaultText(
                                                    text:getNameOfLanguage(context: context, name: cubit.localLanguage) ,
                                                    color: defaultBlackColor,
                                                    fontSize: 16,
                                                    textHeight: 1.3125,
                                                    height: screenHeight * 0.0226,
                                                    context: context,
                                                    fontFamily: "Roboto",
                                                    textAlign: TextAlign.center,
                                                    boxFit: BoxFit.fitHeight,
                                                  ),
                                                ],
                                              ),
                                              onTap: ()async{
                                                if(cubit.shownButtonSheet){
                                                  cubit.changeButtonSheet(isShow: false);
                                                  Navigator.pop(context);
                                                }else{
                                                  await showLanguageButtonSheet(context: context);
                                                  cubit.changeButtonSheet(isShow: true);
                                                }
                                              }
                                          ),

                                          SizedBox(
                                            height:screenHeight * 0.0199,
                                          ),

                                          ///country container
                                          defaultItemOfSetting(
                                              context: context,
                                              prefixIconData:"assets/svgIcons/country.png",
                                              title:S.of(context).countryTitle,
                                              suffixWidget: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height:screenHeight * 0.0280,
                                                    width:screenWidth * 0.08878,
                                                    child:
                                                    kIsWeb || Platform.isWindows?
                                                    Image.network("https://www.countryflagicons.com/FLAT/64/${country.countryCode}.png",fit: BoxFit.fill,
                                                      errorBuilder: (_, __, ___) => country!.emojiText(country),
                                                    )
                                                        :country.emojiText(country),
                                                  ),
                                                ],
                                              ),
                                              onTap: (){
                                                if(cubit.shownButtonSheet){
                                                  cubit.changeButtonSheet(isShow: false);
                                                  Navigator.pop(context);
                                                }else{
                                                  // HomeCubit.get(context).onChangeCountriesCheckbox(lang: country!.name);
                                                  showCountryButtonSheet(context: context,country: country!);
                                                  cubit.changeButtonSheet(isShow: true);
                                                }
                                              }
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height:screenHeight * 0.01619,
                                      ),

                                      ///booking container
                                      defaultSettingContainer(
                                        context: context,
                                        heightContainer:userTokenApi!=null?MediaQuery.sizeOf(context).height * 0.2149 :MediaQuery.sizeOf(context).height*0.1360,
                                        titleContainer:S.of(context).booking,
                                        child: [

                                          ///book now button
                                          ///that navigate clinics screen of Gene app
                                          defaultItemOfSetting(
                                              context: context,
                                              heightSVGIcon: screenHeight * 0.031,
                                              prefixIconDataSVG:"assets/svgIcons/stethoscope-svgrepo-com.svg",
                                              title:S.of(context).bookTitleNavBar,
                                              onTap: ()async{
                                                bool hasInternet=await NetworkConnection.getConnectivity();
                                                if(hasInternet){
                                                  showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                                  await HomeCubit.get(context).getClinicsData().then((value) {
                                                    Navigator.pop(context);
                                                    navigateAndPush( context, GeneClinicsScreen());
                                                  });
                                                }else{
                                                  navigateAndPush( context, GeneClinicsScreen());
                                                  showSnackBar(context: context, text: S.current.failedConnection);
                                                }
                                              }
                                          ),

                                          SizedBox(
                                            height:screenHeight * 0.0199,
                                          ),

                                          ///my booking
                                          ///that navigate to booking screen of user
                                          if(userTokenApi!=null)
                                            Column(
                                              children: [
                                                defaultItemOfSetting(context: context,
                                                  prefixIconData:"assets/svgIcons/bookingSetting.png",
                                                  title:S.of(context).titleMyBookingPage,
                                                  onTap: () async{
                                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                                    if(hasInternet){
                                                      showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                      await HomeCubit.get(context).getBookingForUser().then((value){
                                                        Navigator.pop(context);
                                                        navigateAndPush(context,BookingScreen());
                                                      });
                                                    }else{
                                                      navigateAndPush(context,BookingScreen());
                                                      showSnackBar(context: context, text: S.current.failedConnection);
                                                    }

                                                  },
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),

                                      SizedBox(
                                        height:screenHeight * 0.01619,
                                      ),

                                      ///account container
                                      defaultSettingContainer(
                                        context: context,
                                        heightContainer:userTokenApi!=null?
                                        MediaQuery.sizeOf(context).height*0.380
                                            :MediaQuery.sizeOf(context).height*0.2149,
                                        titleContainer:S.of(context).account,
                                        child: [
                                          userTokenApi !=null?
                                          Column(
                                            children: [

                                              ///my profile button
                                              ///that navigate to profile screen of user
                                              defaultItemOfSetting(
                                                  context: context,
                                                  prefixIconData:"assets/svgIcons/MyProfile.png",
                                                  title:S.of(context).titleMyProfilePage,
                                                  onTap: ()async{
                                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                                    if(hasInternet){
                                                      showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                      SignInCubit.get(context).refreshData(context: context).then((value){
                                                        Navigator.pop(context);
                                                        navigateAndPush( context, MyProfileScreen());
                                                      });
                                                    }else{
                                                      if(SignInCubit.get(context).loginDataModel!=null && SignInCubit.get(context).loginDataModel!.userAccount!=null){
                                                        navigateAndPush( context, MyProfileScreen());
                                                      }
                                                      showSnackBar(context: context, text: S.current.failedConnection);
                                                    }

                                                  }
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0199,
                                              ),

                                              ///patient information button
                                              ///that navigate to patient information screen of user
                                              defaultItemOfSetting(
                                                  context: context,
                                                  prefixIconData:"assets/svgIcons/PatientInformation.png",
                                                  title:S.of(context).patientInformationTitle,
                                                  onTap: ()async{
                                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                                    if(hasInternet){
                                                      showDialog(context: context,builder:(context) => defaultCircleProgressBar(),);
                                                      await HomeCubit.get(context).getPatient(context: context).then((value){
                                                        Navigator.pop(context);
                                                        navigateAndPush(context,PatientInformationScreen());
                                                      });
                                                    }else{
                                                      navigateAndPush(context,PatientInformationScreen());
                                                      showSnackBar(context: context, text: S.current.failedConnection);
                                                    }

                                                  }
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0199,
                                              ),

                                              ///medical profile button
                                              ///that navigate to medical profile screen of user
                                              defaultItemOfSetting(
                                                  context: context,
                                                  prefixIconData:"assets/svgIcons/PatientInformation.png",
                                                  title:S.of(context).medicalPatientFileText,
                                                  onTap: ()async{
                                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                                    if(hasInternet){
                                                      showDialog(context: context,builder:(context) => defaultCircleProgressBar(),);
                                                      await HomeCubit.get(context).getMedicalProfile().then((value){
                                                        Navigator.pop(context);
                                                        navigateAndPush( context , MedicalPatientDetailsScreen() );
                                                      });
                                                    }
                                                    else{
                                                      if(HomeCubit.get(context).medicalHistoryModel!=null){
                                                        navigateAndPush( context , MedicalPatientDetailsScreen() );
                                                      }
                                                      showSnackBar(context: context, text: S.current.failedConnection);
                                                    }


                                                  }
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0199,
                                              ),

                                              ///sign out button
                                              defaultItemOfSetting(
                                                  context: context,
                                                  prefixIconData:"assets/svgIcons/SignOut.png",
                                                  title:S.of(context).signOutTitle,
                                                  onTap: ()async{
                                                    showDialog(context: context, builder:(context) => agreementSignedOut(context: context),);
                                                  }
                                              ),
                                            ],

                                          )
                                              :Column(
                                            children: [

                                              ///sign in button
                                              ///that navigate to sign in screen
                                              defaultItemOfSetting(
                                                  context: context,
                                                  prefixIconData:"assets/svgIcons/SignIn.png",
                                                  title:S.of(context).signInTitle,
                                                  onTap: (){
                                                    navigateAndPush( context, SignInScreen());
                                                  }
                                              ),

                                              SizedBox(
                                                height:screenHeight * 0.0199,
                                              ),


                                              ///register button
                                              ///that navigate to register screen
                                              defaultItemOfSetting(context: context,
                                                  prefixIconData:"assets/svgIcons/register.png",
                                                  title:S.of(context).registerTitle,
                                                  onTap: (){
                                                    navigateAndPush( context, SignUpScreen());
                                                  }
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height:screenHeight * 0.01619,
                                      ),

                                      ///contact us container
                                      defaultSettingContainer(
                                        context: context,
                                        heightContainer: MediaQuery.sizeOf(context).height*0.29,
                                        titleContainer:S.of(context).contactUs,
                                        child: [

                                          ///tickets button
                                          ///that navigate to ticket screen
                                          defaultItemOfSetting(
                                              context: context,
                                              prefixIconData:"assets/svgIcons/openTicket.png",
                                              title:S.of(context).titleOfTicketsScreen,
                                              onTap: (){
                                                navigateAndPush( context,TicketsScreen());
                                              }
                                          ),

                                          SizedBox(
                                            height:screenHeight * 0.0199,
                                          ),

                                          ///chats button
                                          ///that navigate to chats screen
                                          defaultItemOfSetting(
                                              context: context,
                                              // prefixIconData:"assets/svgIcons/openTicket.png",
                                              title:S.of(context).titleOfChatsScreen,
                                              onTap: (){
                                                navigateAndPush( context,ChatsScreen());
                                              }
                                          ),

                                          SizedBox(
                                            height:screenHeight * 0.0199,
                                          ),

                                          ///help button
                                          ///that navigate to support screen
                                          defaultItemOfSetting(
                                              context:context,
                                              prefixIconData:"assets/svgIcons/support.png",
                                              title:S.of(context).callingTitle,
                                              onTap: (){
                                                navigateAndPush(context,SupportScreen());
                                              }
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height:screenHeight * 0.0118,
                                ),

                                ///container of social media buttons(facebook - instagram - linked in)
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: screenWidth * 0.0327,
                                    end: screenWidth * 0.0327,
                                  ),
                                  child: Container(
                                    height:MediaQuery.sizeOf(context).height * 0.18,
                                    width: MediaQuery.sizeOf(context).width,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                      color: defaultWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: defaultBlackColor.withAlpha(50),
                                            blurRadius: 15,
                                            blurStyle: BlurStyle.outer,
                                            offset: Offset(0, 0)
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsetsDirectional.only(
                                        top: MediaQuery.sizeOf(context).height*0.017,
                                        bottom: MediaQuery.sizeOf(context).height * 0.017,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          ///row that contains on social media buttons
                                          Container(
                                            height:MediaQuery.sizeOf(context).height* 0.05183,
                                            width:MediaQuery.sizeOf(context).width* 0.6705,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                ///facebook button
                                                InkWell(
                                                  onTap: (){
                                                    Uri facebook=Uri.parse(facebookURL);
                                                    launchUrl(facebook);
                                                  },
                                                  child: Container(
                                                    height:MediaQuery.sizeOf(context).height* 0.05183,
                                                    width:MediaQuery.sizeOf(context).width* 0.11214,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0,0),
                                                          blurRadius: 10,
                                                          color: defaultBlackColor.withAlpha(50),
                                                          blurStyle: BlurStyle.outer,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Image.asset("assets/svgIcons/facebookSetting.png",fit: BoxFit.fill),
                                                  ),
                                                ),

                                                ///linked in button
                                                InkWell(
                                                  onTap: (){
                                                    Uri linkedIn=Uri.parse(linkedInURL);
                                                    launchUrl(linkedIn);
                                                  },
                                                  child: Container(
                                                    height:MediaQuery.sizeOf(context).height* 0.05183,
                                                    width:MediaQuery.sizeOf(context).width* 0.11214,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0,0),
                                                          blurRadius: 10,
                                                          color: defaultBlackColor.withAlpha(50),
                                                          blurStyle: BlurStyle.outer,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Image.asset("assets/svgIcons/linkedin.png",fit: BoxFit.fill),
                                                  ),
                                                ),

                                                ///instagram button
                                                InkWell(
                                                  onTap: (){
                                                    Uri instagram=Uri.parse(instagramURL);
                                                    launchUrl(instagram);
                                                  },
                                                  child: Container(
                                                    height:MediaQuery.sizeOf(context).height* 0.05183,
                                                    width:MediaQuery.sizeOf(context).width* 0.11214,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0,0),
                                                          blurRadius: 10,
                                                          color: defaultBlackColor.withAlpha(50),
                                                          blurStyle: BlurStyle.outer,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Image.asset("assets/svgIcons/instagram.png",fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Spacer(),

                                          ///container that contains on social some details about app
                                          Container(
                                            height:MediaQuery.sizeOf(context).height* 0.05831,
                                            width:MediaQuery.sizeOf(context).width* 0.5747,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    ///privacy policy button
                                                    InkWell(
                                                      onTap: () {
                                                        Uri privacyPolicy=Uri.parse(privacyPolicyURL);
                                                        launchUrl(privacyPolicy);
                                                      },
                                                      child:defaultText(
                                                          text: S.of(context).privacyPolicyText,
                                                          height:MediaQuery.sizeOf(context).height* 0.0226,
                                                          width:MediaQuery.sizeOf(context).width* 0.2266,
                                                          color: defaultBlackColor,
                                                          fontFamily:"Roboto" ,
                                                          fontSize: 16,
                                                          textHeight:1.3125 ,
                                                          context: context),
                                                    ),

                                                    Container(
                                                      height:MediaQuery.sizeOf(context).height* 0.01943,
                                                      width:MediaQuery.sizeOf(context).width* 0.0420,
                                                      decoration: BoxDecoration(
                                                        color: defaultBlackColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),

                                                    ///term of use button
                                                    InkWell(
                                                      onTap: () {
                                                        Uri termOfUse=Uri.parse(termsOfUseURL);
                                                        launchUrl(termOfUse);
                                                      },
                                                      child:defaultText(
                                                          text: S.of(context).termsOfUse,
                                                          height:MediaQuery.sizeOf(context).height* 0.0226,
                                                          width:MediaQuery.sizeOf(context).width* 0.2266,
                                                          color: defaultBlackColor,
                                                          fontFamily:"Roboto",
                                                          fontSize: 16,
                                                          textHeight:1.3125,
                                                          context: context),
                                                    ),

                                                  ],
                                                ),
                                                defaultText(
                                                    text: S.of(context).versionNumber,
                                                    height:MediaQuery.sizeOf(context).height * 0.0226,
                                                    width:MediaQuery.sizeOf(context).width * 0.2266,
                                                    color: defaultBlackColor,
                                                    fontFamily:"Roboto",
                                                    fontSize: 16,
                                                    textHeight:1.3125,
                                                    context: context),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height:screenHeight * 0.14,
                                ),

                              ],
                            ),
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
    );
  }

  ///fun that show country button sheet
  showCountryButtonSheet({
    required BuildContext context,
    required CountryModel country,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => countryButtonSheet(context: context,countryController: countryController,fromUser: true),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 1)),).closed.then((value)async{
      countryController.text="";
      HomeCubit.get(context).changeButtonSheet(isShow: false);
    });
  }

  ///fun that show language button sheet
  String? language;
  showLanguageButtonSheet({
    required BuildContext context,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => languageButtonSheet(context: context),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 1)),).closed.then((value)async{
      HomeCubit.get(context).onClosedLanguageButtonSheet(isClosed: false);
      HomeCubit.get(context).changeButtonSheet(isShow: false);
    });
  }

  ///ui of button sheet language
  languageButtonSheet({
    required BuildContext context,
  }){
    return Container(
      // height:screenHeight * 0.36177,
      height:screenHeight * 0.26,
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
            Container(
              height: screenHeight * 0.0313,
              child: Stack(
                children: [
                  defaultText(
                      text: S.of(context).titleButtonSheetLanguage,
                      color: defaultGreyColor,
                      height: screenHeight * 0.0313,
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      alignment: AlignmentDirectional.center,
                      textHeight: 1.3181,
                      fontFamily: "Roboto",
                      context: context
                  ),
                  Align(
                    alignment:AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding:  EdgeInsetsDirectional.only(
                        end: screenWidth * 0.04672,
                      ),
                      child: InkWell(
                        onTap: (){
                          HomeCubit.get(context).onClosedLanguageButtonSheet(isClosed: true);
                          Navigator.pop(context);

                        },
                        child: Container(
                          height:screenHeight * 0.04,
                          width: screenWidth * 0.07,
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(Icons.close)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02807),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => defaultLanguageContainer(model: HomeCubit.get(context).languages[index],index: index,context:context),
                  separatorBuilder: (context, index) => SizedBox(
                    height: screenHeight * 0.01511,
                  ), itemCount: HomeCubit.get(context).languages.length),
            ),
          ],
        ),
      ),
    );
  }

  ///dialog that appear to ask user if he still want
  ///to change state of language or not
  agreementChangeSetting({
    required BuildContext context,
}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () {
          HomeCubit.get(context).onChangeLanguageCheckbox(lang: HomeCubit.get(context).localLanguage);
          Navigator.pop(context);
          return Future(() => true);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dialog(
              insetPadding: EdgeInsets.all(0),
              alignment: AlignmentDirectional.center,
              child: Container(
                alignment: AlignmentDirectional.center,
                width: screenWidth,
                // height: heightContainer,
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
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenHeight * 0.02,
                    end: screenWidth * 0.025,
                    start: screenWidth * 0.025,
                  ),
                  child: Column(
                  children: [

                    defaultText(
                        text: S.of(context).changeSettingText,
                        color: defaultGreyColor,
                        height: screenHeight * 0.05,
                        fontSize: 30,
                        alignment: AlignmentDirectional.center,
                        textHeight: 1.3181,
                        fontFamily: "Roboto",
                        context: context
                    ),

                    defaultTextWithoutFittedBox(
                        text: S.of(context).alertChangeSetting,
                        color: defaultGreyColor,
                        height: screenHeight * 0.15,
                        textAlign: TextAlign.start,
                        maxLine: 6,
                        fontSize: 18,
                        alignment: AlignmentDirectional.center,
                        textHeight: 1.3181,
                        fontFamily: "Roboto",
                        context: context,
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
                                onPressed: (){
                                  HomeCubit.get(context).onChangeLanguageCheckbox(lang: HomeCubit.get(context).localLanguage);
                                  Navigator.pop(context);
                                },
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(S.of(context).no_button_text,
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
                                onPressed: ()async{
                                  bool hasInternet=await NetworkConnection.getConnectivity();
                                  if(userTokenApi != null){
                                    if(hasInternet){
                                      UserAccountLoginPage user=SignInCubit.get(context).userModel!;
                                      user.language=language;
                                      SignInCubit.get(context).onChangeUserData(object: user);
                                      showDialog(context: context,builder:(context) => defaultCircleProgressBar(),);
                                      SignInCubit.get(context).updateData(context: context,data: SignInCubit.get(context).userModel!.toMap()).then((value){
                                        Navigator.pop(context);
                                        Phoenix.rebirth(context);
                                      });
                                    }else{
                                      HomeCubit.get(context).onChangeLanguageCheckbox(lang: HomeCubit.get(context).localLanguage);
                                      Navigator.pop(context);
                                      showSnackBar(context: context, text: S.current.failedConnection);
                                    }

                                  }else{
                                    await CashHelper.setString(key: Lang_Key, value: language!);
                                    Phoenix.rebirth(context);
                                    HomeCubit.get(context).onChangeLanguage(lang: language!);

                                  }


                                },
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(S.of(context).yes_button_text,
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

                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.018,
                    ),


                  ],
                                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///dialog that appear to ask user if he still want
  ///to sign out from app or not
  agreementSignedOut({
    required BuildContext context,
  }){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            insetPadding: EdgeInsets.all(0),
            alignment: AlignmentDirectional.center,
            child: Container(
              alignment: AlignmentDirectional.center,
              width: screenWidth,
              // height: heightContainer,
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
                alignment: Alignment.center,
                children: [

                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: screenHeight * 0.02,
                      end: screenWidth * 0.025,
                      start: screenWidth * 0.025,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [

                            defaultText(
                                text: S.of(context).signOutTitle,
                                color: defaultGreyColor,
                                height: screenHeight * 0.05,
                                // textAlign: TextAlign.center,
                                fontSize: 30,
                                alignment: AlignmentDirectional.center,
                                textHeight: 1.3181,
                                fontFamily: "Roboto",
                                context: context
                            ),

                            defaultTextWithoutFittedBox(
                                text: S.of(context).alertSignOut,
                                color: defaultGreyColor,
                                height: screenHeight * 0.15,
                                textAlign: TextAlign.start,
                                maxLine: 6,
                                fontSize: 20,
                                alignment: AlignmentDirectional.center,
                                textHeight: 1.3181,
                                fontFamily: "Roboto",
                                context: context
                            ),

                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.0626,
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
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(S.of(context).no_button_text,
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
                                        onPressed: ()async{
                                          bool hasInternet=await NetworkConnection.getConnectivity();
                                          if(hasInternet){
                                            showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                            userTokenApi=null;
                                            await CashHelper.removeData(key: USER_TOKEN_API);
                                            SignInCubit.get(context).onChangeUserDataOfLogIn(object:null);
                                            await HomeCubit.get(context).getClinicsData();
                                            SignInCubit.get(context).signOutWithFirebase();
                                            await showDialog(context: context, builder:(context) =>
                                                DefaultSplashDialog(
                                                  text: S.of(context).signedOutSuccessfullyFirst,text2:S.of(context).signedOutSuccessfullySecond,
                                                  nextWidget: () {
                                                  navigateAndFinish( context,HomeScreen());
                                            },
                                                haveCloseButton: false,
                                            ),);
                                          }else{
                                            Navigator.pop(context);
                                            showSnackBar(context: context, text: S.current.failedConnection);
                                          }
                                        },
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(S.of(context).yes_button_text,
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

                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.018,
                            ),

                          ],
                        ),
                      ],
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

  ///widget that contains details of language (name, flag, checkbox)
  Widget defaultLanguageContainer({
    required LanguageModel model,
    required int index,
    required BuildContext context,
  }){
    String nameOfCountry=getNameOfLanguage(context:context,name: model.langCountry!);
    return InkWell(
      onTap: (){
        HomeCubit.get(context).onChangeLanguageCheckbox(index: index);
        language=HomeCubit.get(context).languages[index].langCountry;
        showDialog(context: context, builder:(context) => agreementChangeSetting(context: context),);
      },
      child: Container(
        height: screenHeight * 0.06479,
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
              Container(
                height:screenHeight * 0.0280,
                width:screenWidth * 0.08878,
                child: Image.asset(model.imageCountry!,fit: BoxFit.cover),
              ),
              SizedBox(
                width: screenWidth * 0.04439,
              ),
              defaultText(
                  text:nameOfCountry,
                  color: defaultBlackColor,
                  height:screenHeight * 0.0345,
                  fontSize: 24,
                  fontFamily: "Roboto",
                  textHeight: 1.333,
                  context: context
              ),
              Spacer(),
              BlocConsumer<HomeCubit,HomeStates>(
                builder:(context, state) {
                return Checkbox.adaptive(
                    value: HomeCubit.get(context).languages[index].check,
                    shape: CircleBorder(),
                    activeColor: Color(0xff1BDFFE),
                    side:HomeCubit.get(context).languages[index].check!?
                    BorderSide(color: defaultBlueAccentColor,
                      width: 3,
                    ):
                    BorderSide(color: Color(0xff8F8F8F),
                      width: 3,
                    ),
                    onChanged: (checked){
                      HomeCubit.get(context).onChangeLanguageCheckbox(index: index);
                      language=HomeCubit.get(context).languages[index].langCountry;
                      // Navigator.pop(context);
                      showDialog(context: context, builder:(context) => agreementChangeSetting(context: context),);

                    });
                },
                listener: (context, state) {

                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ///get name of language
  String getNameOfLanguage({required BuildContext context,required String name}){
    if(name=="ar"){
      return S.of(context).arabicLanguage;
    }else if(name=="en"){
      return S.of(context).englishLanguage;
    }else{
      return S.of(context).frenchLanguage;
    }
  }

}
