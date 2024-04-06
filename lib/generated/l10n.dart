// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Your Health Matters`
  String get splashText {
    return Intl.message(
      'Your Health Matters',
      name: 'splashText',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skipButton {
    return Intl.message(
      'Skip',
      name: 'skipButton',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To Gene`
  String get welcomeText {
    return Intl.message(
      'Welcome To Gene',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Continue With Facebook`
  String get facebookButton {
    return Intl.message(
      'Continue With Facebook',
      name: 'facebookButton',
      desc: '',
      args: [],
    );
  }

  /// `Continue With Google`
  String get googleButton {
    return Intl.message(
      'Continue With Google',
      name: 'googleButton',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebookTextButton {
    return Intl.message(
      'Facebook',
      name: 'facebookTextButton',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get googleTextButton {
    return Intl.message(
      'Google',
      name: 'googleTextButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with password`
  String get signInWithPassButton {
    return Intl.message(
      'Sign in with password',
      name: 'signInWithPassButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account?`
  String get askUserTextToSignUp {
    return Intl.message(
      'Don\'t have account?',
      name: 'askUserTextToSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUpButton {
    return Intl.message(
      'Sign up',
      name: 'signUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInButton {
    return Intl.message(
      'Sign in',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or_text_devider {
    return Intl.message(
      'OR',
      name: 'or_text_devider',
      desc: '',
      args: [],
    );
  }

  /// `You Have Been Logged In Successfully`
  String get loggedInSuccessfullyFirst {
    return Intl.message(
      'You Have Been Logged In Successfully',
      name: 'loggedInSuccessfullyFirst',
      desc: '',
      args: [],
    );
  }

  /// `Redirecting To GENE Home Page ...`
  String get loggedInSuccessfullySecond {
    return Intl.message(
      'Redirecting To GENE Home Page ...',
      name: 'loggedInSuccessfullySecond',
      desc: '',
      args: [],
    );
  }

  /// `You Have Been Signed Out Successfully`
  String get signedOutSuccessfullyFirst {
    return Intl.message(
      'You Have Been Signed Out Successfully',
      name: 'signedOutSuccessfullyFirst',
      desc: '',
      args: [],
    );
  }

  /// `Redirecting To GENE Home Page ...`
  String get signedOutSuccessfullySecond {
    return Intl.message(
      'Redirecting To GENE Home Page ...',
      name: 'signedOutSuccessfullySecond',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get or_continue_text_devider {
    return Intl.message(
      'Or continue with',
      name: 'or_continue_text_devider',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get messageText {
    return Intl.message(
      'Message',
      name: 'messageText',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameText {
    return Intl.message(
      'Name',
      name: 'nameText',
      desc: '',
      args: [],
    );
  }

  /// `name context can not be empty`
  String get nameEmptyValidator {
    return Intl.message(
      'name context can not be empty',
      name: 'nameEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneText {
    return Intl.message(
      'Phone',
      name: 'phoneText',
      desc: '',
      args: [],
    );
  }

  /// `phone context can not be empty`
  String get phoneEmptyValidator {
    return Intl.message(
      'phone context can not be empty',
      name: 'phoneEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get ageText {
    return Intl.message(
      'Age',
      name: 'ageText',
      desc: '',
      args: [],
    );
  }

  /// `Date context can not be empty`
  String get dateEmptyValidator {
    return Intl.message(
      'Date context can not be empty',
      name: 'dateEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genderText {
    return Intl.message(
      'Gender',
      name: 'genderText',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get maleText {
    return Intl.message(
      'Male',
      name: 'maleText',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get femaleText {
    return Intl.message(
      'Female',
      name: 'femaleText',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailText {
    return Intl.message(
      'Email',
      name: 'emailText',
      desc: '',
      args: [],
    );
  }

  /// `email context can not be empty`
  String get emailEmptyValidator {
    return Intl.message(
      'email context can not be empty',
      name: 'emailEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `email format is not valid`
  String get emailFormatValidator {
    return Intl.message(
      'email format is not valid',
      name: 'emailFormatValidator',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordText {
    return Intl.message(
      'Password',
      name: 'passwordText',
      desc: '',
      args: [],
    );
  }

  /// `password context can not be empty`
  String get passwordEmptyValidator {
    return Intl.message(
      'password context can not be empty',
      name: 'passwordEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordText {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPasswordText {
    return Intl.message(
      'Current password',
      name: 'currentPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPasswordText {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `confirm password context can not be empty`
  String get confirmPasswordEmptyValidator {
    return Intl.message(
      'confirm password context can not be empty',
      name: 'confirmPasswordEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `new password context can not be empty`
  String get newPasswordEmptyValidator {
    return Intl.message(
      'new password context can not be empty',
      name: 'newPasswordEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `current password context can not be empty`
  String get currentPasswordEmptyValidator {
    return Intl.message(
      'current password context can not be empty',
      name: 'currentPasswordEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `confirm new password context can not be empty`
  String get confirmNewPasswordEmptyValidator {
    return Intl.message(
      'confirm new password context can not be empty',
      name: 'confirmNewPasswordEmptyValidator',
      desc: '',
      args: [],
    );
  }

  /// `Forgot the password?`
  String get askForgetPasswordText {
    return Intl.message(
      'Forgot the password?',
      name: 'askForgetPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgetPasswordText {
    return Intl.message(
      'Forgot password',
      name: 'forgetPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get sendText {
    return Intl.message(
      'Send',
      name: 'sendText',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Password successfully \n changed`
  String get successPassChangedText {
    return Intl.message(
      'Password successfully \n changed',
      name: 'successPassChangedText',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been created\nnsuccessfully`
  String get successAccountCreatedText {
    return Intl.message(
      'Your account has been created\nnsuccessfully',
      name: 'successAccountCreatedText',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginText {
    return Intl.message(
      'Login',
      name: 'loginText',
      desc: '',
      args: [],
    );
  }

  /// `Back to profile`
  String get backToProfileText {
    return Intl.message(
      'Back to profile',
      name: 'backToProfileText',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get titleSignUpPage {
    return Intl.message(
      'Create your account',
      name: 'titleSignUpPage',
      desc: '',
      args: [],
    );
  }

  /// `Send verification code`
  String get titleVerificationPage {
    return Intl.message(
      'Send verification code',
      name: 'titleVerificationPage',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has been\nnsent to your phone number,\nnplease check the message.`
  String get verificationText {
    return Intl.message(
      'Verification code has been\nnsent to your phone number,\nnplease check the message.',
      name: 'verificationText',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePasswordText {
    return Intl.message(
      'Change password',
      name: 'changePasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChangesText {
    return Intl.message(
      'Save changes',
      name: 'saveChangesText',
      desc: '',
      args: [],
    );
  }

  /// `My Medical Profile`
  String get medicalPatientFileText {
    return Intl.message(
      'My Medical Profile',
      name: 'medicalPatientFileText',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get titleSupportPage {
    return Intl.message(
      'Support',
      name: 'titleSupportPage',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get titleNotificationPage {
    return Intl.message(
      'Notifications',
      name: 'titleNotificationPage',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get titleFavouritesPage {
    return Intl.message(
      'Favorites',
      name: 'titleFavouritesPage',
      desc: '',
      args: [],
    );
  }

  /// `My bookings`
  String get titleMyBookingPage {
    return Intl.message(
      'My bookings',
      name: 'titleMyBookingPage',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get titleCheckoutPage {
    return Intl.message(
      'Checkout',
      name: 'titleCheckoutPage',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get titleMyProfilePage {
    return Intl.message(
      'My profile',
      name: 'titleMyProfilePage',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get titleNewPassPage {
    return Intl.message(
      'New password',
      name: 'titleNewPassPage',
      desc: '',
      args: [],
    );
  }

  /// `Create a new password`
  String get titleCreateNewPassPage {
    return Intl.message(
      'Create a new password',
      name: 'titleCreateNewPassPage',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To Gene Clinics`
  String get titleHomePage {
    return Intl.message(
      'Welcome To Gene Clinics',
      name: 'titleHomePage',
      desc: '',
      args: [],
    );
  }

  /// `Gene Doctors`
  String get titleDoctorPage {
    return Intl.message(
      'Gene Doctors',
      name: 'titleDoctorPage',
      desc: '',
      args: [],
    );
  }

  /// `Gene Clinics`
  String get titleClinicsPage {
    return Intl.message(
      'Gene Clinics',
      name: 'titleClinicsPage',
      desc: '',
      args: [],
    );
  }

  /// `Medical Services`
  String get titleMedicalServicesPage {
    return Intl.message(
      'Medical Services',
      name: 'titleMedicalServicesPage',
      desc: '',
      args: [],
    );
  }

  /// `My Settings`
  String get titleSettingPage {
    return Intl.message(
      'My Settings',
      name: 'titleSettingPage',
      desc: '',
      args: [],
    );
  }

  /// `Sup Clinics`
  String get titleSupClinicsPage {
    return Intl.message(
      'Sup Clinics',
      name: 'titleSupClinicsPage',
      desc: '',
      args: [],
    );
  }

  /// `Search for a doctor`
  String get hintSearchTextFieldHomePage {
    return Intl.message(
      'Search for a doctor',
      name: 'hintSearchTextFieldHomePage',
      desc: '',
      args: [],
    );
  }

  /// `Good morning`
  String get goodMorningHomePage {
    return Intl.message(
      'Good morning',
      name: 'goodMorningHomePage',
      desc: '',
      args: [],
    );
  }

  /// `{name}`
  String nameOfClient(Object name) {
    return Intl.message(
      '$name',
      name: 'nameOfClient',
      desc: '',
      args: [name],
    );
  }

  /// `label`
  String get labelNavBar {
    return Intl.message(
      'label',
      name: 'labelNavBar',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTitleNavBar {
    return Intl.message(
      'Home',
      name: 'homeTitleNavBar',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get bookTitleNavBar {
    return Intl.message(
      'Book Now',
      name: 'bookTitleNavBar',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get walletTitleNavBar {
    return Intl.message(
      'My Wallet',
      name: 'walletTitleNavBar',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get accountTitleNavBar {
    return Intl.message(
      'My Account',
      name: 'accountTitleNavBar',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get moreToNavigate {
    return Intl.message(
      'More',
      name: 'moreToNavigate',
      desc: '',
      args: [],
    );
  }

  /// `Language and Country`
  String get languageAndCountry {
    return Intl.message(
      'Language and Country',
      name: 'languageAndCountry',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `My Language`
  String get languageTitle {
    return Intl.message(
      'My Language',
      name: 'languageTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Country`
  String get countryTitle {
    return Intl.message(
      'My Country',
      name: 'countryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message(
      'Profile',
      name: 'profileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInTitle {
    return Intl.message(
      'Sign In',
      name: 'signInTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOutTitle {
    return Intl.message(
      'Sign out',
      name: 'signOutTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Information`
  String get patientInformationTitle {
    return Intl.message(
      'My Information',
      name: 'patientInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit My Information`
  String get editPatientInformationTitle {
    return Intl.message(
      'Edit My Information',
      name: 'editPatientInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerTitle {
    return Intl.message(
      'Register',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open Ticket`
  String get openTicketTitle {
    return Intl.message(
      'Open Ticket',
      name: 'openTicketTitle',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get callingTitle {
    return Intl.message(
      'Help',
      name: 'callingTitle',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get generalInformationText {
    return Intl.message(
      'General information',
      name: 'generalInformationText',
      desc: '',
      args: [],
    );
  }

  /// `Doctor name`
  String get doctorNameText {
    return Intl.message(
      'Doctor name',
      name: 'doctorNameText',
      desc: '',
      args: [],
    );
  }

  /// `Specialization`
  String get specializationText {
    return Intl.message(
      'Specialization',
      name: 'specializationText',
      desc: '',
      args: [],
    );
  }

  /// `Years of experience`
  String get experienceText {
    return Intl.message(
      'Years of experience',
      name: 'experienceText',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get bookingText {
    return Intl.message(
      'Bookings',
      name: 'bookingText',
      desc: '',
      args: [],
    );
  }

  /// `Choose day you wish to book`
  String get chooseDayOfBooking {
    return Intl.message(
      'Choose day you wish to book',
      name: 'chooseDayOfBooking',
      desc: '',
      args: [],
    );
  }

  /// `Book now`
  String get book_now_button_text {
    return Intl.message(
      'Book now',
      name: 'book_now_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure \n you want to confirm this date ?`
  String get confirm_date_of_booking_text {
    return Intl.message(
      'Are you sure \n you want to confirm this date ?',
      name: 'confirm_date_of_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes_button_text {
    return Intl.message(
      'Yes',
      name: 'yes_button_text',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no_button_text {
    return Intl.message(
      'No',
      name: 'no_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Choose payment method`
  String get choose_payment_text {
    return Intl.message(
      'Choose payment method',
      name: 'choose_payment_text',
      desc: '',
      args: [],
    );
  }

  /// `Credit card`
  String get credit_card_button_text {
    return Intl.message(
      'Credit card',
      name: 'credit_card_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash_button_text {
    return Intl.message(
      'Cash',
      name: 'cash_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get cardNumberText {
    return Intl.message(
      'Card number',
      name: 'cardNumberText',
      desc: '',
      args: [],
    );
  }

  /// `Holder name`
  String get holderNameText {
    return Intl.message(
      'Holder name',
      name: 'holderNameText',
      desc: '',
      args: [],
    );
  }

  /// `Expiry date`
  String get expiryDateText {
    return Intl.message(
      'Expiry date',
      name: 'expiryDateText',
      desc: '',
      args: [],
    );
  }

  /// `CVC`
  String get cvcText {
    return Intl.message(
      'CVC',
      name: 'cvcText',
      desc: '',
      args: [],
    );
  }

  /// `Payment amount`
  String get payCostText {
    return Intl.message(
      'Payment amount',
      name: 'payCostText',
      desc: '',
      args: [],
    );
  }

  /// `Pay now`
  String get pay_now_button_text {
    return Intl.message(
      'Pay now',
      name: 'pay_now_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure\nyou want to confirm pay ?`
  String get confirm_pay_text {
    return Intl.message(
      'Are you sure\nyou want to confirm pay ?',
      name: 'confirm_pay_text',
      desc: '',
      args: [],
    );
  }

  /// `Please wait\nwhile your transaction\nhas been completed\n\nIt will take a moment\nPlease don't close this page`
  String get waiting_while_pay_complete_text {
    return Intl.message(
      'Please wait\nwhile your transaction\nhas been completed\n\nIt will take a moment\nPlease don\'t close this page',
      name: 'waiting_while_pay_complete_text',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get successStateText {
    return Intl.message(
      'Success',
      name: 'successStateText',
      desc: '',
      args: [],
    );
  }

  /// `Your transaction has been decline\nPlease check your card information\nor your balance`
  String get decline_transaction_text {
    return Intl.message(
      'Your transaction has been decline\nPlease check your card information\nor your balance',
      name: 'decline_transaction_text',
      desc: '',
      args: [],
    );
  }

  /// `Back to checkout`
  String get back_to_checkout_button_text {
    return Intl.message(
      'Back to checkout',
      name: 'back_to_checkout_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failStateText {
    return Intl.message(
      'Failed',
      name: 'failStateText',
      desc: '',
      args: [],
    );
  }

  /// `Date information`
  String get date_information_text {
    return Intl.message(
      'Date information',
      name: 'date_information_text',
      desc: '',
      args: [],
    );
  }

  /// `Book information`
  String get book_information_text {
    return Intl.message(
      'Book information',
      name: 'book_information_text',
      desc: '',
      args: [],
    );
  }

  /// `Clinic`
  String get clinic_booking_text {
    return Intl.message(
      'Clinic',
      name: 'clinic_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctor_booking_text {
    return Intl.message(
      'Doctor',
      name: 'doctor_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Day of book`
  String get day_booking_text {
    return Intl.message(
      'Day of book',
      name: 'day_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role_booking_text {
    return Intl.message(
      'Role',
      name: 'role_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time_booking_text {
    return Intl.message(
      'Time',
      name: 'time_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get pay_method_booking_text {
    return Intl.message(
      'Payment method',
      name: 'pay_method_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Edit book`
  String get edit_booking_button_text {
    return Intl.message(
      'Edit book',
      name: 'edit_booking_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Cancel book`
  String get cancel_booking_button_text {
    return Intl.message(
      'Cancel book',
      name: 'cancel_booking_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure\nyou want to cancel book ?`
  String get confirm_cancellation_booking_text {
    return Intl.message(
      'Are you sure\nyou want to cancel book ?',
      name: 'confirm_cancellation_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Current booking`
  String get current_booking_button_text {
    return Intl.message(
      'Current booking',
      name: 'current_booking_button_text',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history_booking_button_text {
    return Intl.message(
      'History',
      name: 'history_booking_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date_my_booking_text {
    return Intl.message(
      'Date',
      name: 'date_my_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment_my_booking_text {
    return Intl.message(
      'Payment',
      name: 'payment_my_booking_text',
      desc: '',
      args: [],
    );
  }

  /// `Update my booking`
  String get update_booking_button_text {
    return Intl.message(
      'Update my booking',
      name: 'update_booking_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Have you had Coronavirus vaccination?`
  String get askIfUserHaveCoronaVirusVaccine {
    return Intl.message(
      'Have you had Coronavirus vaccination?',
      name: 'askIfUserHaveCoronaVirusVaccine',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicyText {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicyText',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get termsOfUse {
    return Intl.message(
      'Terms of use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0`
  String get versionNumber {
    return Intl.message(
      'Version 1.0',
      name: 'versionNumber',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get englishLanguage {
    return Intl.message(
      'English',
      name: 'englishLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabicLanguage {
    return Intl.message(
      'Arabic',
      name: 'arabicLanguage',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get frenchLanguage {
    return Intl.message(
      'French',
      name: 'frenchLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Tickets`
  String get titleOfTicketsScreen {
    return Intl.message(
      'Tickets',
      name: 'titleOfTicketsScreen',
      desc: '',
      args: [],
    );
  }

  /// `Open Tickets`
  String get openTicketsButtonText {
    return Intl.message(
      'Open Tickets',
      name: 'openTicketsButtonText',
      desc: '',
      args: [],
    );
  }

  /// `My Tickets`
  String get myTicketsButtonText {
    return Intl.message(
      'My Tickets',
      name: 'myTicketsButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Comming Soon.....`
  String get contentOfWalletScreen {
    return Intl.message(
      'Comming Soon.....',
      name: 'contentOfWalletScreen',
      desc: '',
      args: [],
    );
  }

  /// `Title:`
  String get titleContainerMyTicketsScreen {
    return Intl.message(
      'Title:',
      name: 'titleContainerMyTicketsScreen',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get titleText {
    return Intl.message(
      'Title',
      name: 'titleText',
      desc: '',
      args: [],
    );
  }

  /// `Problems`
  String get problemText {
    return Intl.message(
      'Problems',
      name: 'problemText',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get selectProblemText {
    return Intl.message(
      'Select',
      name: 'selectProblemText',
      desc: '',
      args: [],
    );
  }

  /// `Please Input your Title....`
  String get hintTitleText {
    return Intl.message(
      'Please Input your Title....',
      name: 'hintTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Type:`
  String get supTitleContainerMyTicketsScreen {
    return Intl.message(
      'Type:',
      name: 'supTitleContainerMyTicketsScreen',
      desc: '',
      args: [],
    );
  }

  /// `Max 120 characters`
  String get hintMessageText {
    return Intl.message(
      'Max 120 characters',
      name: 'hintMessageText',
      desc: '',
      args: [],
    );
  }

  /// `title context can not be empty`
  String get validatorTitleText {
    return Intl.message(
      'title context can not be empty',
      name: 'validatorTitleText',
      desc: '',
      args: [],
    );
  }

  /// `email context can not be empty`
  String get validatorMessageText {
    return Intl.message(
      'email context can not be empty',
      name: 'validatorMessageText',
      desc: '',
      args: [],
    );
  }

  /// `How do you want to contact us?`
  String get contentTextSupportScreen {
    return Intl.message(
      'How do you want to contact us?',
      name: 'contentTextSupportScreen',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get whatsappTextSupportScreen {
    return Intl.message(
      'WhatsApp',
      name: 'whatsappTextSupportScreen',
      desc: '',
      args: [],
    );
  }

  /// `Call Us`
  String get callUsTextSupportScreen {
    return Intl.message(
      'Call Us',
      name: 'callUsTextSupportScreen',
      desc: '',
      args: [],
    );
  }

  /// `Chat Us`
  String get chatUsTextSupportScreen {
    return Intl.message(
      'Chat Us',
      name: 'chatUsTextSupportScreen',
      desc: '',
      args: [],
    );
  }

  /// `Contact Info`
  String get contactInfoSupportScreen {
    return Intl.message(
      'Contact Info',
      name: 'contactInfoSupportScreen',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weightPatientInformation {
    return Intl.message(
      'Weight',
      name: 'weightPatientInformation',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get heightPatientInformation {
    return Intl.message(
      'Height',
      name: 'heightPatientInformation',
      desc: '',
      args: [],
    );
  }

  /// `Social Situation`
  String get socialSituationPatientInformation {
    return Intl.message(
      'Social Situation',
      name: 'socialSituationPatientInformation',
      desc: '',
      args: [],
    );
  }

  /// `National ID`
  String get nationalIdPatientInformation {
    return Intl.message(
      'National ID',
      name: 'nationalIdPatientInformation',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstNameText {
    return Intl.message(
      'First Name',
      name: 'firstNameText',
      desc: '',
      args: [],
    );
  }

  /// `Middle Name`
  String get middleNameText {
    return Intl.message(
      'Middle Name',
      name: 'middleNameText',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastNameText {
    return Intl.message(
      'Last Name',
      name: 'lastNameText',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressText {
    return Intl.message(
      'Address',
      name: 'addressText',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButtonText {
    return Intl.message(
      'Cancel',
      name: 'cancelButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Have you had any vaccination?`
  String get vaccinationMedicalPatient {
    return Intl.message(
      'Have you had any vaccination?',
      name: 'vaccinationMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Significant Medical History`
  String get medicalHistoryMedicalPatient {
    return Intl.message(
      'Significant Medical History',
      name: 'medicalHistoryMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `List Any Medical Problems`
  String get medicalProblemsMedicalPatient {
    return Intl.message(
      'List Any Medical Problems',
      name: 'medicalProblemsMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `List Any medication taken regularly`
  String get regularlyMedicalPatient {
    return Intl.message(
      'List Any medication taken regularly',
      name: 'regularlyMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `List Any Allergies`
  String get allergiesMedicalPatient {
    return Intl.message(
      'List Any Allergies',
      name: 'allergiesMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Do you Have Medical Insurance?`
  String get insuranceMedicalPatient {
    return Intl.message(
      'Do you Have Medical Insurance?',
      name: 'insuranceMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Medical Insurance Details`
  String get medicalInsuranceDetailsMedicalPatient {
    return Intl.message(
      'Medical Insurance Details',
      name: 'medicalInsuranceDetailsMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Company Name`
  String get companyNameMedicalPatient {
    return Intl.message(
      'Insurance Company Name',
      name: 'companyNameMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Policy Number`
  String get policyNumberMedicalPatient {
    return Intl.message(
      'Policy Number',
      name: 'policyNumberMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDateMedicalPatient {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDateMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get filesMedicalPatient {
    return Intl.message(
      'Files',
      name: 'filesMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Files from data (Photos)`
  String get hintContainerFilesMedicalPatient {
    return Intl.message(
      'Files from data (Photos)',
      name: 'hintContainerFilesMedicalPatient',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editMedicalPatientButton {
    return Intl.message(
      'Edit',
      name: 'editMedicalPatientButton',
      desc: '',
      args: [],
    );
  }

  /// `Click to browse...`
  String get clickToBrowsePatientButton {
    return Intl.message(
      'Click to browse...',
      name: 'clickToBrowsePatientButton',
      desc: '',
      args: [],
    );
  }

  /// `Please enter first name`
  String get validatorFirstNameText {
    return Intl.message(
      'Please enter first name',
      name: 'validatorFirstNameText',
      desc: '',
      args: [],
    );
  }

  /// `enter last name`
  String get validatorLastNameText {
    return Intl.message(
      'enter last name',
      name: 'validatorLastNameText',
      desc: '',
      args: [],
    );
  }

  /// `enter middle name`
  String get validatorMiddleNameText {
    return Intl.message(
      'enter middle name',
      name: 'validatorMiddleNameText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Address`
  String get validatorAddressText {
    return Intl.message(
      'Please enter Address',
      name: 'validatorAddressText',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get backButtonText {
    return Intl.message(
      'Back',
      name: 'backButtonText',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get fromText {
    return Intl.message(
      'From',
      name: 'fromText',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get toText {
    return Intl.message(
      'To',
      name: 'toText',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get stateText {
    return Intl.message(
      'State',
      name: 'stateText',
      desc: '',
      args: [],
    );
  }

  /// `Please Select your Role`
  String get titleButtonSheetBookingRole {
    return Intl.message(
      'Please Select your Role',
      name: 'titleButtonSheetBookingRole',
      desc: '',
      args: [],
    );
  }

  /// `Please Select your language`
  String get titleButtonSheetLanguage {
    return Intl.message(
      'Please Select your language',
      name: 'titleButtonSheetLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Please Select your Country`
  String get titleButtonSheetCountry {
    return Intl.message(
      'Please Select your Country',
      name: 'titleButtonSheetCountry',
      desc: '',
      args: [],
    );
  }

  /// `Country Name...`
  String get hintTitleButtonSheetCountry {
    return Intl.message(
      'Country Name...',
      name: 'hintTitleButtonSheetCountry',
      desc: '',
      args: [],
    );
  }

  /// `Detection Price:`
  String get detectionPriceText {
    return Intl.message(
      'Detection Price:',
      name: 'detectionPriceText',
      desc: '',
      args: [],
    );
  }

  /// `Please Log In`
  String get pleaseLogInText {
    return Intl.message(
      'Please Log In',
      name: 'pleaseLogInText',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reasonText {
    return Intl.message(
      'Reason',
      name: 'reasonText',
      desc: '',
      args: [],
    );
  }

  /// `Medical examination details`
  String get medicalExaminationDetailsButtonText {
    return Intl.message(
      'Medical examination details',
      name: 'medicalExaminationDetailsButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Medical patient file`
  String get medicalPatientFileButtonText {
    return Intl.message(
      'Medical patient file',
      name: 'medicalPatientFileButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Medical prescription`
  String get medicalPrescriptionButtonText {
    return Intl.message(
      'Medical prescription',
      name: 'medicalPrescriptionButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Your Message Has Been Sent Successfully`
  String get messageSentSuccessfully {
    return Intl.message(
      'Your Message Has Been Sent Successfully',
      name: 'messageSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Has Been Added Successfully`
  String get doctorAddedSuccessfully {
    return Intl.message(
      'Doctor Has Been Added Successfully',
      name: 'doctorAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Has Been Deleted Successfully`
  String get doctorDeletedSuccessfully {
    return Intl.message(
      'Doctor Has Been Deleted Successfully',
      name: 'doctorDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your Ticket Posted Successfully`
  String get ticketAddedSuccessfully {
    return Intl.message(
      'Your Ticket Posted Successfully',
      name: 'ticketAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Type Of Your Problem`
  String get selectTypeOfProblemText {
    return Intl.message(
      'Please Select Type Of Your Problem',
      name: 'selectTypeOfProblemText',
      desc: '',
      args: [],
    );
  }

  /// `No Exist Doctors Search`
  String get contentSearchScreen {
    return Intl.message(
      'No Exist Doctors Search',
      name: 'contentSearchScreen',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get adminText {
    return Intl.message(
      'Admin',
      name: 'adminText',
      desc: '',
      args: [],
    );
  }

  /// `Your Ticket`
  String get titleTicketDetails {
    return Intl.message(
      'Your Ticket',
      name: 'titleTicketDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Message....`
  String get hintFieldTextTicketsDetails {
    return Intl.message(
      'Enter Your Message....',
      name: 'hintFieldTextTicketsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Message Context Can Not Be Empty`
  String get validatorFieldTextTicketsDetails {
    return Intl.message(
      'Message Context Can Not Be Empty',
      name: 'validatorFieldTextTicketsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get postButtonTicketsDetails {
    return Intl.message(
      'Post',
      name: 'postButtonTicketsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Thank You`
  String get thanksText {
    return Intl.message(
      'Thank You',
      name: 'thanksText',
      desc: '',
      args: [],
    );
  }

  /// `You Have Been Rate This Doctor Before `
  String get ratingAfterAdded {
    return Intl.message(
      'You Have Been Rate This Doctor Before ',
      name: 'ratingAfterAdded',
      desc: '',
      args: [],
    );
  }

  /// `You Must Book With Doctor `
  String get bookWithDoctor {
    return Intl.message(
      'You Must Book With Doctor ',
      name: 'bookWithDoctor',
      desc: '',
      args: [],
    );
  }

  /// `You Must Sign In `
  String get mustSignIn {
    return Intl.message(
      'You Must Sign In ',
      name: 'mustSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Rate your Doctor & Write Your Review..`
  String get titleOfRatingDialog {
    return Intl.message(
      'Rate your Doctor & Write Your Review..',
      name: 'titleOfRatingDialog',
      desc: '',
      args: [],
    );
  }

  /// `Your Doctor Review`
  String get doctorReviewText {
    return Intl.message(
      'Your Doctor Review',
      name: 'doctorReviewText',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Review`
  String get reviewTextField {
    return Intl.message(
      'Enter your Review',
      name: 'reviewTextField',
      desc: '',
      args: [],
    );
  }

  /// `Please Write You Review`
  String get validatorReviewTextField {
    return Intl.message(
      'Please Write You Review',
      name: 'validatorReviewTextField',
      desc: '',
      args: [],
    );
  }

  /// `Your Rating Has Added Successfully`
  String get ratingAdeddSuccessfully {
    return Intl.message(
      'Your Rating Has Added Successfully',
      name: 'ratingAdeddSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitButtonText {
    return Intl.message(
      'Submit',
      name: 'submitButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Please Select Your Rating `
  String get selectRatingText {
    return Intl.message(
      'Please Select Your Rating ',
      name: 'selectRatingText',
      desc: '',
      args: [],
    );
  }

  /// `Change Setting`
  String get changeSettingText {
    return Intl.message(
      'Change Setting',
      name: 'changeSettingText',
      desc: '',
      args: [],
    );
  }

  /// `Changing settings requires closing the app \nand reopening it  again, are you sure you want to do this?`
  String get alertChangeSetting {
    return Intl.message(
      'Changing settings requires closing the app \nand reopening it  again, are you sure you want to do this?',
      name: 'alertChangeSetting',
      desc: '',
      args: [],
    );
  }

  /// `are you sure you want to Sign Out?`
  String get alertSignOut {
    return Intl.message(
      'are you sure you want to Sign Out?',
      name: 'alertSignOut',
      desc: '',
      args: [],
    );
  }

  /// `AGREE`
  String get agreeText {
    return Intl.message(
      'AGREE',
      name: 'agreeText',
      desc: '',
      args: [],
    );
  }

  /// `DISAGREE`
  String get notAgreeText {
    return Intl.message(
      'DISAGREE',
      name: 'notAgreeText',
      desc: '',
      args: [],
    );
  }

  /// `In Case Of Emergency`
  String get addressEmergencyTitle {
    return Intl.message(
      'In Case Of Emergency',
      name: 'addressEmergencyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date Of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load, Please check your internet Connection`
  String get failedConnection {
    return Intl.message(
      'Failed to load, Please check your internet Connection',
      name: 'failedConnection',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Another Way`
  String get anotherWayText {
    return Intl.message(
      'Another Way',
      name: 'anotherWayText',
      desc: '',
      args: [],
    );
  }

  /// `You Must Select Your Country and State`
  String get countryAndState {
    return Intl.message(
      'You Must Select Your Country and State',
      name: 'countryAndState',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone Number is Invalid Please Try Again`
  String get phoneInvalid {
    return Intl.message(
      'Your Phone Number is Invalid Please Try Again',
      name: 'phoneInvalid',
      desc: '',
      args: [],
    );
  }

  /// `There Is An Error in Server Please Try Again Later`
  String get errorWithServer {
    return Intl.message(
      'There Is An Error in Server Please Try Again Later',
      name: 'errorWithServer',
      desc: '',
      args: [],
    );
  }

  /// `Un Authenticated`
  String get unAuthenticatedText {
    return Intl.message(
      'Un Authenticated',
      name: 'unAuthenticatedText',
      desc: '',
      args: [],
    );
  }

  /// `    `
  String get nullText {
    return Intl.message(
      '    ',
      name: 'nullText',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get titleOfChatsScreen {
    return Intl.message(
      'Chats',
      name: 'titleOfChatsScreen',
      desc: '',
      args: [],
    );
  }

  /// `Token is Un Correct`
  String get checkValidationOfTokenText {
    return Intl.message(
      'Token is Un Correct',
      name: 'checkValidationOfTokenText',
      desc: '',
      args: [],
    );
  }

  /// `Go to Home Page`
  String get goToHomeButton {
    return Intl.message(
      'Go to Home Page',
      name: 'goToHomeButton',
      desc: '',
      args: [],
    );
  }

  /// `medication taken regularly`
  String get selectMedicationRegularly {
    return Intl.message(
      'medication taken regularly',
      name: 'selectMedicationRegularly',
      desc: '',
      args: [],
    );
  }

  /// `Select your Allergies`
  String get selectMedicationAllergies {
    return Intl.message(
      'Select your Allergies',
      name: 'selectMedicationAllergies',
      desc: '',
      args: [],
    );
  }

  /// `Select your Vaccinations`
  String get selectMedicationVaccinations {
    return Intl.message(
      'Select your Vaccinations',
      name: 'selectMedicationVaccinations',
      desc: '',
      args: [],
    );
  }

  /// `please enter expiry date`
  String get validateOfExpiryDate {
    return Intl.message(
      'please enter expiry date',
      name: 'validateOfExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `please enter your Policy Number`
  String get validateOfPolicyNumber {
    return Intl.message(
      'please enter your Policy Number',
      name: 'validateOfPolicyNumber',
      desc: '',
      args: [],
    );
  }

  /// `please enter your Insurance Company Name`
  String get validateOfInsurance {
    return Intl.message(
      'please enter your Insurance Company Name',
      name: 'validateOfInsurance',
      desc: '',
      args: [],
    );
  }

  /// `type your message here ...`
  String get fieldTextHintOfChatScreen {
    return Intl.message(
      'type your message here ...',
      name: 'fieldTextHintOfChatScreen',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get stateOfCountry {
    return Intl.message(
      'State',
      name: 'stateOfCountry',
      desc: '',
      args: [],
    );
  }

  /// `Data Is Not Valid`
  String get dataOfRegisterInvalid {
    return Intl.message(
      'Data Is Not Valid',
      name: 'dataOfRegisterInvalid',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get emergencyFirstName {
    return Intl.message(
      'First Name',
      name: 'emergencyFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get emergencyLastName {
    return Intl.message(
      'Last Name',
      name: 'emergencyLastName',
      desc: '',
      args: [],
    );
  }

  /// `Please Select your Social Situation`
  String get validatorToSelectSocialSituation {
    return Intl.message(
      'Please Select your Social Situation',
      name: 'validatorToSelectSocialSituation',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveText {
    return Intl.message(
      'Save',
      name: 'saveText',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get updatedSuccessfully {
    return Intl.message(
      'Updated Successfully',
      name: 'updatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile Have Been Updated Successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Your Profile Have Been Updated Successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred Please Try Again`
  String get errorTextOnSignInWithSocialMedia {
    return Intl.message(
      'Error occurred Please Try Again',
      name: 'errorTextOnSignInWithSocialMedia',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
