import 'dart:ui';

const Color defaultGreyColor=Color(0xff424242);
const Color defaultBinkColor=Color(0xffFE2892);
const Color defaultBlueAccentColor=Color(0xff1BDFFE);
const Color defaultBlueDarkColor=Color(0xff43A6B5);
const Color defaultWhiteColor=Color(0xffFFFFFF);
const Color defaultBlackColor=Color(0xff000000);
const double radiusItemImage=5;
const String splashKey="Splash";
bool isSplashedValue=false;
String? userTokenApi=null;
const String USER_TOKEN_API="USER_TOKEN";
const String Email_USER="Email_USER";
const String PASS_USER="PASS_USER";
const String Collection="users";
String globalTokenApi="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2OTkwODU1NDQsImV4cCI6MTczMDYyMTU0NCwibmJmIjoxNjk5MDg1NTQ0LCJqdGkiOiIzakVQRzdydmJ3S2FqVU5LIiwic3ViIjoiOCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mhb4NNvN5fWXWbZw9tjL_oJFjVZ3R4gBgZmlKPEojqA";
const String TOKEN_API="TOKEN";
const String TOKEN_FIRE_BASE="TOKEN_FIREBASE";
const String Lang_Key="LANGUAGE";
const String COUNTRY_KEY="COUNTRY";
String? languageApp="ar";
String countryApp="65";
const String errorState='error';
const String successState='success';
const String COUNTRY_Of_Phone="COUNTRY_With_PHONE";
String countryPhoneNumber="";



///support information
const String phoneNumberSupport="tel:+1-555-010-999";
const String whatsAppNumberSupport="https://api.whatsapp.com/send?phone=201150407920";



///social medial URL
const String facebookURL="https://megavisionagency.com/";
const String linkedInURL="https://megavisionagency.com/";
const String instagramURL="https://megavisionagency.com/";
const String privacyPolicyURL="https://megavisionagency.com/";
const String termsOfUseURL="https://megavisionagency.com/";

///images for Gene

///first splash screen
const String imageFirstSplashScreenAR="assets/Background/image.gif";
const String imageFirstSplashScreenEN="assets/Background/image.gif";
///splash screen images
const String firstImageSplashScreenEN="assets/Background/splash.png";
const String firstImageSplashScreenAR="assets/Background/splash.png";
const String secondImageSplashScreenEN="assets/Background/splash.png";
const String secondImageSplashScreenAR="assets/Background/splash.png";
const String thirdImageSplashScreenEN="assets/Background/splash.png";
const String thirdImageSplashScreenAR="assets/Background/splash.png";
///welcome screen
const String imageWelcomePageScreenAR="assets/Background/splash.png";
const String imageWelcomePageScreenEN="assets/Background/splash.png";
///sign in  screen
const String imageSignInScreenAR="assets/Background/splash.png";
const String imageSignInScreenEN="assets/Background/splash.png";
///forget password screen
const String imageForgetPasswordScreenAR="assets/Background/splash.png";
const String imageForgetPasswordScreenEN="assets/Background/splash.png";
///verification screen
const String imageVerificationScreenAR="assets/Background/splash.png";
const String imageVerificationScreenEN="assets/Background/splash.png";
///new password screen
const String imageNewPasswordScreenAR="assets/Background/splash.png";
const String imageNewPasswordScreenEN="assets/Background/splash.png";
///change password screen
const String imageChangePasswordScreenAR="assets/Background/splash.png";
const String imageChangePasswordScreenEN="assets/Background/splash.png";
///Home screen
///Logo Image
const String logoImageAR="assets/Background/gene test 2.png";
const String logoImageEN="assets/Background/gene test 2.png";

///images of dialogs
///register screen
const String dialogImageOfRegisterConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfRegisterConfirmationEN="assets/Background/logosignin2.png";
///forget password screen
const String dialogImageOfForgetPasswordConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfForgetPasswordConfirmationEN="assets/Background/logosignin2.png";
///cancel booking screen
const String dialogImageOfCancelBookingConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfCancelBookingConfirmationEN="assets/Background/logosignin2.png";
///change password screen
const String dialogImageOfChangePasswordConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfChangePasswordConfirmationEN="assets/Background/logosignin2.png";
///edit booking dialog
const String dialogImageOfEditBookingConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfEditBookingConfirmationEN="assets/Background/logosignin2.png";
///booking now dialog
const String dialogImageOfBookingNowConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfBookingNowConfirmationEN="assets/Background/logosignin2.png";
///payment dialog
const String dialogImageOfPaymentStateConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfPaymentStateConfirmationEN="assets/Background/logosignin2.png";
///pay now dialog
const String dialogImageOfPayNowConfirmationAR="assets/Background/logosignin2.png";
const String dialogImageOfPayNowConfirmationEN="assets/Background/logosignin2.png";
///payment success state image
const String imageOfSuccessPaymentStateAR="assets/Background/default_dialog_image.png";
const String imageOfSuccessPaymentStateEN="assets/Background/default_dialog_image.png";
///payment Error state image
const String imageOfErrorPaymentStateAR="assets/Background/default_dialog_image.png";
const String imageOfErrorPaymentStateEN="assets/Background/gene test 2.png";


///SMS Misr
const String userNameOfAccountSMS="79ca52e2-4c68-4866-a292-79d4f8a9a299";
const String passwordOfAccountSMS="029a18cadb557c757efcd1c18e396139a3449051994734dc9299b34b58ece05f";
const String templateOfAccountSMS="0f9217c9d760c1c0ed47b8afb5425708da7d98729016a8accfc14f9cc8d1ba83";
const String otpOfAccountSMS="XXXXXX";
const String senderOfAccountSMS="b611afb996655a94c8e942a823f1421de42bf8335d24ba1f84c437b2ab11ca27";
const String environmentOfAccountSMS="2";
