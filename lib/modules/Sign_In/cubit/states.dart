import 'package:dio/dio.dart';

abstract class SignInState{}

class SignInInitState extends SignInState{}

class OnChangePasswordVisibilityState extends SignInState{}
class OnChangeUserDataRegisterState extends SignInState{}
class OnChangeUserDataLoginState extends SignInState{}
class OnChangeSmsCodeState extends SignInState{}
class OnChangeEmailVerification extends SignInState{}
class OnChangeGenderState extends SignInState{}
class OnOpenedDropDownListState extends SignInState{}
class OnOpenedDropDownListCountry extends SignInState{}
class OnChangeStateOFCountryState extends SignInState{}
class OnChangeCountryId extends SignInState{}
class OnChangeCountryState extends SignInState{}
class OnInitialVerificationScreen extends SignInState{}

class OnLoadingRegisterStates extends SignInState{}
class OnSuccessRegisterStates extends SignInState{
  Response<dynamic>? value;
  OnSuccessRegisterStates(Response<dynamic> this.value);
}
class OnErrorRegisterStates extends SignInState{}

class OnLoadingRegisterFirebaseStates extends SignInState{}
class OnSuccessRegisterFirebaseStates extends SignInState{}
class OnErrorRegisterFirebaseStates extends SignInState{}

class OnSuccessSignInFirebaseStates extends SignInState{}
class OnErrorSignInFirebaseStates extends SignInState{}

class OnLoadingForgotPasswordStates extends SignInState{}
class OnSuccessForgotPasswordStates extends SignInState{}
class OnErrorForgotPasswordStates extends SignInState{}

class OnLoadingForgotChangePasswordStates extends SignInState{}
class OnSuccessForgotChangePasswordStates extends SignInState{}
class OnErrorForgotChangePasswordStates extends SignInState{}

class OnLoadingVerifyForgotPasswordStates extends SignInState{}
class OnSuccessVerifyForgotPasswordStates extends SignInState{}
class OnErrorVerifyForgotPasswordStates extends SignInState{}

class OnLoadingSignInStates extends SignInState{}
class OnSuccessSignInStates extends SignInState{
  Response<dynamic>? value;
  OnSuccessSignInStates(Response<dynamic> this.value);
}
class OnErrorSignInStates extends SignInState{}

class OnLoadingGetStatesOfCountryModel extends SignInState{}
class OnSuccessGetStatesOfCountryModel extends SignInState{}
class OnErrorGetStatesOfCountryModel extends SignInState{}

class OnLoadingGetCountryModel extends SignInState{}
class OnSuccessGetCountryModel extends SignInState{}
class OnErrorGetCountryModel extends SignInState{}

class OnLoadingUpdateUserDataModel extends SignInState{}
class OnSuccessUpdateUserDataModel extends SignInState{}
class OnErrorUpdateUserDataModel extends SignInState{}

class OnLoadingChangePassword extends SignInState{}
class OnSuccessChangePassword extends SignInState{}
class OnErrorChangePassword extends SignInState{}

class OnLoadingRefreshUserData extends SignInState{}
class OnSuccessRefreshUserData extends SignInState{}
class OnErrorRefreshUserData extends SignInState{}

class OnSuccessPickedImage extends SignInState{}
class OnErrorPickedImage   extends SignInState{}

class OnLoadingUploadImageToFirebaseStorage extends SignInState{}
class OnSuccessUploadImageToFirebaseStorage extends SignInState{}
class OnErrorUploadImageToFirebaseStorage extends SignInState{}


