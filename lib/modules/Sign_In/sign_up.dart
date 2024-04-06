import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/models/register_model.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/shared/components/components_2.dart';
import 'package:Gene/shared/components/constants.dart';

import '../../generated/l10n.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with TickerProviderStateMixin{
  late double screenHeight;

  late double screenWidth;

  ///first name controller that control first name value written by user
  TextEditingController firstNameController = TextEditingController();

  ///last name controller that control last name value written by user
  TextEditingController lastNameController = TextEditingController();

  ///middle name controller that control middle name value written by user
  TextEditingController middleNameController = TextEditingController();

  ///country controller that control country name selected by user
  TextEditingController countryController = TextEditingController();

  ///code of country controller that control code of country with phone
  TextEditingController CodeOfCountryController = TextEditingController();

  ///address controller that control address value written by user
  TextEditingController addressController = TextEditingController();

  ///Date controller that control Date value selected by user
  TextEditingController dateController = TextEditingController();

  ///phone controller that control phone value written by user
  TextEditingController phoneController = TextEditingController();

  ///email controller that control email value written by user
  TextEditingController emailController = TextEditingController();

  ///password controller that control password value written by user
  TextEditingController passwordController = TextEditingController();


  ///scaffold controller that control scaffold state
  var scaffoldKey=GlobalKey<ScaffoldState>();

  ///formKey controller that control Form state
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return BlocConsumer<SignInCubit,SignInState>(
      listener: (context, state) async{
        if(state is OnSuccessRegisterStates){
          if(state.value!.statusCode==200){
            ///verify email that user register with
            ///after register
            showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
            await SignInCubit.get(context).forgetPasswordWithEmail(context: context, email: emailController.text.trim(), forgetPass: false).then((value){
              SignInCubit.get(context).onChangeEmailVerification(email: emailController.text.trim());
            });
          }
        }
      },
      builder: (context, state) {
        var cubit=SignInCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar:statusBar(),
          body: Padding(
            padding: EdgeInsetsDirectional.only(
              start: screenWidth * 0.0350,
              end: screenWidth * 0.0350,
            ),
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                    SizedBox(
                      height:screenHeight * 0.0151 ,
                    ),

                    ///title sign up
                    defaultText(
                      text: S.of(context).titleSignUpPage,
                      color:defaultGreyColor,
                      textAlign: TextAlign.center,
                      alignment: AlignmentDirectional.center,
                      boxFit: BoxFit.fitHeight,
                      height:screenHeight * 0.0313,
                      context: context,
                    ),

                   SizedBox(
                     height:screenHeight * 0.0043 ,
                   ),

                    ///first name and last name field field
                    Row(
                      children: [
                        ///first name
                        Expanded(
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
                                  text: S.of(context).firstNameText,
                                  boxFit: BoxFit.fitHeight,
                                  color: defaultGreyColor,
                                  context: context
                              ),
                              ),
                              defaultTextFormField(
                                  context: context,
                                  controller: firstNameController,
                                  keyboardType: TextInputType.text,
                                  onValidate: (value) {
                                    if (value!.isEmpty) {
                                      return  S.of(context).validatorFirstNameText;
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: screenWidth * 0.0350,
                        ),

                        ///last name
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
                                    text: S.of(context).lastNameText,
                                    boxFit: BoxFit.fitHeight,
                                    color: defaultGreyColor,
                                    context: context
                                ),
                              ),
                              // Spacer(),
                              defaultTextFormField(
                                  context: context,
                                  controller: lastNameController,
                                  keyboardType: TextInputType.text,
                                  onValidate: (value) {
                                    if (value!.isEmpty) {
                                      return  S.of(context).validatorLastNameText;
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                    ///middle name
                    Container(
                      alignment: Alignment.center,
                      // height: screenHeight * 0.10151,
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
                          // Spacer(),
                          defaultTextFormField(
                              context: context,
                              controller: middleNameController,
                              keyboardType: TextInputType.text,
                              onValidate: (value) {
                                if (value!.isEmpty) {
                                  return  S.of(context).validatorMiddleNameText;
                                }
                                return null;
                              }
                              ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                    ///phone text field and country
                    Container(
                      alignment: Alignment.center,
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
                                text: S.of(context).phoneText,
                                boxFit: BoxFit.fitHeight,
                                color: defaultGreyColor,
                                context: context),
                          ),

                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: BlocConsumer<HomeCubit,HomeStates>(
                              listener: (context, state){

                              },
                              builder:(context, state) {
                                return defaultTextFormField(
                                    context: context,
                                    controller: phoneController,
                                    isPassword: false,
                                    hint: "+${HomeCubit.get(context).localCountry != null ?HomeCubit.get(context).localCountry!.phoneCode :HomeCubit.get(context).countryList[0].phoneCode} ${HomeCubit.get(context).localCountry !=null ?HomeCubit.get(context).localCountry!.example :HomeCubit.get(context).countryList[0].example}",
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
                                    onTap: (){
                                      // phoneController.text=HomeCubit.get(context).localCountry !=null ?HomeCubit.get(context).localCountry!.phoneCode :HomeCubit.get(context).countryList[0].phoneCode;
                                    },
                                    prefixWidget:countryPrefixIconOfTextField(context: context,country:HomeCubit.get(context).codeOfLocalCountry!=null?HomeCubit.get(context).codeOfLocalCountry!:HomeCubit.get(context).countryList[SignInCubit.get(context).countryId!]),
                                    onValidate: (value) {
                                      if (value!.isEmpty) {
                                        return  S.of(context).phoneEmptyValidator;
                                      }
                                      return null;
                                    }
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                    ///states & country
                    Row(
                      children: [
                        ///country
                        Expanded(
                          child: BlocConsumer<HomeCubit,HomeStates>(
                            listener: (context, state) {

                            },
                            builder: (context, state) {
                              return // SignInCubit.get(context).allStates.length != 0?
                                Container(
                                  alignment: Alignment.center,
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
                                            text: S.current.countryTitle,
                                            boxFit: BoxFit.fitHeight,
                                            color: defaultGreyColor,
                                            context: context),
                                      ),

                                      InkWell(
                                        child: Container(
                                          height: screenHeight * 0.0583,
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
                                                    text: HomeCubit.get(context).localCountry !=null?HomeCubit.get(context).localCountry!.name:"Select",
                                                    height:screenHeight * 0.02591,
                                                    color: Color(0xff707070),
                                                    fontSize: 18,
                                                    textHeight: 1.333,
                                                    fontFamily: "Roboto",
                                                    boxFit: BoxFit.fitHeight,
                                                    context: context),
                                                cubit.openedDownListCountry==false?Icon(Icons.arrow_drop_down_sharp):
                                                Icon(Icons.arrow_drop_up),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          if(HomeCubit.get(context).shownButtonSheet) {
                                            HomeCubit.get(context).changeButtonSheet(isShow: false);
                                            cubit.onOpenedDropDownListCountry(opened: false);
                                            Navigator.pop(context);
                                          }else{
                                            showCountryButtonSheet(context: context);
                                            cubit.onOpenedDropDownListCountry(opened: true);
                                            HomeCubit.get(context).changeButtonSheet(isShow: true);
                                          }
                                        },
                                      ),

                                    ],
                                  ),
                                );
                              // :Container();
                            },
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.03,
                        ),

                        ///state of country
                        ///if allStates not null show popup menu of states
                        ///when user detect his country system load states of country
                        Expanded(
                          child: Builder(
                              builder: (context) {
                                return BlocConsumer<HomeCubit,HomeStates>(
                                  listener: (context, state) {

                                  },
                                  builder: (context, state) {
                                    return // SignInCubit.get(context).allStates.length != 0?
                                      Container(
                                        alignment: Alignment.center,
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
                                                  text: S.current.stateOfCountry,
                                                  boxFit: BoxFit.fitHeight,
                                                  color: defaultGreyColor,
                                                  context: context),
                                            ),
                                            Container(
                                              child: PopupMenuButton(
                                                onOpened: (){
                                                  cubit.onOpenedDropDownListState(opened: true);
                                                },
                                                onCanceled: (){
                                                  cubit.onOpenedDropDownListState(opened: false);
                                                },
                                                onSelected: (index)async{
                                                  cubit.onOpenedDropDownListState(opened: false);
                                                  await cubit.onChangeStateOFCountryState(index: index,);
                                                },
                                                color: defaultWhiteColor,
                                                elevation: 0,
                                                splashRadius:15,
                                                constraints: BoxConstraints.tight(Size(screenWidth * 0.929,
                                                    screenHeight *0.5010)),
                                                offset: Offset(screenWidth * 0.0,screenHeight *0.04),
                                                itemBuilder:(context) =>List.generate(
                                                    cubit.allStates.length,
                                                        (index) => PopupMenuItem(
                                                      child:Container(
                                                        height: screenHeight * 0.0259,
                                                        child:Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            defaultText(
                                                                text: cubit.allStates[index].name!,
                                                                height:screenHeight * 0.02591,
                                                                color: Color(0xff707070),
                                                                fontSize: 18,
                                                                textHeight: 1.333,
                                                                fontFamily: "Roboto",
                                                                boxFit: BoxFit.fitHeight,
                                                                context: context),
                                                            BlocConsumer<SignInCubit,SignInState>(
                                                              builder: (context, state) {
                                                                return Checkbox.adaptive(
                                                                  activeColor:Color(0xff707070),
                                                                  hoverColor: null,
                                                                  shape: CircleBorder(),
                                                                  value:cubit.allStates[index].check,
                                                                  onChanged: (check){
                                                                    cubit.onChangeStateOFCountryState(index: index);
                                                                  },
                                                                );
                                                              },
                                                              listener: (context, state) {

                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      value: index,)),
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
                                                            text: cubit.stateCountryModel !=null?cubit.stateCountryModel!.name!:"Select",
                                                            height:screenHeight * 0.02591,
                                                            color: Color(0xff707070),
                                                            fontSize: 18,
                                                            textHeight: 1.333,
                                                            fontFamily: "Roboto",
                                                            boxFit: BoxFit.fitHeight,
                                                            context: context),
                                                        cubit.openedDownListState==false?Icon(Icons.arrow_drop_down_sharp):
                                                        Icon(Icons.arrow_drop_up),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(0),
                                              ),
                                              width: screenWidth,
                                              height: screenHeight * 0.0583,
                                            ),
                                          ],
                                        ),
                                      );
                                    // :Container();
                                  },
                                );
                              }
                          ),
                        ),
                      ],
                    ),

                    ///email text field
                    Container(
                      alignment: Alignment.center,
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
                          defaultTextFormField(
                              context: context,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onValidate: (value) {
                                if (value!.isEmpty) {
                                  return  S.of(context).emailEmptyValidator;
                                }
                                return null;
                              }),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                    ///password text field
                    Container(
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
                                text: S.of(context).passwordText,
                                boxFit: BoxFit.fitHeight,
                                color: defaultGreyColor,
                                context: context),
                          ),
                          defaultTextFormField(
                              context: context,
                              controller: passwordController,
                              onSuffixIcon: (){
                                cubit.onChangePasswordVisibility();
                              },
                              suffixIconSvg: cubit.hiddenPassword?"assets/svgIcons/not-visible.png":"assets/svgIcons/visible.png",
                              isPassword: cubit.hiddenPassword,
                              keyboardType: TextInputType.visiblePassword,
                              onValidate: (value) {
                                if (value!.isEmpty) {
                                  return  S.of(context).passwordEmptyValidator;
                                }else if(value.length < 6){
                                  return  "Password length must be at least 6";
                                }
                                return null;
                              })
                        ],
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                    ///address
                    Container(
                          alignment: Alignment.center,
                          // height: screenHeight * 0.10151,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsetsDirectional.only(
                                start: screenWidth * 0.0327,
                              ),
                                child:defaultText(
                                    height: screenHeight * 0.0313,
                                    text: S.of(context).addressText,
                                    boxFit: BoxFit.fitHeight,
                                    color: defaultGreyColor,
                                    context: context
                                ),
                              ),
                              // Spacer(),
                              defaultTextFormField(
                                  context: context,
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  onValidate: (value) {
                                    if (value!.isEmpty) {
                                      return  S.of(context).validatorAddressText;
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),

                    SizedBox(
                          height: screenHeight * 0.02,
                        ),

                    ///date text field
                    Container(
                      alignment: Alignment.center,
                      // height: screenHeight * 0.10151,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:EdgeInsetsDirectional.only(
                              start: screenWidth * 0.0327,
                            ),
                            child:defaultText(
                                height: screenHeight * 0.0313,
                                text:  S.of(context).dateOfBirth,
                                boxFit: BoxFit.fitHeight,
                                color: defaultGreyColor,
                                context: context),
                          ),
                          // Spacer(),
                          InkWell(
                            onTap: ()async{
                              await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:DateTime(1900),
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDatePickerMode: DatePickerMode.day,
                              lastDate:DateTime(2040)).then((value){
                                String month=value!.month.toString().length<2?"0${value.month}":value.month.toString();
                                dateController.text="${value.year}-${month}-${value.day}";
                              },
                              );
                            },
                           child:defaultTextFormField(
                             context: context,
                             controller: dateController,
                             keyboardType: TextInputType.none,
                             isEnable: false,
                             onValidate: (value) {
                               if (value!.isEmpty) {
                                 return  S.of(context).dateEmptyValidator;
                               }
                               return null;
                             },
                           )
                          )

                        ],
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.025,
                    ),

                    ///Gender
                    Container(
                      alignment: Alignment.center,
                      // height: screenHeight * 0.1015,
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
                                text:  S.of(context).genderText,
                                textHeight: 1.3181,
                                textAlign: TextAlign.start,
                                boxFit: BoxFit.fitHeight,
                                color: defaultGreyColor,
                                context: context),
                          ),
                          // Spacer(),

                          Container(
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
                                        cubit.onChangeGender(gender: Gender.male);
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
                                              text:  S.of(context).maleText,
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
                                        cubit.onChangeGender(gender: Gender.female);
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
                                              text:  S.of(context).femaleText,
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
                      height: screenHeight * 0.04,
                    ),

                    ///sign up button
                    defaultMaterialButton(
                      height: screenHeight * 0.0626,
                        context: context,
                        backgroundColor:defaultBlueAccentColor,
                        textColor:defaultWhiteColor,
                        text: S.of(context).signUpButton,
                        onPress: () async {
                          bool hasInternet=await NetworkConnection.getConnectivity();
                          if(formKey.currentState!.validate()){
                            if(hasInternet){
                              if(cubit.stateCountryModel !=null ){
                                UserAccountRegisterPage user =UserAccountRegisterPage(
                                  firstName:firstNameController.text,
                                  middleName:middleNameController.text,
                                  lastName:lastNameController.text,
                                  email: emailController.text.trim().toString(),
                                  password:passwordController.text,
                                  birthDate: dateController.text,
                                  address: addressController.text,
                                  country: "${cubit.countryId??"0"}",
                                  state: "${cubit.stateCountryModel!.id??null}",
                                  fullName:"${firstNameController.text} ${middleNameController.text} ${lastNameController.text}",
                                  gender:cubit.gender.toString(),
                                  phoneNumber: phoneController.text,
                                  language: languageApp,
                                );
                                showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                cubit.onChangeRegisterDataModel(object: user);
                                await cubit.registerAccount(context: context,model: user);
                              }else{
                                showDialog(context: context, builder: (context) => defaultDialog(context: context, text: S.of(context).countryAndState),);
                              }
                            }else{
                              showSnackBar(context: context, text: S.current.failedConnection);
                            }
                      }
                        },
                    ),

                    SizedBox(
                      height: screenHeight * 0.0226,
                    ),

                    ///continue with
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.0334,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.00215,
                              color: Color(0xff707070),
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.334,
                            height: MediaQuery.sizeOf(context).height * 0.0313,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffD8D8D8),
                                  width: 1,
                                )),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 1.0,
                                end: 1,
                              ),
                              child: FittedBox(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  S.of(context).or_continue_text_devider,
                                  style: TextStyle(
                                    color: Color(0xff040404),
                                    fontFamily: "Roboto",
                                    height: 1.333,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.00215,
                              color: Color(0xff707070),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.0097,
                    ),

                    ///google and facebook
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.0626,
                      child: Row(
                        children: [
                          ///google button
                          Expanded(
                            child: defaultMaterialButton(
                            height: screenHeight * 0.0626,
                          context: context,
                          backgroundColor:Color(0xffEBEBEB),
                          textColor:defaultGreyColor,
                          text:  S.of(context).googleTextButton,
                          onPress: ()async{
                            bool hasInternet=await NetworkConnection.getConnectivity();
                            if(!hasInternet){
                              showSnackBar(context: context, text: S.current.failedConnection);
                            }
                            await cubit.signInWithGoogle(context: context);
                          },
                          assetImageIcon:"assets/svgIcons/google.png",
                      ),
                      ),

                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.02,
                          ),

                          ///facebook button
                          Expanded(
                          child: defaultMaterialButton(
                          height: screenHeight * 0.0626,
                          context: context,
                          backgroundColor:Color(0xffEBEBEB),
                          textColor:defaultGreyColor,
                          text:  S.of(context).facebookTextButton,
                          onPress: ()async{
                            bool hasInternet=await NetworkConnection.getConnectivity();
                            if(!hasInternet){
                              showSnackBar(context: context, text: S.current.failedConnection);
                            }
                           await cubit.signInWithFaceBook(context: context);
                          },
                          assetImageIcon:"assets/svgIcons/facebook.png" ,
                          ),),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.02,
                    ),

                  ]
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


///show button sheet of country when press on it
showCountryButtonSheet({
  required BuildContext context,
})async{
  scaffoldKey.currentState!.showBottomSheet((context) => countryButtonSheet(context: context,countryController: countryController ,fromUser: false ),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 2)),).closed.then((value)async{
    countryController.text="";
    ///local country => global country of application
    if(HomeCubit.get(context).localCountry!=null) {
        ///get country id from api depending on local country value
        SignInCubit.get(context).getCountryNumber(context: context);
      }
      if(SignInCubit.get(context).countryId != null) {
      showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
      ///get states of country from apis
      await SignInCubit.get(context).getStatesOfCountries(SignInCubit.get(context).countryId!).then((value){
        Navigator.pop(context);
      });
    }
    SignInCubit.get(context).onOpenedDropDownListCountry(opened: false);
    SignInCubit.get(context).onOpenedDropDownListState(opened: false);
    HomeCubit.get(context).changeButtonSheet(isShow: false);
  });
}


  ///show button sheet of country when press on it
  showCodeOfCountryButtonSheet({
    required BuildContext context,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => codeOfCountryButtonSheet(context: context,countryController: CodeOfCountryController ,fromUser: false ),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 2)),).closed.then((value)async{
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
