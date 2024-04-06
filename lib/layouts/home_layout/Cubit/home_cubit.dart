import 'dart:typed_data';

import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/modules/chat/chat_screen.dart';
import 'package:Gene/modules/wallet_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Gene/models/Country%20Model/country_code.dart';
import 'package:Gene/models/Country%20Model/country_model.dart';
import 'package:Gene/models/booking_user_information.dart';
import 'package:Gene/models/favourites_model.dart';
import 'package:Gene/models/languageModel.dart';
import 'package:Gene/models/medical_history_model.dart';
import 'package:Gene/models/medical_setting_model.dart';
import 'package:Gene/models/message_model.dart';
import 'package:Gene/models/notifications_model.dart';
import 'package:Gene/models/patient_model.dart';
import 'package:Gene/models/rating_model.dart';
import 'package:Gene/models/specialization_model.dart';
import 'package:Gene/models/ticket_model.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/models/countries.dart';
import 'package:Gene/models/doctors_reservation_model.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:Gene/shared/network/remote_network/dio_helper.dart';
import 'package:Gene/shared/network/remote_network/end_point.dart';

import '../../../generated/l10n.dart';

class HomeCubit extends Cubit<HomeStates> {

  HomeCubit() :super(InitialStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  CarouselController pageController = CarouselController();
  CarouselController pageLargeCarouselController = CarouselController();
  ///controller that control scroll bar in Home Screen
  ScrollController? scrollClinicsController;

  ///if value is true so the up button must appear
  bool showBackToTopButton = false;
  double offSitOfHomeScreen = 0.0;
  double offSitOfDoctorsScreen = 0.0;
  double offSitOfSupDoctorsScreen = 0.0;
  bool showBackDoctorToTopButton = false;
  bool showBackClinicsToTopButton = false;
  bool showBackSupDoctorsToTopButton = false;
  int oldIndexNavBar = 0;
  int currentIndexNavBar = 0;
  int currentIndexTapBar = 0;
  int indexImage = 2;
  double initialRating = 0;
  bool onPressNotification = false;
  bool cancelNotification = false;
  List<ClinicsModel> clinics = [];
  List<DoctorsReservationModel> reservations = [];
  List<Doctors> allDoctors = [];
  List<Doctors> allClinicDoctors = [];
  bool? openedDownListVaccination = false;
  bool isFinishedDoctorScreen = false;
  List<SupCategories> allSupClinics = [];
  List<MedicalSettingModel> allAllergies = [];
  List<MedicalSettingModel> allVaccinations = [];
  List<MedicalSettingModel> allRegularly = [];
  List<SpecialityModel> allSpecializations = [];
  bool isSelectedMicro = false;
  String audioPath = "";
  bool isNavigateToSideScreen = false;
  bool isOutpatientScreen = false;
  bool isSupCategoriesScreen = false;
  bool shownButtonSheet = false;
  bool languageButtonSheetIsClosed = false;
  DateTime? dayOfBooking = null;
  bool? selectedTimeOfReservations = false;
  String localLanguage = "";
  CountryModel? localCountry = null;
  int selectedPageNumber = 1;
  int selectedTicketsPageNumber = 1;
  int selectedChatsPageNumber = 1;
  int selectedFavouritePageNumber = 1;
  List<bool>? valueOfCoronaVirus = [false, false];
  List<bool>? valueOfMedicalInsurance = [false, false];
  String? coronaVirus = "No";
  List<PickedFile>? files = [];
  String? havingMedicalInsurance = "Yes";
  double ratingValue = 0.0;
  List<CountryModel> countryList = countryData.map((country) =>
      CountryModel.from(json: country)).toList();
  List<CountryModel> countryOfPhoneList = countryData.map((country) =>
      CountryModel.from(json: country)).toList();
  List<CountryModel> filteredCountryList = [];
  List<CountryModel> filteredCountryOfPhoneList = [];
  DoctorsReservationModel? doctorsReservationModel;
  ReservationModel? reservationModel = null;
  bool showEmoji = false;
  var storageRef = FirebaseStorage.instance.ref();
  List<AudioPlayer> audioPlayers=[];
  List<MessageModel> allMessagesOfChat=[];

  emitScreen(){
    emit(EmitState());
  }


  ///list of countries depending on user search
  onSelectNameOfCountry({
   String? name,
   bool disposed=false,
}){
    filteredCountryList=[];
    if(!disposed){
      for (var e in countryList) {
        if(e.displayName.toLowerCase().contains(name!.toLowerCase())){
          filteredCountryList.add(e);
        }
      }
    }

    emit(OnSelectNameOfCountry());
  }

  onChangeStateOfAudioPlayer({
    required BuildContext context,
  })async{
      allMessagesOfChat.forEach((element) async{
        if(element.playing!){
          print("a");
          element.paused=true;
          element.playing=false;
          await element.audioPlayer!.pause();
        }
      });
    emit(OnChangeAudioPlayerState());
  }

  onChangeMessageModel({
    required BuildContext context,
    required MessageModel model,
    required int index
  }){
    // for (int i=0;i<allMessages.length;i++){
    //   if(i==index){
    //     allMessages[i]=model;
    //   }
    // }

      allMessagesOfChat.forEach((element) async{
        if(element.date!.compareTo(model.date!)==0){
         element=model;
         print(element.playing);
        }
      });
    emit(OnChangeMessageModel());
  }
  onFillMessageModel({
    required BuildContext context,
    required List<MessageModel> list
  }){
    allMessagesOfChat=list;
    // print(allMessages.length);
    emit(OnFillMessageModel());
  }


  ///change rate value
  onChangeRatingDoctor({
    required double rate,
}){
    ratingValue=rate;
    emit(OnChangeRatingOfDoctorState());
}


  ///change value of image files in medical profile
  onChangeListOfMedicalImages({
    required List<PickedFile>? lists,
  }){
    files=lists;
    emit(OnChangeListOfMedicalImages());
  }

  ///local list of notifications
  List<NotificationModel> notifications=[
    NotificationModel(
        title: "Some text input from data 1",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 2",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 3",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 4",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 5",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 6",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 7",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 8",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 9",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 10",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 11",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 12",
        duration: "30 Min ago",
        active: true),
    NotificationModel(
        title: "Some text input from data 13",
        duration: "30 Min ago",
        active: true),



  ];


  ///list of language model that app support it
  List<LanguageModel> languages=[
    LanguageModel(imageCountry: "assets/imageCountry/arabic.png",langCountry: "ar",  check: false),
    LanguageModel(imageCountry: "assets/imageCountry/english.png",langCountry: "en", check: false),
    // LanguageModel(imageCountry: "assets/imageCountry/french.png",langCountry: "fr", check: false),
  ];

  ///pick image from gallery in medical profile
  Future pickFilesFromGallery()async{
    files=[];
    await FilePicker.platform.pickFiles(allowMultiple: true,).then((value){
      files=[];
      if(value!=null){
        files=value.paths.map((path) {
          return PickedFile(path!);
        }).toList();
      }
    });
    emit(OnPickFilesFromGallary());
  }

  ///list of social situation in medical profile
  List<MedicalSettingModel> listOfSocialSituations=[
    MedicalSettingModel(name: "Unmarried",check: false),
    MedicalSettingModel(name: "Married",check: false),
    MedicalSettingModel(name: "Absolute",check: false),
    MedicalSettingModel(name: "Widower",check: false),
  ];

  ///get state of situation from index
  String? onChangeSocialSituations({int? index}){
    String? situation;
    if(index !=null){
      for(int i=0;i<listOfSocialSituations.length;i++){
        if(i==index){
          listOfSocialSituations[i].check=true;
          situation=listOfSocialSituations[index].name!;
        }else{
          listOfSocialSituations[i].check=false;
        }
      }
      emit(OnChangeStateOFSocialSituation());
    }
    return situation;
  }

  ///change state of vaccinations check box in app depending on index
  onChangeStateOFUserVaccination({int? index, bool? check})async{
    if(index !=null && check !=null){
      allVaccinations[index].check=check;
      emit(OnChangeStateOFUserVaccination());
    }else if(index != null){
      allVaccinations[index].check= !allVaccinations[index].check!;
      emit(OnChangeStateOFUserVaccination());
    }
    emit(OnChangeStateOFUserVaccination());
  }

  ///change state of regularly check box in medical profile screen depending on index
  onChangeStateOFUserRegularly({int? index, bool? check})async{
    if(index !=null && check !=null){
      allRegularly[index].check=check;
      emit(OnChangeStateOFUserRegularly());
    }else if(index != null){
      allRegularly[index].check= !allRegularly[index].check!;
      emit(OnChangeStateOFUserRegularly());
    }
    emit(OnChangeStateOFUserRegularly());
  }

  ///change state of allergies check box in medical profile screen depending on index
  onChangeStateOFUserAllergies({int? index, bool? check})async{
    if(index !=null && check !=null){
      allAllergies[index].check=check;
      emit(OnChangeStateOFUserAllergies());
    }else if(index != null){
      allAllergies[index].check= !allAllergies[index].check!;
      emit(OnChangeStateOFUserAllergies());
    }
    emit(OnChangeStateOFUserAllergies());
  }

  ///get type of problem in open ticket screen depending on index
  TypesModel onChangeTypeOfProblem({int? index}){
    TypesModel? model;
    for(int i=0;i<allTypesOfTickets.length;i++){
      if(i==index){
        allTypesOfTickets[i].check=true;
        model=allTypesOfTickets[i];
        emit(OnChangeTypeOfProblem());
      }
      else{
        allTypesOfTickets[i].check=false;
        emit(OnChangeTypeOfProblem());
      }
    }
    emit(OnChangeTypeOfProblem());

    return model!;
  }

  ///change state of corona virus vaccine check box in medical profile screen depending on index
  onChangeCoronaVirus({int? index}){
    for(int i=0;i<valueOfCoronaVirus!.length;i++){
      if(index==i){
        valueOfCoronaVirus![i]=true;
      }else{
        valueOfCoronaVirus![i]=false;
      }
    }
    emit(OnChangeCoronaVirus());
  }


  ///change state of medical insurance check box in medical profile screen depending on index
  onChangeMedicalInsurance({int? index}){
    for(int i=0;i<valueOfMedicalInsurance!.length;i++){
      if(index==i){
        valueOfMedicalInsurance![i]=true;
      }else{
        valueOfMedicalInsurance![i]=false;
      }
    }
    emit(OnChangeCoronaVirus());
  }

  ///change value of openedDownListVaccination when open or close down list
  ///of vaccines in medical profile screen
  onOpenedDownListVaccination({
    required bool opened
  }){
    openedDownListVaccination=opened;
    emit(OnChangeLocalLanguage());
  }



  ///dispose variables selected of reservation
  onDisposeTimeOfReservation(){
    for(int i=0;i<reservations.length;i++){
      for(int n=0;n<reservations[i].reservations.length;n++){
          reservations[i].reservations[n].isSelected=false;
      }
    }
    emit(OnChangeReservationOfBooking());
  }

  ///change state of reservation selected in doctor details screen
  onChangeTimeOfReservation({
    required bool selected,
    required int reservationTimeId,
  }){
    for(int i=0;i<reservations.length;i++){
        for(int n=0;n<reservations[i].reservations.length;n++){
          if(reservations[i].reservations[n].id==reservationTimeId){
            reservations[i].reservations[n].isSelected=true;
            reservationModel=reservations[i].reservations[n];
          }else{
            reservations[i].reservations[n].isSelected=false;
          }
      }
    }
    emit(OnChangeReservationOfBooking());
  }

  ///change state of variable on close button sheet
  onClosedLanguageButtonSheet({
    required bool isClosed
  }){
    languageButtonSheetIsClosed=isClosed;
    emit(OnChangeLocalLanguage());
  }

  ///change global language
  onChangeLanguage({
    required String lang,
  }){
    if(!lang.contains("fr")){
      localLanguage=lang;
    }
    emit(OnChangeLocalLanguage());
  }

  ///change index of selected screen in notifications screen
  onChangePageNumberOfNotification({
    required int value
  }){
    selectedPageNumber=value;
    emit(OnChangeSelectedPageNumber());
  }

  ///change index of selected screen in favourites screen
  onChangePageNumberOfFavourite({
    required int value
  }){
    selectedPageNumber=value;
    emit(OnChangeSelectedPageNumber());
  }

  ///change index of selected screen in my tickets screen
  onChangePageNumberOfTickets({
    required int value
  }){
    selectedTicketsPageNumber=value;
    emit(OnChangeSelectedPageNumber());
  }

  ///change index of selected screen in Chats screen
  onChangePageNumberOfChats({
    required int value
  }){
    selectedChatsPageNumber=value;
    emit(OnChangeSelectedPageNumber());
  }

  ///change state of language check box selected depending on index or name of language
   onChangeLanguageCheckbox({int? index,String? lang})async{
    if(index!=null){
      for (int i = 0; i < languages.length; i++) {
        if (i == index) {
          languages[i].check = true;
        } else {
          languages[i].check = false;
        }
      }
    }
    else if(lang!=null){
      for (int i = 0; i < languages.length; i++) {
        if (lang== languages[i].langCountry){
          languages[i].check = true;
        } else {
          languages[i].check = false;
        }
      }
    }
    emit(OnChangeLanguageCheckbox());
  }

  CountryModel? codeOfLocalCountry;

  ///change state of country check box selected depending on index or name of country
  ///and change state of filtered country check box selected depending on index or name of country
  onChangeCountriesOfPhoneCheckbox({int? index,String? lang,bool? isFiltered})
  async{
    if(isFiltered != null && isFiltered){
      if (index != null) {
        for (int i = 0; i < filteredCountryOfPhoneList.length; i++) {
          if (i == index) {
            filteredCountryOfPhoneList[i].check = true;
            codeOfLocalCountry=filteredCountryOfPhoneList[i];
          }
          else {
            filteredCountryOfPhoneList[i].check = false;
          }
        }
      }
    }
    else{
      if (index != null) {
        for (int i = 0; i < countryOfPhoneList.length; i++) {
          if (i == index) {
            countryOfPhoneList[i].check = true;
            codeOfLocalCountry=countryOfPhoneList[i];
          }else {
            countryOfPhoneList[i].check = false;
          }
        }
      }
      for (int i = 0; i < filteredCountryOfPhoneList.length; i++) {
        filteredCountryOfPhoneList[i].check = false;
      }
    }
    if(lang!=null && index==null){
      for (int i = 0; i < filteredCountryOfPhoneList.length; i++) {
        if (filteredCountryOfPhoneList[i].name.toLowerCase().compareTo(lang.toLowerCase()) == 0) {
          filteredCountryOfPhoneList[i].check = true;
          codeOfLocalCountry=filteredCountryOfPhoneList[i];
        }else {
          filteredCountryOfPhoneList[i].check = false;
        }
      }
      for (int i = 0; i < countryOfPhoneList.length; i++) {
        if (countryOfPhoneList[i].name.toLowerCase().compareTo(lang.toLowerCase()) == 0) {
          countryOfPhoneList[i].check = true;
          codeOfLocalCountry=countryOfPhoneList[i];
        }
        else{
          countryOfPhoneList[i].check = false;
        }
      }
    }
    emit(OnChangeLanguageCheckbox());
  }



  ///change state of country check box selected depending on index or name of country
  ///and change state of filtered country check box selected depending on index or name of country
  onChangeCountriesCheckbox({int? index,String? lang,bool? isFiltered})
  async{
    if(isFiltered != null && isFiltered){
      if (index != null) {
        for (int i = 0; i < filteredCountryList.length; i++) {
          if (i == index) {
            filteredCountryList[i].check = true;
            localCountry = filteredCountryList[i];
            codeOfLocalCountry=filteredCountryList[i];
          }
          else {
            filteredCountryList[i].check = false;
          }
        }
      }
    }
    else{
      if (index != null) {
        for (int i = 0; i < countryList.length; i++) {
          if (i == index) {
            countryList[i].check = true;
            localCountry = countryList[i];
            codeOfLocalCountry=countryList[i];
          }else {
            countryList[i].check = false;
          }
        }
      }
      for (int i = 0; i < filteredCountryList.length; i++) {
        filteredCountryList[i].check = false;
      }
    }
    if(lang!=null && index==null){
      for (int i = 0; i < filteredCountryList.length; i++) {
        if (filteredCountryList[i].name.toLowerCase().compareTo(lang.toLowerCase()) == 0) {
          filteredCountryList[i].check = true;
          localCountry = filteredCountryList[i];
          codeOfLocalCountry=filteredCountryList[i];
        }else {
          filteredCountryList[i].check = false;
        }
      }
      for (int i = 0; i < countryList.length; i++) {
          if (countryList[i].name.toLowerCase().compareTo(lang.toLowerCase()) == 0) {
            countryList[i].check = true;
            localCountry = countryList[i];
            codeOfLocalCountry=countryList[i];
          }
          else{
            countryList[i].check = false;
          }
        }
    }
    emit(OnChangeLanguageCheckbox());
  }




  ///get global country
  ///get id of country from api and compare it with all countries in api
  ///and get name of country and get country model from country list
  getLocalCountry({
    required BuildContext context,
  }){
    int country;
    SignInCubit.get(context).loginDataModel!.userAccount!=null && SignInCubit.get(context).loginDataModel!.userAccount!.country!=null?
    country=int.parse(SignInCubit.get(context).loginDataModel!.userAccount!.country!):country=66;
    List<Countries> allCountries=SignInCubit.get(context).allCountries;
    for(int i=0;i<allCountries.length;i++){
      if(allCountries[i].id==country){
        for (var element in countryList) {
         if(element.countryCode==allCountries[i].iso2){
           localCountry=element;
         }
        }
      }
    }
    emit(OnChangeLocalCountryState());
  }

  ///change variable on open or close button sheet
  changeButtonSheet({
    required bool isShow,
  }){
    shownButtonSheet=isShow;
    emit(OnChangeButtonSheetState());
    }


  ///
  int? onChangeRatingOfDoctor({
      required Doctors model,
      required double valueOfRating,
  }){
      int? indexOfDoctor;
      for(int i=0;i<allDoctors.length;i++){
        if(allDoctors[i].userId!.compareTo(model.userId!) == 0 ){
          allDoctors[i].rating=valueOfRating;
          indexOfDoctor=i;
        }
      }
      emit(OnChangeRateOfDoctor());
      return indexOfDoctor;
    }

  /// get all clinics from apis
  Future getClinicsData() async {
    emit(OnLoadingGetClinicModel());
    await DioHelper.getDataWithBearer(url:clinicsURL).then((value) {
      clinics = [];
      allDoctors=[];
      allClinicDoctors=[];
      allSupClinics=[];
      emit(OnLoadingGetClinicModel());
      if(value.statusCode == 200){
        value.data.forEach((element) {
          clinics.add(ClinicsModel.fromjson(element));
          element['doctors'].forEach((model) {
            allClinicDoctors.add(Doctors.fromjson(model,element));
          });
          allDoctors=getAllDoctors(allClinicDoctors);
          element['child'].forEach((parentModel) {
            allSupClinics.add(SupCategories.fromjson(parentModel));
          });
        });
        print("success get clinics");
      }else{
        print("error get clinics"+value.data['message']);
      }
      emit(OnSuccessGetClinicModel(value: value));
    }).catchError((onError) {
      clinics = [];
      allDoctors=[];
      allClinicDoctors=[];
      allSupClinics=[];
      print("error get clinics"+onError.toString());
      emit(OnErrorGetClinicModel());
    });
  }


  ///get list of doctor separately
  List<Doctors> getAllDoctors(List<Doctors> list){
    List<Doctors> allDoctors=[];
    allDoctors.add(list[0]);
    for(int i=0;i<list.length;i++){
      int k=0;
      for(int n=0;n<allDoctors.length;n++){
        if(allDoctors[n].userId!=list[i].userId){
          k++;
          if(k==allDoctors.length){
            allDoctors.add(list[i]);
          }
        }
      }
    }
    return allDoctors;
  }


  ///get reservation of doctor
  Future getDoctorsReservation({
   required int clinicsUsersId,
  }) async {
      emit(OnLoadingGetReservationModel());
      await DioHelper.getDataWithBearer(url:"doctor/$clinicsUsersId/booking").then((value) {
        reservations = [];
        value.data.forEach((element) {
          reservations.add(DoctorsReservationModel.fromjson(element));
        });
        print("success get doctor reservation");
        emit(OnSuccessGetReservationModel());
      }).catchError((onError) {

        print("error get doctor reservation");
        emit(OnErrorGetReservationModel());
      });
    }


  ///navigate between screens with Nav Bar
  ///currentIndexNavBar is the index of screen that i show
   onChangeNavBar(
    {required int index,
      required BuildContext context,
    }){
    currentIndexNavBar = index;
    if(index==2){
      if(userTokenApi!=null){
        navigateAndPush(context, WalletScreen());
      }else{
        navigateAndPush(context, SignInScreen());
      }
    }else{
      navigateAndPush(context, screens[currentIndexNavBar]);
    }
    emit(OnChangeNavBarStates());
}


  ///on tap with tap bar
    onChangeTapBar(
    {
      required int index,
    }){
    currentIndexTapBar = index;
    emit(OnChangeTapBarStates());
  }


  ClinicsModel? model=null;
  ///dispose date selected in date picker and reservation
  Future onChangeDateBooking({DateTime? date,ReservationModel? model})async{
    dayOfBooking=date;
    reservationModel=model;
    emit(OnChangeDayBookingState());
  }


  checkDoctor({
    required BuildContext context,
    required Doctors doctorModel
  }){
    for(int i=0;i<HomeCubit.get(context).reservations.length;i++){
      if(HomeCubit.get(context).reservations[i].id==doctorModel.userId){
        doctorsReservationModel=HomeCubit.get(context).reservations[i];
      }
    }
    emit(OnChangeReservationOfBooking());
  }


  ///indexImage is the index of carousel slider
  onChangeImageIndex(int index) {
    indexImage = index;
    emit(OnChangeImageIndex());
  }


  ///change the of of carousel slider
  Future onChangeCarouselImage(int? index)async{
    indexImage=index!;
    await pageLargeCarouselController.animateToPage(indexImage);
    await pageController.animateToPage(indexImage);
    emit(OnChangeCarouselImage());
  }


  /// on press the next button navigate the controller navigate the controller to next image
  onNavigateToNextCarouselImage(){
      indexImage=indexImage+1;
      pageController.nextPage();
      pageLargeCarouselController.nextPage();
      if(indexImage == smallMedicalImageEN.length){
        indexImage=0;
      }
    emit(OnNavigateToNextCarouselImage());
  }


  /// on press the next button navigate the controller navigate the controller to previous image
  onNavigateToPreviousCarouselImage(){
      indexImage=indexImage-1;
      pageController.previousPage();
      pageLargeCarouselController.previousPage();
      if(indexImage == 0){
        indexImage=smallMedicalImageEN.length-1;
      }
    emit(OnNavigateToPreviousCarouselImage());
  }

  ///showBackToTopButton if true appear the button of scroll to up in home screen
  onBackToTop({bool? index,required double offSit}) {
    showBackToTopButton = index!;
    offSitOfHomeScreen=offSit;
    emit(OnBackToTop());
  }

  ///showBackToTopButton if true appear the button of scroll to up in doctors screen
  onBackDoctorsToTop({bool? index,required double offSit}) {
    showBackDoctorToTopButton = index!;
    offSitOfDoctorsScreen=offSit;
    emit(OnBackToTop());
  }

  ///showBackToTopButton if true appear the button of scroll to up in doctors screen
  onBackSupDoctorsToTop({bool? index,required double offSit}) {
    showBackSupDoctorsToTopButton = index!;
    offSitOfSupDoctorsScreen=offSit;
    emit(OnBackToTop());
  }

  double offSitOfSearchScreen=0;
  String? seachTextOfSearchScreen;
  ///showBackToTopButton if true appear the button of scroll to up in doctors screen
  onBackSearchScreenToTop({String? name,required double offSit}) {
    seachTextOfSearchScreen = name!;
    offSitOfSearchScreen=offSit;
    emit(OnBackToTop());
  }


  ///showBackToTopButton if true appear the button of scroll to up in clinics screen
  onBackClinicsToTop({bool? index}) {
    showBackClinicsToTopButton = index!;
    emit(OnBackToTop());
  }


  ///initialRating the value of rating
  onChangeInitialRating({required double rate,}) {
    initialRating = rate;
    emit(OnChangeInitialRating());
  }


  ///onPressNotification if true that means notifications is on
  onChangePressNotification({required bool pressed,}) {
    onPressNotification = pressed;
    emit(OnPressNotificationStates());
  }


  ///cancelNotification if true that means notification disabled
  onCancelNotification({required bool canceled,}) {
    cancelNotification = canceled;
    emit(OnCancelNotificationStates());
  }


  ///scroll to top page in clinic screen
  void scrollClinicsToTop() {
    scrollClinicsController!.animateTo(scrollClinicsController!.position.minScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }








  ///check if offset of screen bigger than 30 make the button of scroll appear
  void checkScrollClinicsUp(BuildContext context) {
    scrollClinicsController=ScrollController();
    scrollClinicsController!..addListener(() {
        if (scrollClinicsController!.offset == scrollClinicsController!.position.maxScrollExtent-20) {
          onBackClinicsToTop(index: true);
        } else {
          onBackClinicsToTop(index: false);
        }
      });
  }


  ///get medical profile
  MedicalHistoryModel? medicalHistoryModel;
  Future getMedicalProfile()async{
    emit(OnErrorGetMedicalProfile());
    await DioHelper.getDataWithBearer(url:medicalProfileURL,).then((value){
      medicalHistoryModel=MedicalHistoryModel.fromJson(value.data);
      print("success get medical profile");
      emit(OnSuccessGetMedicalProfile());
    }).catchError((error){
      print("error get medical profile");
      emit(OnErrorGetMedicalProfile());
    });
  }


  ///update medical profile
  Future updateMedicalProfile({
    required MedicalHistoryModel model,
  })async{
      emit(OnLoadingUpdateMedicalProfile());
      await DioHelper.postDataWithBearer(url:updateMedicalProfileURL,data: model.toMap()).then((value)async{
        print("success update medical profile");
        await getMedicalProfile();
        emit(OnSuccessUpdateMedicalProfile(value: value));
      }).catchError((error){
        print("error update medical profile");
        emit(OnErrorUpdateMedicalProfile());
      });
    }


  ///update image medical profile
  Future updateImageMedicalProfile({
    required BuildContext context,
    dynamic formData,
  }) async {
    emit(OnLoadingUpdateMedicalProfile());
    await DioHelper.postDataWithBearerWithImg(url:updateMedicalProfileURL,formData: formData).then((value)async{
      print("success update image medical profile");
      emit(OnSuccessUpdateMedicalProfile(value: value));
    }).catchError((error){
      print("error update image medical profile");
      emit(OnErrorUpdateMedicalProfile());
    });
  }

  ///post booking that user book him
  Future postBookingForDoctor({
    required int doctorId,
    required int reservationTimeId,
    required String clinicsUsersId,
  })async{
      emit(OnLoadingPostBookingForDoctor());
      await DioHelper.postDataWithBearer(url:"doctor/$clinicsUsersId/booking",data: {
        "doctor_id":clinicsUsersId,
        "reservation_time_id":reservationTimeId,
        "clinics_users_id":clinicsUsersId,
      }).then((value)async{
        if(value.statusCode ==200){
          print("success post booking");
        }else if(value.statusCode ==422){
          print("error post booking with 422");
        }
        emit(OnSuccessPostBookingForDoctor());
      }).catchError((error){
        print("error post booking");
        emit(OnErrorPostBookingForDoctor());
      });
    }

  ///get favourite
  List<FavouritesModel> listOfFavourites=[];
  Future getFavourites()async{
    emit(OnLoadingGetFavourite());
    await DioHelper.getDataWithBearer(url:getFavouritesURL,).then((value)async{
      listOfFavourites=[];
      if(value.statusCode ==200){
        value.data.forEach((element){
          listOfFavourites.add(FavouritesModel.fromJson(element));
        });
        print('success get Favourite');
      }else if(value.statusCode ==422){
        print('error get Favourite with 422');
      }
      emit(OnSuccessGetFavourite());
    }).catchError((error){
      print('error get Favourite');
      emit(OnErrorGetFavourite());
    });
  }


  ///add favourite
  Future addFavourite({
    required int doctorUserId,
  })async{
    emit(OnLoadingAddFavourite());
    await DioHelper.postDataWithBearer(url:addFavouritesURL,data: {
      "doctor_id":doctorUserId,
    }).then((value)async{
      if(value.statusCode ==200){
        print('success add favourite');
      }else if(value.statusCode ==422){
        print('error add favourite with 422');
      }
      emit(OnSuccessAddFavourite());
    }).catchError((error){
      print('error add favourite');
      emit(OnErrorAddFavourite());
    });
  }

  ///delete favourite
  Future deleteFavourite({
    required int doctorUserId,
  })async{
    emit(OnLoadingDeleteFavourite());
    await DioHelper.postDataWithBearer(url:deleteFavouritesURL,data: {
      "doctor_id":doctorUserId,
    }).then((value)async{
      if(value.statusCode ==200){
        print('success Delete favourite');
        await getFavourites();
      }else if(value.statusCode ==422){
        print('error Delete favourite with 422');
      }
      emit(OnSuccessDeleteFavourite());
    }).catchError((error){
      print('error Delete favourite');
      emit(OnErrorDeleteFavourite());
    });
  }

  ///create rate for doctor
  Future createRating({
    required int doctorId,
    required double  rating,
    required String  comment,
  })async{
    emit(OnLoadingCreateRating());
    await DioHelper.postDataWithBearer(url:createRatingURL,data: {
      "doctor_id":doctorId,
      "rating":rating,
      "comments":comment,
    }).then((value)async{
      if(value.statusCode ==200){
        print('success create rating');
      }
      emit(OnSuccessCreateRating());
    }).catchError((error){
      print('error create rating');
      emit(OnErrorCreateRating());
    });
  }

  ///update rate for doctor
  Future updateRating({
    required int ratingId,
    required double  rating,
    required String  comment,
  })async{
    emit(OnLoadingCreateRating());
    await DioHelper.postDataWithBearer(url:"rating/$ratingId",data: {
      "rating":rating,
      "comments":comment,
    }).then((value)async{
      if(value.statusCode ==200){
        print('success create rating');
        await getRating();
      }
      emit(OnSuccessCreateRating());
    }).catchError((error){
      print('error create rating');
      emit(OnErrorCreateRating());
    });
  }

  ///get rating of user
  List<RatingModel> listOfRatingModel=[];
  Future getRating()async{
    emit(OnLoadingGetRating());
    await DioHelper.getDataWithBearer(url:getRatingURL,).then((value)async{
      listOfRatingModel=[];
      if(value.statusCode ==200){
        print('success get rating');
        value.data.forEach((element){
          listOfRatingModel.add(RatingModel.fromJson(element));
        });
      }else if(value.statusCode ==422){
        print('error get rating with 422');
      }
      emit(OnSuccessGetRating());
    }).catchError((error){
      print('error get rating');
      emit(OnErrorGetRating());
    });
  }

  ///update booking for user
  Future updateBookingForUser({
    required int bookingId,
    required int  anotherReservationTimeId,
  })async{
    emit(OnLoadingUpdateBooking());
    await DioHelper.postDataWithBearer(url:updateBookingForUserURL,data: {
      "booking_id":bookingId,
      "reservation_time_id":anotherReservationTimeId,
    }).then((value)async{
      if(value.statusCode ==200){
        print('success update booking');
        await getBookingForUser();
      }
      emit(OnSuccessUpdateBooking());
    }).catchError((error){
      print('error update booking');
      emit(OnErrorUpdateBooking());
    });
  }

  ///cancel booking for user
  Future cancelBookingForUser({
    required int bookingId,
    required BuildContext context,
  })async{
    emit(OnLoadingCancelBooking());
    await DioHelper.getDataWithBearer(url:"booking/$bookingId/canceled",).then((value)async{
      if(value.statusCode ==200){
        print('success cancel booking');
        showDialog(context: context, builder: (context) =>
        defaultDialog(text: "success cancel booking", context: context,
          nextWidget: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
        },));

      }else if(value.statusCode ==422){
        print('error cancel booking with 422');
        ///navigator of circle progress bar
        Navigator.pop(context);
      }
      emit(OnSuccessCancelBooking());
      await getBookingForUser();
    }).catchError((error){
      ///navigator of circle progress bar
      Navigator.pop(context);
      print('error cancel booking');
      emit(OnErrorCancelBooking());
    });
  }

  ///get booking for user
  List<BookingUserInformation> bookingUserInformation=[];
  Future getBookingForUser()async{
    emit(OnLoadingGetBooking());
    await DioHelper.getDataWithBearer(url:bookingForUserURL,).then((value){
      bookingUserInformation=[];

      if(value.statusCode ==200){
        print('success get booking');
        value.data.forEach((element){
          bookingUserInformation.add(BookingUserInformation.fromjson(element));
        });
      }

      emit(OnSuccessGetBooking());
    }).catchError((error){
      print('error get booking');
      emit(OnErrorGetBooking());
    });
  }

  ///get medical allergies
  getMedicalAllergies()async{
    emit(OnErrorGetMedicalAllergies());
    await DioHelper.getDataWithoutBearer(url:allergiesURL,).then((value){
      allAllergies=[];
      value.data.forEach((element){
        allAllergies.add(MedicalSettingModel.fromjson(element));
      });
      print("success get allergies");
      emit(OnSuccessGetMedicalAllergies());
    }).catchError((error){
      print("error get allergies");
      emit(OnErrorGetMedicalAllergies());
    });
  }

  ///get medical vaccinations
  getMedicalVaccinations()async{
    emit(OnErrorGetMedicalVaccinations());
    await DioHelper.getDataWithoutBearer(url:vaccinationsURL,).then((value){
      allVaccinations=[];
      value.data.forEach((element){
        allVaccinations.add(MedicalSettingModel.fromjson(element));
      });
      print("success get vaccinations");
      emit(OnSuccessGetMedicalVaccinations());
    }).catchError((error){
      print("error get vaccinations");
      emit(OnErrorGetMedicalVaccinations());
    });
  }

  ///get medical regularly
  Future getMedicalRegularly()async{
    emit(OnErrorGetMedicalRegularly());
    await DioHelper.getDataWithoutBearer(url:regularlyURL,).then((value){
      allRegularly=[];
      value.data.forEach((element){
        allRegularly.add(MedicalSettingModel.fromjson(element));
      });
      print("success get regularly");
      emit(OnSuccessGetMedicalRegularly());
    }).catchError((error){
      print("error get regularly");
      emit(OnErrorGetMedicalRegularly());
    });

  }


  List<TicketModel> allTickets=[];
  List<TypesModel> allTypesOfTickets=[];

  ///create ticket for user
  Future createTicket({
    required String title,
    required String type,
    required String content,
  })async{
    emit(OnLoadingCreateTicket());
    await DioHelper.postDataWithBearer(url:createTicketURL,data: {
      "title":title,
      "type":type,
      "content":content,
    }).then((value)async{
      print("success create ticket");
      emit(OnSuccessCreateTicket(value: value));
    }).catchError((error){
      print("error create ticket");
      emit(OnErrorCreateTicket());
    });
  }


  ///create reply on ticket from user to admin
  Future createComment({
    required String comment,
    required int ticketId,
  })async{
    emit(OnLoadingCreateComment());
    await DioHelper.postDataWithBearer(url:"tickets/$ticketId/comment",data: {
      "content":comment,
    }).then((value){
      print("success create comment");
      emit(OnSuccessCreateComment());
    }).catchError((error){
      print("error create comment");
      emit(OnErrorCreateComment());
    });
  }


  ///get types of ticket problems
  Future getTypesOfTickets() async{
    emit(OnErrorGetTypesOfTicket());
    await DioHelper.getDataWithBearer(url:typesOfTicketsURL,).then((value){
      allTypesOfTickets=[];
      value.data.forEach((element){
        allTypesOfTickets.add(TypesModel(type: element.toString()));
      });
      print("success get types of ticket");
      emit(OnSuccessGetTypesOfTicket(value: value));
    }).catchError((error){
      print("error get types of ticket");
      emit(OnErrorGetTypesOfTicket());
    });
  }


  ///update patient information
  Future updatePatient({
    required PatientInformationModel model,
    required BuildContext context,
  })async{
    emit(OnLoadingUpdatePatientModel());
    await DioHelper.postDataWithBearer(url:updatePatientURL,data:model.toJson()).then((value)async{
      if(value.statusCode==200){
        print("success update patient");
        await getPatient(context: context);
        Navigator.pop(context);
        print(value.data['message'].toString());
        showDialog(context: context, builder: (context) =>
            defaultDialog(text: S.current.updatedSuccessfully, context: context,nextWidget: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },));
        // Navigator.pop(context);
      }else if(value.statusCode==422){
        print("error update patient with 422");
        showDialog(context: context, builder: (context) =>
        defaultDialog(text: value.data['message'].toString(), context: context,nextWidget: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },));
      }

      emit(OnSuccessUpdatePatientModel(value: value));
    }).catchError((error){
      Navigator.pop(context);
      print("error update patient");
      emit(OnErrorUpdatePatientModel());
    });
  }


  ///get patient information
  PatientInformationModel? patientInformationModel;
  Future getPatient({
    required BuildContext context
}) async{
    emit(OnErrorGetPatientModel());
    await DioHelper.getDataWithBearer(url:getPatientURL,).then((value){
      if(value.statusCode==200){
        patientInformationModel=PatientInformationModel.fromJson(value.data);
        print('success get patient');
      }else if(value.statusCode==422){
        print('error get patient with 422');
        showDialog(context: context, builder: (context) =>
            defaultDialog(context: context, text: value.data['message'].toString()));
      }
      emit(OnSuccessGetPatientModel());
    }).catchError((error){
      print('error get patient');
      emit(OnErrorGetPatientModel());
    });
  }


  ///get all tickets
  Future getAllTickets() async{
    emit(OnErrorGetTicket());
    await DioHelper.getDataWithBearer(url:createTicketURL,).then((value){
      allTickets=[];
      value.data.forEach((element){
        allTickets.add(TicketModel.fromjson(element));
      });
      print('success get tickets of user');
      emit(OnSuccessGetTicket());
    }).catchError((error){
      print('error get tickets of user');
      emit(OnErrorGetTicket());
    });
  }


  ///get my ticket
  TicketModel? myTicketModel;
  Future getMyTicket({
    required int idOfTicket,
  }) async{
      emit(OnErrorGetMyTicket());
      await DioHelper.getDataWithBearer(url:"tickets/$idOfTicket",).then((value){
        myTicketModel=TicketModel.fromjson(value.data);
        print('success get my tickets');
        emit(OnSuccessGetMyTicket());
      }).catchError((error){
        print('error get my tickets');
        emit(OnErrorGetMyTicket());
      });
    }

  ///send message to admin
  Future sendMessage({
    required String receiverUser,
    String? message,
    String? voicePath,
    String? filePath,
    String? imageURL,
    required String typeOfMessage,
    required String dateTime,
    String? size,
    bool? callCameraFromDialog,
    String? extension,
    String? nameOfDocument,
    String? durationOfAudion,
    required BuildContext context,
    required Doctors doctorModel,
  })async{
    String userUid=SignInCubit.get(context).loginDataModel!.userAccount!.id.toString();
    MessageModel model=MessageModel(
      senderUserUrl: userUid,
      receiverUserUrl: receiverUser,
      message: message,
      date: dateTime,
      size: size,
      imageURL: imageURL,
      extension: extension,
      durationOfAudio: durationOfAudion,
      nameOfDocument: nameOfDocument,
      filePath: filePath,
      voiceRecord: voicePath,
      typeOfMessage:typeOfMessage,
      paused: false,
      playing: false,
    );

    await FirebaseFirestore.instance.collection(Collection)
        .doc(userUid).collection("Chats").doc(receiverUser)
        .collection("Messages").add(model.toMap()).then((value){
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });

    ///send message to receiver
    await FirebaseFirestore.instance.collection(Collection)
        .doc(receiverUser).collection("Chats").doc(userUid)
        .collection("Messages").add(model.toMap()).then((value){
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
    Navigator.pop(context);
    if(callCameraFromDialog ==false){

    }else{
      Navigator.pop(context);
    }
    // navigateAndReplace(context: context, widget: ChatScreen(doctorModel: doctorModel));
  }


  ///change variable of isTextFieldWriting on writting on text field
  bool isTextFieldWriting=false;
  onWritingOnTextField({required bool isWriting}){
    isTextFieldWriting = isWriting;
    emit(OnWritingOnTextField());
  }


  ///change audio path to true on isTextFieldWriting = false
  onChangeAudioPath({required String path}){
    audioPath = path;
    emit(OnChangeAudioPath());
  }



  onSelectedMicrophone({required bool isSelected}){
    isSelectedMicro= isSelected;
    emit(OnSelectedMicrofone());
  }


  String? audioURL;
  ///upload Audio to FireBase
  Future uploadAudioToFireStore({
    required Uint8List file,
    required String path,
    required BuildContext context,
    required String receiverId,
    required String durationOfAudio,
    // required String size,
    required String extension,
    required String name,
    required Doctors doctorModel,
})async{
    final metadata = SettableMetadata(
        contentType: 'audio/m4a',
        customMetadata: {'picked-file-path': path});
    audioURL=null;
    emit(OnLoadingUploadAudio());
    return await storageRef.child("Audio/${Uri.file(path).pathSegments.last}").putData(file,metadata).then((value){
      value.ref.getDownloadURL().then((value){
        audioURL= value.toString();
        if(audioURL!=null){
          sendMessage(
            receiverUser: receiverId,
            voicePath: audioURL,
            typeOfMessage: TypeOfMessage.audio.name,
            dateTime: DateTime.now().toLocal().toString(),
            context: context,
            extension: extension,
            durationOfAudion: durationOfAudio,
            callCameraFromDialog: false,
            // size: size,
            nameOfDocument: name,
            doctorModel: doctorModel
          );
        }
        print(value.toString());
        print("success upload Audio to firebase");
      });
      emit(OnSuccessUploadAudio());
    }).catchError((error){
      print("error upload Audio to firebase");
      emit(OnErrorUploadAudio());
    });
}


  String? documentUrl;
  ///upload Document to FireBase
  Future uploadDocumentToFireStore({
    required Uint8List file,
    required String path,
    required BuildContext context,
    required String receiverId,
    required String size,
    required String extension,
    required String name,
    required Doctors doctorModel,
  })async{
    documentUrl=null;
    emit(OnLoadingUploadDocument());
    return await storageRef.child("Docs/${Uri.file(path).pathSegments.last}").putData(file).then((value){
      value.ref.getDownloadURL().then((value)async{
        documentUrl= value.toString();
        if(documentUrl !=null){
          await sendMessage(
            receiverUser: receiverId,
            filePath: documentUrl,
            typeOfMessage: TypeOfMessage.file.name,
            dateTime: DateTime.now().toLocal().toString(),
            size: size,
            extension: extension,
            nameOfDocument: name,
            context: context,
            doctorModel: doctorModel
          );
        }
        print("success upload Docs to firebase");
      });
      emit(OnSuccessUploadDocument());
    }).catchError((error){
      print("error upload Docs to firebase");
      emit(OnErrorUploadDocument());
    });
  }

  String? imageURL;
  ///upload Document to FireBase
  Future uploadImageToFireStore({
    required Uint8List file,
    required String path,
    required BuildContext context,
    required String receiverId,
    required String size,
    required String extension,
    required String name,
    bool? callCameraFromDialog,
    required Doctors doctorModel,
  })async{
    imageURL=null;
    emit(OnLoadingUploadImage());
    return await storageRef.child("images/${Uri.file(path).pathSegments.last}").putData(file).then((value){
      value.ref.getDownloadURL().then((value){
        imageURL= value.toString();
        if(imageURL !=null){
          sendMessage(
            receiverUser: receiverId,
            imageURL: imageURL,
            typeOfMessage: TypeOfMessage.image.name,
            dateTime: DateTime.now().toLocal().toString(),
            size: size,
            callCameraFromDialog: callCameraFromDialog,
            extension: extension,
            nameOfDocument: name,
            context: context,
            doctorModel: doctorModel
          );
        }
        print("success upload Docs to firebase");
      });
      emit(OnSuccessUploadImage());
    }).catchError((error){
      print("error upload Docs to firebase");
      emit(OnErrorUploadImage());
    });
  }

  ///change appearance of emoji container
  onChangeEmojiState(){
      showEmoji=!showEmoji;
      emit(OnChangeEmojiState());
  }


}