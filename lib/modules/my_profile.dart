import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/shared/components/components_2.dart';
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/models/login_model.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/modules/change_password.dart';
import 'package:Gene/modules/medical_patient_details_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> with TickerProviderStateMixin{
  LoginModel? userData;

  late double screenHeight;

  late double screenWidth;


  ///phone controller that control value of phone in text field
  TextEditingController phoneController = TextEditingController();

  ///email controller that control value of email in text field
  TextEditingController emailController = TextEditingController();

  ///date controller that control value of date in text field
  TextEditingController dateController = TextEditingController();

  ///first name controller that control value of first name in text field
  TextEditingController firstNameController = TextEditingController();

  ///last name controller that control value of last name in text field
  TextEditingController lastNameController = TextEditingController();

  ///middle name controller that control value of middle name in text field
  TextEditingController middleNameController = TextEditingController();

  ///code of country controller that control code of country with phone
  TextEditingController CodeOfCountryController = TextEditingController();

  ///scaffold controller that control scaffold state
  var scaffoldKey=GlobalKey<ScaffoldState>();

  var formKey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {

        if(SignInCubit.get(context).loginDataModel!.userAccount!.gender=="male"){
          SignInCubit.get(context).onChangeGender(gender: Gender.male);
        }else{
          SignInCubit.get(context).onChangeGender(gender: Gender.female);
        }

        HomeCubit.get(context).getLocalCountry(context: context);

        return BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            screenHeight = MediaQuery.sizeOf(context).height;
            screenWidth = MediaQuery.sizeOf(context).width;
            var cubit = SignInCubit.get(context);
            userData=SignInCubit.get(context).loginDataModel;

            // ignore: deprecated_member_use
            return WillPopScope(
              onWillPop: () async{
                firstNameController.text="";
                middleNameController.text="";
                lastNameController.text="";
                dateController.text="";
                FocusScope.of(context).unfocus();
                return Future.value(true);
              },
              child: Scaffold(
                key: scaffoldKey,
                appBar: statusBar(),

                body: SingleChildScrollView(
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
                      appBarWidget(context: context,
                          height: MediaQuery.sizeOf(context).height * 0.4319,
                          width: MediaQuery.sizeOf(context).width,
                          assetBackgroundImage: "assets/Background/doctor app Bar.png",
                          titleAppBar: S.of(context).titleMyProfilePage),

                      ///body
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          bottom: screenHeight * 0.1177,
                          top: screenHeight * 0.0917,
                          start: screenWidth * 0.0327,
                          end: screenWidth * 0.0327,
                        ),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Stack(
                            children: [

                              ///information of user
                              Padding(
                                padding: EdgeInsets.only(top: screenHeight * 0.1657),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: defaultWhiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: defaultBlackColor
                                            .withAlpha(60),
                                        offset: Offset(0, 0),
                                        blurRadius: 15,
                                        blurStyle: BlurStyle.outer,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      top: screenHeight * 0.0777,
                                      bottom: screenHeight * 0.0248,
                                      start: screenWidth * 0.0350,
                                      end: screenWidth * 0.0350,
                                    ),
                                    child: ConditionalBuilder(
                                        condition: cubit.loginDataModel != null,
                                        builder: (context) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              ///first & middle name text field
                                              Container(
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [

                                                    ///first name
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(padding: EdgeInsetsDirectional.only(
                                                            start: screenWidth * 0.0327,
                                                          ),
                                                            child:defaultText(
                                                                height: screenHeight * 0.0313,
                                                                text: S.of(context).firstNameText,
                                                                boxFit: BoxFit.fitHeight,
                                                                color: defaultGreyColor,
                                                                context: context
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: screenHeight *.015,
                                                          ),
                                                          // Spacer(),
                                                          defaultTextFormField(
                                                            context: context,
                                                            controller: firstNameController,
                                                            keyboardType: TextInputType.text,
                                                            hint: firstNameController.text=userData!.userAccount!.firstName!,
                                                            onValidate: (value) {
                                                              if (value!.isEmpty) {
                                                                return  S.of(context).validatorFirstNameText;
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: screenWidth * 0.0350,
                                                    ),

                                                    ///middle name
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(padding: EdgeInsetsDirectional.only(
                                                              start: screenWidth * 0.0327,
                                                            ),
                                                              child:defaultText(
                                                                  height: screenHeight * 0.0313,
                                                                  text: S.of(context).middleNameText,
                                                                  boxFit: BoxFit.fitHeight,
                                                                  color: defaultGreyColor,
                                                                  context: context
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: screenHeight *.015,
                                                            ),
                                                            defaultTextFormField(
                                                              context: context,
                                                              controller: middleNameController,
                                                              keyboardType: TextInputType.text,
                                                              hint: middleNameController.text=userData!.userAccount!.middleName??"",
                                                              onValidate: (value) {
                                                                if (value!.isEmpty) {
                                                                  return  S.of(context).validatorMiddleNameText;
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),



                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.00539,
                                              ),

                                              ///last name
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(padding: EdgeInsetsDirectional.only(
                                                    start: screenWidth * 0.0327,
                                                  ),
                                                    child:defaultText(
                                                        height: screenHeight * 0.0313,
                                                        text: S.of(context).lastNameText,
                                                        boxFit: BoxFit.fitHeight,
                                                        color: defaultGreyColor,
                                                        context: context
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight *.015,
                                                  ),
                                                  defaultTextFormField(
                                                    context: context,
                                                    controller: lastNameController,
                                                    keyboardType: TextInputType.text,
                                                    hint: lastNameController.text=userData!.userAccount!.lastName!,
                                                    onValidate: (value) {
                                                      if (value!.isEmpty) {
                                                        return  S.of(context).validatorLastNameText;
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.00539,
                                              ),

                                              ///phone text field
                                              Container(
                                                alignment: Alignment.center,
                                                width: screenWidth,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(padding: EdgeInsetsDirectional.only(
                                                      start: screenWidth * 0.0327,
                                                    ),
                                                      child:defaultText(
                                                          height: screenHeight * 0.0313,
                                                          text: S.of(context).phoneText,
                                                          boxFit: BoxFit.fitHeight,
                                                          color: defaultGreyColor,
                                                          context: context),
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight *.015,
                                                    ),
                                                    Directionality(
                                                      textDirection: TextDirection.ltr,
                                                        child:BlocConsumer<HomeCubit,HomeStates>(builder: (context, state) {
                                                          return defaultTextFormField(
                                                              context: context,
                                                              controller: phoneController,
                                                              isPassword: false,
                                                              keyboardType: TextInputType.phone,
                                                              onPrefixIcon: ()async{
                                                                if(HomeCubit.get(context).shownButtonSheet) {
                                                                  HomeCubit.get(context).changeButtonSheet(isShow: false);
                                                                  Navigator.pop(context);
                                                                }else{
                                                                  showCodeOfCountryButtonSheet(context: context);
                                                                  HomeCubit.get(context).changeButtonSheet(isShow: true);
                                                                }
                                                              },
                                                              prefixWidget:countryPrefixIconOfTextField(context: context,country: HomeCubit.get(context).codeOfLocalCountry!=null?HomeCubit.get(context).codeOfLocalCountry!:HomeCubit.get(context).countryList[66]),
                                                              hint: phoneController.text=userData!.userAccount!.phoneNumber??"",
                                                              // isEnable: false,
                                                              onValidate: (value) {
                                                                if (value!.isEmpty) {
                                                                  return S.of(context).changePasswordText;
                                                                }
                                                                return null;
                                                              }
                                                          );
                                                        }, listener:(context, state) {

                                                        },),

                                                    ),

                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.00539,
                                              ),

                                              ///email text field
                                              Container(
                                                alignment: Alignment.center,
                                                width: screenWidth,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                        start: screenWidth * 0.0327,
                                                      ),
                                                      child:defaultText(
                                                          height: screenHeight * 0.0313,
                                                          text: S.of(context).emailText,
                                                          boxFit: BoxFit.fitHeight,
                                                          color: defaultGreyColor,
                                                          context: context),
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight *.015,
                                                    ),
                                                    Directionality(textDirection: TextDirection.ltr,
                                                        child: defaultTextFormField(
                                                            context: context,
                                                            controller: emailController,
                                                            keyboardType: TextInputType.emailAddress,
                                                            isEnable: false,
                                                            hint: userData!.userAccount!.email,
                                                            onTap: (){
                                                              emailController.text=userData!.userAccount!.email!;
                                                            },
                                                            onValidate: (value) {
                                                              return null;
                                                            }
                                                        ),),

                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.00539,
                                              ),

                                              ///change password button
                                              Container(
                                                alignment: Alignment.center,
                                                width: screenWidth,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(padding: EdgeInsetsDirectional.only(
                                                      start: screenWidth * 0.0327,
                                                    ),
                                                      child:defaultText(
                                                          height: screenHeight * 0.0313,
                                                          text: S.of(context).passwordText,
                                                          boxFit: BoxFit.fitHeight,
                                                          color: defaultGreyColor,
                                                          context: context),
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight *.015,
                                                    ),
                                                    defaultMaterialButton(
                                                      height: screenHeight * 0.0626,
                                                      context: context,
                                                      backgroundColor:defaultBlueAccentColor,
                                                      textColor:defaultWhiteColor,
                                                      text:S.of(context).changePasswordText,
                                                      onPress: ()async{
                                                        bool hasInternet=await NetworkConnection.getConnectivity();
                                                        if(!hasInternet){
                                                          showSnackBar(context: context, text: S.current.failedConnection);
                                                        }
                                                        navigateAndPush(context,ChangePasswordScreen());
                                                      },
                                                    ),

                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.00539,
                                              ),

                                              ///age text field
                                              Container(
                                                alignment: Alignment.center,
                                                width: screenWidth,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(padding: EdgeInsetsDirectional.only(
                                                      start: screenWidth * 0.0327,
                                                    ),
                                                      child:defaultText(
                                                          height: screenHeight * 0.0313,
                                                          text: S.of(context).dateOfBirth,
                                                          boxFit: BoxFit.fitHeight,
                                                          color: defaultGreyColor,
                                                          context: context),
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight *.015,
                                                    ),
                                                    Directionality(
                                                      child: InkWell(
                                                          onTap: ()async{
                                                            await showDatePicker(
                                                                context: context,
                                                                initialDate: DateTime.now(),
                                                                firstDate:DateTime(1900),
                                                                initialEntryMode: DatePickerEntryMode.calendar,
                                                                initialDatePickerMode: DatePickerMode.day,
                                                                lastDate:DateTime(2040)).then((value){
                                                              String month=value!.month.toString().length<2?"0${value.month}":value.month.toString();
                                                              dateController.text="${value.year}-$month-${value.day}";
                                                            },
                                                            );
                                                          },
                                                          child:defaultTextFormField(
                                                            context: context,
                                                            controller: dateController,
                                                            keyboardType: TextInputType.none,
                                                            hint: userData!.userAccount!.birthDate!,
                                                            isEnable: false,
                                                            onValidate: (value) {
                                                              if (value!.isEmpty) {
                                                                return  S.of(context).dateEmptyValidator;
                                                              }
                                                              return null;
                                                            },
                                                          )
                                                      ),
                                                      textDirection: TextDirection.ltr,
                                                    )
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.00539,
                                              ),

                                              ///Gender
                                              Container(
                                                alignment: Alignment.center,
                                                width: screenWidth,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(padding: EdgeInsetsDirectional.only(
                                                      start: screenWidth * 0.0327,
                                                    ),
                                                      child:defaultText(
                                                          height: screenHeight * 0.0313,
                                                          text: S.of(context).genderText,
                                                          textHeight: 1.3181,
                                                          textAlign: TextAlign.start,
                                                          boxFit: BoxFit.fitHeight,
                                                          color: defaultGreyColor,
                                                          context: context),
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight *.015,
                                                    ),
                                                    Container(
                                                      width: screenWidth,
                                                      height: screenHeight * 0.0626,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color:cubit.gender==Gender.male?defaultBlueAccentColor: Color(0xffEBEBEB),
                                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                                              ),
                                                              child: MaterialButton(
                                                                onPressed: () {
                                                                  SignInCubit.get(context).onChangeGender(gender: Gender.male);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      height: MediaQuery.sizeOf(context).height * 0.044,
                                                                      width: MediaQuery.sizeOf(context).width * 0.1051,
                                                                      child: Image.asset("assets/svgIcons/male.png",fit: BoxFit.cover,
                                                                        color:cubit.gender==Gender.male?defaultBlueAccentColor:Color(0xffEBEBEB),
                                                                        colorBlendMode: BlendMode.screen,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.sizeOf(context).width * 0.0053,
                                                                    ),
                                                                    defaultText(
                                                                        text: S.of(context).maleText,
                                                                        color:cubit.gender==Gender.male?defaultWhiteColor:defaultGreyColor,
                                                                        fontFamily: "Roboto",
                                                                        textHeight: 1.318,
                                                                        fontSize: 22,
                                                                        width: MediaQuery.sizeOf(context).width * 0.0817,
                                                                        height: MediaQuery.sizeOf(context).height * 0.0226,
                                                                        context: context),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.sizeOf(context).width * 0.0397,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color:cubit.gender==Gender.female?defaultBlueAccentColor: Color(0xffEBEBEB),
                                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                                              ),
                                                              child: MaterialButton(
                                                                onPressed: () {
                                                                  SignInCubit.get(context).onChangeGender(gender: Gender.female);
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      height: MediaQuery.sizeOf(context).height * 0.044,
                                                                      width: MediaQuery.sizeOf(context).width * 0.1051,
                                                                      child: Image.asset("assets/svgIcons/female.png",
                                                                        color:cubit.gender==Gender.female?defaultBlueAccentColor:Color(0xffEBEBEB),
                                                                        colorBlendMode: BlendMode.darken,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.sizeOf(context).width * 0.0053,
                                                                    ),
                                                                    defaultText(
                                                                        text: S.of(context).femaleText,
                                                                        color:cubit.gender==Gender.female?defaultWhiteColor:defaultGreyColor,
                                                                        fontFamily: "Roboto",
                                                                        textHeight: 1.318,
                                                                        fontSize: 22,
                                                                        width: MediaQuery.sizeOf(context).width * 0.1214,
                                                                        height: MediaQuery.sizeOf(context).height * 0.0226,
                                                                        context: context),
                                                                  ],
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

                                              SizedBox(
                                                height: screenHeight * 0.0367,
                                              ),

                                              ///medical patient file
                                              defaultMaterialButton(
                                                height: screenHeight * 0.0626,
                                                context: context,
                                                backgroundColor:defaultBlueAccentColor,
                                                textColor:defaultWhiteColor,
                                                text:S.of(context).medicalPatientFileText,
                                                onPress: ()async{
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
                                                      navigateAndPush( context , MedicalPatientDetailsScreen());
                                                    }
                                                    showSnackBar(context: context, text: S.current.failedConnection);
                                                  }
                                                },
                                              ),

                                              SizedBox(
                                                height: screenHeight * 0.0269,
                                              ),

                                              ///save change button
                                              defaultMaterialButton(
                                                height: screenHeight * 0.0626,
                                                context: context,
                                                backgroundColor:defaultBlueAccentColor,
                                                textColor:defaultWhiteColor,
                                                text:S.of(context).saveChangesText,
                                                onPress: ()async{
                                                    UserAccountLoginPage user=cubit.userModel!;
                                                    user.fullName="${firstNameController.text} ${middleNameController.text} ${lastNameController.text}";
                                                    user.firstName=firstNameController.text.length!=0?firstNameController.text:cubit.userModel!.firstName;
                                                    user.middleName=middleNameController.text;
                                                    user.lastName=lastNameController.text.length!=0?lastNameController.text:cubit.userModel!.lastName;
                                                    if(cubit.pathImage !=null){
                                                      var formData = FormData.fromMap({
                                                        "image": await MultipartFile.fromFile(
                                                            cubit.pathImage!.path,
                                                            contentType: MediaType("multipart/*","text/plain")
                                                        ),
                                                      });
                                                      await cubit.updateImageProfile(
                                                        context: context,
                                                        formData: formData,
                                                      );

                                                    }
                                                    user.phoneNumber=phoneController.text;
                                                    user.email=emailController.text.length !=0 ? emailController.text:cubit.userModel!.email;
                                                    user.birthDate=dateController.text.length !=0 ?dateController.text:cubit.userModel!.birthDate;
                                                    user.gender=cubit.gender == Gender.male?"male":"female";
                                                    bool hasInternet=await NetworkConnection.getConnectivity();
                                                    if(hasInternet){
                                                      showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                      cubit.onChangeUserData(object: user);
                                                      await cubit.updateData(context: context,data: SignInCubit.get(context).userModel!.toMap()).then((value){
                                                        Navigator.pop(context);
                                                        showDialog(context: context, builder:(context) => defaultDialog(context: context, text: S.current.profileUpdatedSuccessfully),);
                                                      });
                                                    }else{
                                                      showSnackBar(context: context, text: S.current.failedConnection);
                                                    }

                                                },
                                              ),

                                            ],
                                          );
                                        },
                                        fallback:(context) {
                                          return Container(
                                            height: screenHeight *0.49,
                                          );
                                        }
                                    ),
                                  ),
                                ),
                              ),

                              ///image profile
                              Align(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: ()async{
                                    await cubit.pickImage();
                                  },
                                  child: Container(
                                    height: screenHeight * 0.2230,
                                    width: screenWidth * 0.4824,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: defaultBlackColor
                                              .withAlpha(20),
                                          offset: Offset(0, 0),
                                          blurRadius: 15,
                                          blurStyle: BlurStyle.outer,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 100,
                                      // backgroundImage:
                                      child:cubit.pathImage!=null || userData!.userAccount!.image ==null?Image(image: FileImage(cubit.pathImage!))
                                          :Image.network(userData!.userAccount!.image!),
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
                ///navBar
                bottomNavigationBar:appNavBarFixed(context: context),
                extendBody: true,

              ),
            );
          },
        );
      },
    );
  }

  ///show button sheet of country when press on it
  showCodeOfCountryButtonSheet({
    required BuildContext context,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => codeOfCountryButtonSheet(context: context,countryController: CodeOfCountryController ,fromUser: false ),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 1)),).closed.then((value)async{
      CodeOfCountryController.text="";
      ///local country => global country of application
      // if(HomeCubit.get(context).localCountry!=null) {
      //   ///get country id from api depending on local country value
      //   SignInCubit.get(context).getCountryNumber(context: context);
      // }
      HomeCubit.get(context).changeButtonSheet(isShow: false);
    });
  }
}
