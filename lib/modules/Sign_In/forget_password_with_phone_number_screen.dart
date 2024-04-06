import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/shared/components/components_2.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';

class ForgetPasswordWithPhoneNumberScreen extends StatefulWidget {
  ForgetPasswordWithPhoneNumberScreen({super.key});

  @override
  State<ForgetPasswordWithPhoneNumberScreen> createState() => _ForgetPasswordWithPhoneNumberScreenState();
}

class _ForgetPasswordWithPhoneNumberScreenState extends State<ForgetPasswordWithPhoneNumberScreen> with TickerProviderStateMixin{

  late double screenHeight;
  late double screenWidth;

  ///phone number controller that control with text of phone
  TextEditingController phoneNumberController = TextEditingController();

  ///country controller that control with text of country name in Button Sheet
  TextEditingController countryController = TextEditingController();

  var scaffoldKey=GlobalKey<ScaffoldState>();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        return BlocConsumer<SignInCubit,SignInState>(
          listener: (context, state) {

          },
          builder: (context, state) {

            var cubit=SignInCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: statusBar(),
              body: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: screenWidth * 0.0350,
                  end: screenWidth * 0.0350,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                      SizedBox(
                        height:screenHeight * 0.0518 ,
                      ),
                      ///title screen
                      defaultText(
                          text: S.of(context).forgetPasswordText,
                          color:defaultGreyColor,
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional.center,
                          height:screenHeight * 0.039,
                          fontSize: 25,
                          context: context),
                      SizedBox(
                        height:screenHeight * 0.0259 ,
                      ),
                      ///image
                      Container(
                        height:screenHeight * 0.276,
                        width:screenWidth * 0.7009,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: defaultBlackColor.withAlpha(18),
                            //     blurRadius: 25,
                            //     blurStyle: BlurStyle.outer,
                            //   ),
                            // ],
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset("assets/Background/splash.png",fit: BoxFit.fill,),
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.0626,
                      ),

                      ///phone text field and country
                      Container(
                        alignment: Alignment.center,
                        // height: screenHeight * 0.10151,
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
                            BlocConsumer<HomeCubit,HomeStates>(
                              listener: (context, state) {

                              },
                              builder:(context, state) {
                                return defaultTextFormField(
                                    context: context,
                                    controller: phoneNumberController,
                                    isPassword: false,
                                    hint: "+${HomeCubit.get(context).localCountry !=null ?HomeCubit.get(context).localCountry!.phoneCode :HomeCubit.get(context).countryList[0].phoneCode} ${HomeCubit.get(context).localCountry !=null ?HomeCubit.get(context).localCountry!.example :HomeCubit.get(context).countryList[0].example}",
                                    keyboardType: TextInputType.phone,
                                    onPrefixIcon: ()async{
                                      if(HomeCubit.get(context).shownButtonSheet) {
                                        HomeCubit.get(context).changeButtonSheet(isShow: false);
                                        Navigator.pop(context);
                                      }else{
                                        showCountryButtonSheet(context: context);
                                        HomeCubit.get(context).changeButtonSheet(isShow: true);
                                      }
                                    },
                                    onTap: (){
                                      // phoneController.text=HomeCubit.get(context).localCountry !=null ?HomeCubit.get(context).localCountry!.phoneCode :HomeCubit.get(context).countryList[0].phoneCode;
                                    },
                                    prefixWidget:countryPrefixIconOfTextField(context: context,country:HomeCubit.get(context).localCountry!=null?HomeCubit.get(context).localCountry!:HomeCubit.get(context).countryList[65]),
                                    onValidate: (value) {
                                      if (value!.isEmpty) {
                                        return  S.of(context).phoneEmptyValidator;
                                      }
                                      return null;
                                    }
                                );
                              },
                            )

                          ],
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.0539,
                      ),

                      ///send button
                      defaultMaterialButton(
                        height: screenHeight * 0.0626,
                        context: context,
                        backgroundColor:defaultBlueAccentColor,
                        textColor:defaultWhiteColor,
                        text:S.of(context).sendText,
                        onPress: ()async{
                          await cubit.forgetPasswordWithPhoneNumber(context: context, phone:phoneNumberController.text,forgetPass: true).then((value){
                            // cubit.onChangeEmailVerification(email: emailController.text.trim());
                          });
                        },
                      ),

                      SizedBox(
                        height: screenHeight * 0.03,
                      ),


                    ]),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }

  showCountryButtonSheet({
    required BuildContext context,
  })async{
    scaffoldKey.currentState!.showBottomSheet((context) => countryButtonSheet(context: context,countryController: countryController,fromUser: false),transitionAnimationController: AnimationController(vsync:this ,duration: Duration(seconds: 2)),).closed.then((value)async{
      countryController.text="";
      if(HomeCubit.get(context).localCountry!=null) {
        SignInCubit.get(context).getCountryNumber(context: context);
      }
      HomeCubit.get(context).changeButtonSheet(isShow: false);
    });
  }
}
