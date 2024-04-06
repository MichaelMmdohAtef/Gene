import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key});
   late double screenHeight;
   late double screenWidth;

   ///current password controller that control value of password written by user
   TextEditingController currentPasswordController = TextEditingController();

   ///new password controller that control value of password written by user
   TextEditingController newPasswordController = TextEditingController();

   ///confirm new password controller that control value of password written by user
   TextEditingController confirmNewPasswordController = TextEditingController();

   var scaffoldKey=GlobalKey<FormState>();
   @override
   Widget build(BuildContext context) {
     screenHeight = MediaQuery.sizeOf(context).height;
     screenWidth = MediaQuery.sizeOf(context).width;
     return Builder(
       builder: (context) {

         return BlocConsumer<SignInCubit,SignInState>(
           listener: (context, state) {
             if(state is OnSuccessChangePassword) {
               showDialog(context: context, builder: (context) => dialog(
                 image: languageApp !="ar"?
                 dialogImageOfChangePasswordConfirmationEN:
                 dialogImageOfChangePasswordConfirmationAR,
                 context: context,
                 heightContainer:screenHeight * 0.6144,
                 child: confirmNewPasswordDialog(context: context),
               ),);
             }
           },
           builder: (context, state) {
             var cubit=SignInCubit.get(context);
             return Scaffold(
               appBar: statusBar(),
               body: Padding(
                 padding: EdgeInsetsDirectional.only(
                   start: screenWidth * 0.0350,
                   end: screenWidth * 0.0350,
                 ),
                 child: SingleChildScrollView(
                   child: Form(
                     key: scaffoldKey,
                     child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center, children: [

                       SizedBox(
                         height:screenHeight * 0.0334,
                       ),

                       ///title of page
                       defaultText(
                           text: S.of(context).titleCreateNewPassPage,
                           color:defaultGreyColor,
                           height:screenHeight * 0.042,
                           alignment: AlignmentDirectional.center,
                           fontSize: 30,
                           context: context),

                       SizedBox(
                         height:screenHeight * 0.0442 ,
                       ),

                       ///header image of screen
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
                             borderRadius: BorderRadius.all(Radius.circular(10))
                         ),
                         child:Padding(
                           padding: const EdgeInsets.all(15),
                           child: Image.asset(
                             languageApp!="ar"?
                             imageChangePasswordScreenEN:
                             imageChangePasswordScreenAR,
                             fit: BoxFit.fill,),
                         ),
                       ),

                       SizedBox(
                         height: screenHeight * 0.0259,
                       ),

                       ///Current password field
                       Container(
                         alignment: Alignment.center,
                         width: screenWidth,
                         // height: screenHeight * 0.1036,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(padding: EdgeInsetsDirectional.only(
                               start: screenWidth * 0.0327,
                             ),
                               child:defaultText(
                                   height: screenHeight * 0.0313,
                                   text: S.of(context).currentPasswordText,
                                   boxFit: BoxFit.fitHeight,
                                   color: defaultGreyColor,
                                   context: context),
                             ),

                             SizedBox(
                               height:screenHeight * 0.00518,
                             ),

                             defaultTextFormField(
                                 context: context,
                                 controller: currentPasswordController,
                                 onSuffixIcon: (){
                                   cubit.onChangePasswordVisibility();
                                 },
                                 suffixIconSvg: cubit.hiddenPassword?"assets/svgIcons/not-visible.png":"assets/svgIcons/visible.png",
                                 isPassword: cubit.hiddenPassword,
                                 keyboardType: TextInputType.visiblePassword,
                                 onValidate: (value) {
                                   if (value!.isEmpty) {
                                     return S.of(context).currentPasswordEmptyValidator;
                                   }
                                   return null;
                                 })

                           ],
                         ),
                       ),

                       SizedBox(
                         height: screenHeight * 0.0137,
                       ),

                       ///new password field
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
                                   text: S.of(context).titleNewPassPage,
                                   boxFit: BoxFit.fitHeight,
                                   color: defaultGreyColor,
                                   context: context),
                             ),
                             SizedBox(
                               height:screenHeight * 0.00518 ,
                             ),
                             defaultTextFormField(
                                 context: context,
                                 controller: newPasswordController,
                                 onSuffixIcon: (){
                                   cubit.onChangePasswordVisibility();
                                 },
                                 suffixIconSvg: cubit.hiddenPassword?"assets/svgIcons/not-visible.png":"assets/svgIcons/visible.png",
                                 isPassword: cubit.hiddenPassword,
                                 keyboardType: TextInputType.visiblePassword,
                                 onValidate: (value) {
                                   if (value!.isEmpty) {
                                     return S.of(context).newPasswordEmptyValidator;
                                   }
                                   return null;
                                 })
                           ],
                         ),
                       ),

                       SizedBox(
                         height: screenHeight * 0.0137,
                       ),

                       ///Confirm new password field
                       Container(
                         alignment: Alignment.center,
                         width: screenWidth,
                         // height: screenHeight * 0.1036,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(padding: EdgeInsetsDirectional.only(
                               start: screenWidth * 0.0327,
                             ),
                               child:defaultText(
                                   height: screenHeight * 0.0313,
                                   text: S.of(context).confirmPasswordText,
                                   boxFit: BoxFit.fitHeight,
                                   color: defaultGreyColor,
                                   context: context),
                             ),
                             // Spacer(),
                             SizedBox(
                               height:screenHeight * 0.00518,
                             ),
                             defaultTextFormField(
                                 context: context,
                                 controller:confirmNewPasswordController ,
                                 onSuffixIcon: (){
                                   cubit.onChangePasswordVisibility();
                                 },
                                 suffixIconSvg: cubit.hiddenPassword?"assets/svgIcons/not-visible.png":"assets/svgIcons/visible.png",
                                 isPassword: cubit.hiddenPassword,
                                 keyboardType: TextInputType.visiblePassword,
                                 onValidate: (value) {
                                   if (value!.isEmpty) {
                                     return S.of(context).confirmNewPasswordEmptyValidator;
                                   }
                                   return null;
                                 })
                           ],
                         ),
                       ),

                       SizedBox(
                         height: screenHeight * 0.03751,
                       ),

                       ///Continue
                       defaultMaterialButton(
                         height: screenHeight * 0.0626,
                         context: context,
                         backgroundColor:defaultBlueAccentColor,
                         textColor:defaultWhiteColor,
                         text:S.of(context).continueText,
                         onPress: ()async{
                             if(scaffoldKey.currentState!.validate()){
                               bool hasInternet=await NetworkConnection.getConnectivity();
                               if(hasInternet){
                                 showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                 cubit.changePassword(context: context,
                                     oldPass:currentPasswordController.text,
                                     pass: newPasswordController.text,
                                     passConfirmation: confirmNewPasswordController.text).then((value){
                                       Navigator.pop(context);
                                 });
                               }else{
                                 showSnackBar(context: context, text: S.current.failedConnection);
                               }

                             }
                         },
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

   ///dialog to ensure if user still want to change password or not
   confirmNewPasswordDialog({
     required BuildContext context,
   }){
     return Column(
       children: [

         SizedBox(
           height: screenHeight * 0.0377,
         ),
         ///text
         defaultText(
             height:screenHeight * 0.0626,
             width: screenWidth * 0.7056,
             text: S.of(context).successPassChangedText,
             fontSize: 22,
             alignment: AlignmentDirectional.center,
             textHeight: 1.3181,
             textAlign: TextAlign.center,
             boxFit: BoxFit.fitHeight,
             color: defaultGreyColor,
             context: context),

         SizedBox(
           height: screenHeight * 0.0280,
         ),

         ///back button
         defaultMaterialButton(
             height:screenHeight * 0.0626,
             context: context,
             backgroundColor: defaultBlueAccentColor,
             textColor:defaultWhiteColor,
             text: S.of(context).signInButton,
             onPress: ()async{
               userTokenApi=null;
               SignInCubit.get(context).onChangeUserDataOfLogIn(object:null);
               navigateAndFinish( context,SignInScreen());
               // await SignInCubit.get(context).signInWithPass(context: context,
               //     email:SignInCubit.get(context).loginDataModel!.userAccount!.email.toString(), pass: newPasswordController.text).then((value) {
               //   navigateAndFinish(context, MyProfileScreen());
               // });
             }),
       ],
     );
   }
}
