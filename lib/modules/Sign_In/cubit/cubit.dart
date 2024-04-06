import 'dart:io';

import 'package:Gene/shared/components/splash_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/modules/Sign_In/new_password_page.dart';
import 'package:Gene/modules/Sign_In/verification_screen.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/models/countries.dart';
import 'package:Gene/models/login_model.dart';
import 'package:Gene/models/register_model.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:Gene/shared/network/cache_memory/shared_preferences.dart';
import 'package:Gene/shared/network/remote_network/dio_helper.dart';
import 'package:Gene/shared/network/remote_network/end_point.dart';
import '../../../generated/l10n.dart';

class SignInCubit extends Cubit<SignInState>{

  SignInCubit():super(SignInInitState());

  static SignInCubit get(context)=>BlocProvider.of(context);
  bool hiddenPassword=true;
  Gender? gender=null;
  List<StatesModel> allStates=[];
  List<Countries> allCountries=[];
  UserAccountRegisterPage? registerModel;
  FirebaseAuth auth=FirebaseAuth.instance;
  int? countryId = int.parse(countryApp);
  StatesModel? stateCountryModel = null;
  String? smsCode;
  bool initValueForVerificationScreen=false;
  String? emailVerification;
  bool? openedDownListState=false;
  final storageRef=FirebaseStorage.instance.ref();

  ///set pass is hidden or not
  onChangePasswordVisibility(){
    hiddenPassword=!hiddenPassword;
    emit(OnChangePasswordVisibilityState());
  }

  ///initialize value of pin put for verification screen
  onInitialVerificationScreen(){
    initValueForVerificationScreen=!initValueForVerificationScreen;
    print(initValueForVerificationScreen);
    emit(OnInitialVerificationScreen());
  }



  ///on change gender
  onChangeGender({required Gender gender}){
    this.gender=gender;
    emit(OnChangeGenderState());
  }

  ///on change email verification of user
  onChangeEmailVerification({required String email}){
    emailVerification=email;
    emit(OnChangeEmailVerification());
  }

  ///get country id from list of country exists in list of country
  getCountryNumber({
    required BuildContext context,
})async{
    for(int i=0;i<allCountries.length;i++){
      if(HomeCubit.get(context).localCountry!.countryCode.contains(allCountries[i].iso2!)){
        countryId=allCountries[i].id;
        stateCountryModel=null;
      }
    }
    allStates=[];
    emit(OnChangeCountryId());
  }

  bool openedDownListCountry=false;

  ///on open drop down list of Country in sign up
  onOpenedDropDownListCountry({
    required bool opened,
  }){
    openedDownListCountry=opened;
    emit(OnOpenedDropDownListCountry());
  }


  ///on open drop down list of states in sign up
  onOpenedDropDownListState({
    required bool opened,
  }){
    openedDownListState=opened;
    emit(OnOpenedDropDownListState());
  }


  ///change state of country check box
  ///return true if index is true
  onChangeStateOFCountryState({required int index})async{
    for(int i=0;i<allStates.length;i++){
      if(i==index){
        allStates[i].check=true;
        stateCountryModel=allStates[i];
      }
      else{
        allStates[i].check=false;
      }
    }
    emit(OnChangeStateOFCountryState());
  }


  ///get states
  Future getStatesOfCountries(int id) async {
    emit(OnLoadingGetStatesOfCountryModel());
    await DioHelper.getDataWithoutBearer(url: "$countryURL/$id").then((value) {
      allStates=[];
      value.data.forEach((element){
        allStates.add(StatesModel.fromjson(element));
      });
      print("success get state of country");
      emit(OnSuccessGetStatesOfCountryModel());
    }).catchError((onError) {
      print("error get state of country");
      emit(OnErrorGetStatesOfCountryModel());
    });
  }


  ///get countries
  Future getCountries() async {
    emit(OnLoadingGetCountryModel());
    await DioHelper.getDataWithoutBearer(url: countryURL).then((value) async{
      allCountries=[];
      value.data.forEach((element)
      {
        allCountries.add(Countries.fromjson(element));
      });
      print("success get country");
      emit(OnSuccessGetCountryModel());
    }).catchError((onError) {
      print("error get country");
      emit(OnErrorGetCountryModel());
    });
  }

  ///sign in with facebook
  Future<UserCredential?> signInWithFaceBook({
    required BuildContext context,
}) async{
    /// Trigger the sign-in flow
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login();

      /// Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      /// Once signed in, return the UserCredential
      return await auth.signInWithCredential(facebookAuthCredential).then((globalValue) async{
        List<String> name=[];
        name = globalValue.user!.displayName.toString().split(" ").toList();
        await checkIfEmailExistsInFirebase(userEmail: globalValue.user!.email.toString()).then((value)async{
          if(value){
            print("registered");
            await signInWithPass(context: context, email:globalValue.user!.email.toString() , pass:"000001").then((value){
              navigateAndFinish(context, HomeScreen());
            });
          }
          else{
            print("not registered");
            UserAccountRegisterPage user = UserAccountRegisterPage(
              firstName: name.isNotEmpty ? name[0] : "",
              // middleName: name.length >= 2 ? name[1] : "",
              lastName: name.length >= 2 ? name[1] : "",
              email: globalValue.user!.email.toString(),
              password: "000001",
              birthDate: "2000-01-01",
              address: "required",
              country: "65",
              state: "3223",
              fullName: globalValue.user!.displayName.toString(),
              gender: "male",
              phoneNumber: globalValue.user!.phoneNumber ?? "1",
              language: "ar",
            );
            await registerAccount(context: context,model: user,signFromSocial: true).then((value)async{
              await signInWithPass(context: context, email:globalValue.user!.email.toString() , pass:"000001").then((value){
              //   // navigateAndFinish(context, HomeScreen());
              });
            });
          }
        });


      }).catchError((onError){
        print("failed to sign in with facebook$onError");
      });


    }catch(e){
      print("failed to sign in with facebook$e");
    }

  }

  ///check if email exists in firebase
  Future<bool> checkIfEmailExistsInFirebase({
    required String userEmail,
    })async{
    bool userSignInMethods = await auth.isSignInWithEmailLink(userEmail);
    return userSignInMethods;
  }

  ///sign in with google
  Future<UserCredential?> signInWithGoogle({
    required BuildContext context,
})async{
    try{
      showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
      final GoogleSignIn googleSignIn = await GoogleSignIn(
          scopes: [
        'https://www.googleapis.com/auth/drive',
      ]);
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      print("a");

      final GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount!.authentication;

      print("b");


      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );

      print("c");

      await auth
          .signInWithCredential(credential)
          .then((globalValue) async {

        List<String>? name;
        name = globalValue.user!.displayName.toString().split(" ").toList();
        await checkIfEmailExistsInFirebase(
                userEmail: globalValue.user!.email.toString())
            .then((value) async {
          if (value) {
            print("registered");
            await signInWithPass(
                    context: context,
                    email: globalValue.user!.email.toString(),
                    pass: "000001")
                .then((value) {
              navigateAndFinish(context, HomeScreen());
            });
          } else {
            print("un registered");
            UserAccountRegisterPage user = UserAccountRegisterPage(
              firstName: name!.isNotEmpty ? name[0] : "",
              // middleName: name.length >= 2 ? name[1] : "",
              lastName: name.length >= 2 ? name[1] : "",
              email: globalValue.user!.email.toString(),
              password: "000001",
              birthDate: "2000-01-01",
              address: "required",
              country: "65",
              state: "3223",
              fullName: globalValue.user!.displayName.toString(),
              gender: "male",
              phoneNumber: globalValue.user!.phoneNumber ?? "1",
              language: "ar",
            );
            await registerAccount(context: context, model: user,signFromSocial: true)
                .then((value) async {
              await signInWithPass(context: context, email: globalValue.user!.email.toString(), pass: "000001");
            });
          }
        });

        return globalValue;
      });
    }catch(err){
      print(err);
      Navigator.pop(context);
      showDialog(context: context, builder: (context) => defaultDialog(context: context,text:S.current.errorTextOnSignInWithSocialMedia));
      print("failed to sign in with google");
    }
  }

  ///sign out from firebase
  signOutWithFirebase()async{
    await auth.signOut();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
  }


  ///on change sms code
  ///sent to user after verify email
  onChangeSmsCode({
  required String code
  }){
    smsCode=code;
    emit(OnChangeSmsCodeState());
}

  ///register with apis
  RegisterModel? registerDataModel;
  Future registerAccount({
    required BuildContext context,
    required UserAccountRegisterPage model,
    bool? signFromSocial=false,
  })async {
    emit(OnLoadingRegisterStates());
    await DioHelper.postDataWithoutBearer(url:registerURL,data: model.toMap()).then((value) async{
      registerDataModel=RegisterModel.fromjson(value.data);
      if(value.statusCode ==200){
        if(signFromSocial!){
         await signInWithPass(context: context, email: model.email.toString(), pass: "000001");
        }else{
          Navigator.pop(context);
        }
        print("success registered");
        emit(OnSuccessRegisterStates(value));
      }else if(value.statusCode ==422){
        if(signFromSocial!=null && signFromSocial){

        }else{
          Navigator.pop(context);
          showDialog(context: context,builder:(context) => defaultDialog(context: context, text:S.current.dataOfRegisterInvalid),);
        }
        print("error registered with 422");
      }
      // emit(OnSuccessRegisterStates(value));
    }).catchError((error){
      if(signFromSocial!){

      }else{
        Navigator.pop(context);
      }
      print("error registered");
      emit(OnErrorRegisterStates());
    });
  }

  ///forget password with verification email and send token to user
  Future forgetPasswordWithEmail({
    required BuildContext context,
    required String email,
    required bool forgetPass,
  }) async {
    emit(OnLoadingForgotPasswordStates());
    await DioHelper.postDataWithoutBearer(url:forgetPasswordURL,data: {
      "email":email.toString(),
    }).then((value) {
      if(value.statusCode ==200){
          navigateAndReplace(context: context,widget: VerificationScreen(forgetPassword: forgetPass,emailVerification: email,));
          print("success forget password");
      }else if(value.statusCode ==422){
        print("error forget password with 422");
        Navigator.pop(context);
        showDialog(context: context, builder:(context) =>defaultDialog(context: context, text: value.data['message'].toString()));

      }
      emit(OnSuccessForgotPasswordStates());
    }).catchError((error){
      Navigator.pop(context);
      print("error forget password");
      emit(OnErrorForgotPasswordStates());
    });
  }

  ///forget password with verification phone number and send token to user
  Future forgetPasswordWithPhoneNumber({
    required BuildContext context,
    required String phone,
    required bool forgetPass,
  }) async {
    emit(OnLoadingForgotPasswordStates());
    await DioHelper.postDataWithPhoneNumber(
      url: "OTP/",
        query: {
          "environment":environmentOfAccountSMS,
          "username":userNameOfAccountSMS,
          "password":passwordOfAccountSMS,
          "sender":senderOfAccountSMS,
          "mobile":phone,
          "template":templateOfAccountSMS,
          "otp":otpOfAccountSMS
        })
        .then((value) {
          if(value.statusCode ==200){
            print(value.data);
            if(int.parse(value.data["Code"])==4901){
              navigateAndPush(context,VerificationScreen(forgetPassword:forgetPass,phone:phone,));
              print("success forget password with phone");
            }else if(int.parse(value.data["Code"])==4905){
              print("a");
              showDialog(context: context, builder: (context) => defaultDialog(context: context, text: S.of(context).phoneInvalid));

            }else{
              print("b");
              showDialog(context: context, builder:(context) =>defaultDialog(context: context, text: S.of(context).errorWithServer));

            }
          }
          emit(OnSuccessForgotPasswordStates());
        }).catchError((error){
              print("error forget password with phone number");
              emit(OnErrorForgotPasswordStates());
        });
  }

  ///verify token sent to user
  Future verifyPassword({
    required BuildContext context,
    required String email,
    required String token,
    required bool forgetPass,
  }) async {
    emit(OnLoadingVerifyForgotPasswordStates());
    await DioHelper.postDataWithoutBearer(url:verifyForgetPasswordURL,data: {
      "email":email.toString(),
      "token":token,
    }).then((value) {
      if(value.statusCode ==200){
        // showDialog(context: context, builder: (context) =>
        // defaultDialog(context: context, text: value.data['status'].toString()));
        print("success verify password");
        if(forgetPass==true){
          navigateAndPush(context,NewPasswordScreen(email: emailVerification!,token:token,));
        }else{
          if(registerDataModel!.status==successState){
            showDialog(
              context: context,
              builder: (context) => dialog(
                  image:languageApp!="ar"? dialogImageOfRegisterConfirmationEN:dialogImageOfRegisterConfirmationAR,
                  context: context,
                  heightContainer: MediaQuery.sizeOf(context).height * 0.6144,
                  child: verificationCodeDialog(context: context)
              ),
            );
          }
        }
      }
      else if(value.statusCode ==422){
        print("error verify password with 422");
        showDialog(context: context, builder: (context) =>
        defaultDialog(context: context, text: value.data['status'].toString(),));
      }
      emit(OnSuccessVerifyForgotPasswordStates());
    }).catchError((error){
      print("error verify password");
      showDialog(context: context, builder: (context) =>
          defaultDialog(context: context, text: S.of(context).checkValidationOfTokenText));
      emit(OnErrorVerifyForgotPasswordStates());
    });
  }

  ///change new password without old password
  Future changePasswordWithForget({
    required BuildContext context,
    required String email,
    required String token,
    required String pass,
  }) async {
    emit(OnLoadingForgotChangePasswordStates());
    await DioHelper.postDataWithoutBearer(url:forgetChangePasswordURL,data: {
      "email":email.toString(),
      "token":token,
      "password":pass,
    }).then((value) {
      if(value.statusCode ==200){
        showDialog(context: context, builder: (context) => dialog(
          image:languageApp!="ar"? dialogImageOfForgetPasswordConfirmationEN:dialogImageOfForgetPasswordConfirmationAR,
          context: context,
          heightContainer:MediaQuery.sizeOf(context).height * 0.6144,
          child: confirmNewPasswordDialog(context: context),
        ),);
        print("success change password with forget");
      }else if(value.statusCode ==422){
        Navigator.pop(context);
        showDialog(context: context, builder: (context) =>
        defaultDialog(context: context, text: value.data['message'].toString()));
        print("error change password with forget with 422");
      }
      emit(OnSuccessForgotChangePasswordStates());
    }).catchError((error){
      Navigator.pop(context);
      print("error change password with forget");
      emit(OnErrorForgotChangePasswordStates());
    });
  }


  ///pick image from gallery
  File? pathImage;
  Future pickImage() async{
    var imagePicker=ImagePicker();
   final image =await imagePicker.pickImage(source: ImageSource.gallery,);
   if(image !=null){
      pathImage=File(image.path);
      emit(OnSuccessPickedImage());
   }
   else{
     // toast(message: "no Cover image selected", status: ToastStatus.success);
     emit(OnErrorPickedImage());
   }
  }

  ///sign in with apis
  LoginModel? loginDataModel;
  Future signInWithPass({
    required BuildContext context,
    required String email,
    required String pass,
    bool? fromVerificationAfterRegister=false,
  }) async {
    emit(OnLoadingSignInStates());
    await DioHelper.postDataWithoutBearer(url:loginURL,data: {
      'email':email,
      "password":pass,
    }).then((value) async{
      loginDataModel=LoginModel.fromjson(value.data);
      if(value.statusCode == 200){
        userModel=loginDataModel!.userAccount;
        userTokenApi=loginDataModel!.authorisation!.token!;
        await CashHelper.setString(key: USER_TOKEN_API,value: userTokenApi!);
        HomeCubit.get(context).getLocalCountry(context: context);
        print("success sign in with pass");
        await HomeCubit.get(context).getClinicsData();
        if(!fromVerificationAfterRegister!){
          await showDialog(context: context, builder: (context) =>
              DefaultSplashDialog(
                text:S.of(context).loggedInSuccessfullyFirst,text2:S.of(context).loggedInSuccessfullySecond ,
                nextWidget: () {
                  navigateAndFinish(context,HomeScreen());
                },
                haveCloseButton: false,
              ),);
        }else{
          navigateAndFinish(context, HomeScreen());
        }
      }else if(value.statusCode == 422){
        showDialog(context: context, builder: (context) =>
        defaultDialog(context: context, text: loginDataModel!.errors.first,
          nextWidget: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },));
        print("error sign in with pass with 422");
      }
      emit(OnSuccessSignInStates(value));
    }).catchError((error){
      print("error sign in with pass");
      // showDialog(context: context, builder: (context) =>
      // defaultDialog(context: context,text: loginDataModel!.errors.first,nextWidget: () {
      //   Navigator.pop(context);
      //   Navigator.pop(context);
      // },));
      Navigator.pop(context);
      emit(OnErrorSignInStates());
    });
  }

  ///refresh data of user
  Future refreshData({
    required BuildContext context,
  }) async {
    emit(OnLoadingRefreshUserData());
    await DioHelper.postDataWithBearer(url:refreshURL).then((value) async{
      if(value.statusCode == 200){
        loginDataModel=LoginModel.fromjson(value.data);
        userModel=loginDataModel!.userAccount;
        await CashHelper.setString(key: USER_TOKEN_API, value: loginDataModel!.authorisation!.token!);
        userTokenApi=await CashHelper.getData(key: USER_TOKEN_API);
        HomeCubit.get(context).getLocalCountry(context: context);
      }
      else if(value.statusCode == 422){
        print("error on refresh with 422");
      }
      await HomeCubit.get(context).getClinicsData();
      emit(OnSuccessRefreshUserData());
      print("success on refresh");
    }).catchError((error){
      print("error on refresh");
      emit(OnErrorRefreshUserData());
    });
  }

  ///change data of user login
  onChangeUserDataOfLogIn({LoginModel? object}){
    loginDataModel=object;
    emit(OnChangeUserDataRegisterState());
  }


  ///on change data of user
  UserAccountLoginPage? userModel;
  onChangeUserData({required UserAccountLoginPage object}){
    userModel=object;
    emit(OnChangeUserDataLoginState());
  }

  onChangeRegisterDataModel({required UserAccountRegisterPage object}){
    registerModel=object;
    emit(OnChangeUserDataRegisterState());
  }

  ///update profile data with apis
  Future updateData({
    required BuildContext context,
    Map<String,dynamic>? data,
  }) async {
    emit(OnLoadingUpdateUserDataModel());
    await DioHelper.postDataWithBearer(url:updateURL,data:data).then((value) async{
      if(value.statusCode == 200){
        loginDataModel!.userAccount=UserAccountLoginPage.fromjson(value.data);
          await CashHelper.setString(
              key: Lang_Key, value: loginDataModel!.userAccount!.language!
          );
        await CashHelper.setString(
            key: COUNTRY_KEY,value: loginDataModel!.userAccount!.country!
        );
        print("success on update data");
      }
      else if(value.statusCode == 422){
        print("error on update data with 422");
        showDialog(context: context, builder: (context) =>
        defaultDialog(context: context, text: S.of(context).unAuthenticatedText));
      }
      emit(OnSuccessUpdateUserDataModel());
    }).catchError((error){
      print("error on update data");
      emit(OnErrorUpdateUserDataModel());
    });
  }

  ///update image profile with form data (apis)
  Future updateImageProfile({
    required BuildContext context,
    dynamic formData,
  }) async {
    emit(OnLoadingUpdateUserDataModel());
    await DioHelper.postDataWithBearerWithImg(url:updateURL,formData:formData,).then((value) async{
      if(value.statusCode == 200){
        loginDataModel!.userAccount=UserAccountLoginPage.fromjson(value.data);
        print("success update image profile");
        pathImage=null;
      }
      else if(value.statusCode == 422){
        print("error update image profile with 422");
      }
      emit(OnSuccessUpdateUserDataModel());
    }).catchError((error){
      print("error update image profile");
      emit(OnErrorUpdateUserDataModel());
    });
  }


  ///change password from my profile screen
  Future changePassword({
    required BuildContext context,
    required String oldPass,
    required String pass,
    required String passConfirmation,
  })async {
    emit(OnLoadingChangePassword());
    await DioHelper.postDataWithBearer(url:changePasswordURL,data:{
      "old_password":oldPass,
      "password":pass,
      "password_confirmation":passConfirmation
    }).then((value) {
      if(value.statusCode == 200){
        loginDataModel!.userAccount=UserAccountLoginPage.fromjson(value.data);
        userTokenApi=loginDataModel!.authorisation!.token!;
        print("success change password");
      }
      emit(OnSuccessChangePassword());
    }).catchError((error){
      print("error change password");
      emit(OnErrorChangePassword());
    });
  }
}

enum Gender{
  male,
  female
}