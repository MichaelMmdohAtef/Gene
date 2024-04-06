import 'package:dio/dio.dart';

abstract class HomeStates{}

class InitialStates extends HomeStates{}
class OnChangeNavBarStates extends HomeStates{}
class OnChangeTapBarStates extends HomeStates{}
class OnChangeButtonSheetState extends HomeStates{}
class OnPopNavigatorState extends HomeStates{}
class OnChangeLanguageCheckbox extends HomeStates{}
class OnChangeCountriesCheckbox extends HomeStates{}
class OnInitScrollController extends HomeStates{}
class OnChangeRatingOfDoctorState extends HomeStates{}
class OnChangeEmojiState extends HomeStates{}
class OnFinishedDoctorScreen extends HomeStates{}
class OnSelectNameOfCountry extends HomeStates{}
class OnChangeConnectivityResult extends HomeStates{}
class OnChangeLocalLanguage extends HomeStates{}
class OnChangeSelectedPageNumber extends HomeStates{}
class OnChangeReservationOfBooking extends HomeStates{}
class OnChangeStateOFUserVaccination extends HomeStates{}
class OnChangeStateOFSocialSituation extends HomeStates{}
class OnChangeStateOFUserRegularly extends HomeStates{}
class OnChangeStateOFUserAllergies extends HomeStates{}
class OnChangeTypeOfProblem extends HomeStates{}
class OnChangeLocalCountryState extends HomeStates{}
class OnChangeCoronaVirus extends HomeStates{}
class OnChangeImageIndex extends HomeStates{}
class OnChangeDayBookingState extends HomeStates{}
class OnNavigateToNextCarouselImage extends HomeStates{}
class OnNavigateToPreviousCarouselImage extends HomeStates{}
class OnChangeCarouselImage extends HomeStates{}
class OnChangeInitialRating extends HomeStates{}
class OnChangeDoctorRating extends HomeStates{}
class OnChangeListOfMedicalImages extends HomeStates{}
class OnPressNotificationStates extends HomeStates{}
class OnCancelNotificationStates extends HomeStates{}
class OnPickFilesFromGallary extends HomeStates{}
class OnBackToTop extends HomeStates{}
class OnChangeAudioPath extends HomeStates{}
class OnSelectedMicrofone extends HomeStates{}

class OnChangeRateOfDoctor extends HomeStates{}
class OnChangeAudioPlayerState extends HomeStates{}
class OnChangeMessageModel extends HomeStates{}
class OnFillMessageModel extends HomeStates{}
class EmitState extends HomeStates{}

class OnLoadingGetClinicModel extends HomeStates{}
class OnSuccessGetClinicModel extends HomeStates{
  Response<dynamic> value;
  OnSuccessGetClinicModel({required Response<dynamic> this.value});
}
class OnErrorGetClinicModel extends HomeStates{}

class OnLoadingGetPatientModel extends HomeStates{}
class OnSuccessGetPatientModel extends HomeStates{}
class OnErrorGetPatientModel extends HomeStates{}

class OnLoadingUpdatePatientModel extends HomeStates{}
class OnSuccessUpdatePatientModel extends HomeStates{
  Response<dynamic> value;
  OnSuccessUpdatePatientModel({required Response<dynamic> this.value});
}
class OnErrorUpdatePatientModel extends HomeStates{}

class OnLoadingGetReservationModel extends HomeStates{}
class OnSuccessGetReservationModel extends HomeStates{}
class OnErrorGetReservationModel extends HomeStates{}

class OnLoadingGetMedicalProfile extends HomeStates{}
class OnSuccessGetMedicalProfile extends HomeStates{}
class OnErrorGetMedicalProfile extends HomeStates{}

class OnLoadingGetTypesOfTicket extends HomeStates{}
class OnSuccessGetTypesOfTicket extends HomeStates{
  Response<dynamic> value;
  OnSuccessGetTypesOfTicket({required Response<dynamic> this.value});
}
class OnErrorGetTypesOfTicket extends HomeStates{}

class OnLoadingCreateTicket extends HomeStates{}
class OnSuccessCreateTicket extends HomeStates{
  Response<dynamic> value;
  OnSuccessCreateTicket({required Response<dynamic> this.value});
}
class OnErrorCreateTicket extends HomeStates{}

class OnLoadingCreateComment extends HomeStates{}
class OnSuccessCreateComment extends HomeStates{}
class OnErrorCreateComment extends HomeStates{}

class OnLoadingGetTicket extends HomeStates{}
class OnSuccessGetTicket extends HomeStates{}
class OnErrorGetTicket extends HomeStates{}

class OnLoadingGetMyTicket extends HomeStates{}
class OnSuccessGetMyTicket extends HomeStates{}
class OnErrorGetMyTicket extends HomeStates{}

class OnLoadingPostBookingForDoctor extends HomeStates{}
class OnSuccessPostBookingForDoctor extends HomeStates{}
class OnErrorPostBookingForDoctor extends HomeStates{}

class OnLoadingGetMedicalAllergies extends HomeStates{}
class OnSuccessGetMedicalAllergies extends HomeStates{}
class OnErrorGetMedicalAllergies extends HomeStates{}

class OnLoadingUpdateBooking extends HomeStates{}
class OnSuccessUpdateBooking extends HomeStates{}
class OnErrorUpdateBooking extends HomeStates{}

class OnLoadingCancelBooking extends HomeStates{}
class OnSuccessCancelBooking extends HomeStates{}
class OnErrorCancelBooking extends HomeStates{}

class OnLoadingGetRating extends HomeStates{}
class OnSuccessGetRating extends HomeStates{}
class OnErrorGetRating extends HomeStates{}

class OnLoadingCreateRating extends HomeStates{}
class OnSuccessCreateRating extends HomeStates{}
class OnErrorCreateRating extends HomeStates{}

class OnLoadingGetFavourite extends HomeStates{}
class OnSuccessGetFavourite extends HomeStates{}
class OnErrorGetFavourite extends HomeStates{}

class OnLoadingDeleteFavourite extends HomeStates{}
class OnSuccessDeleteFavourite extends HomeStates{}
class OnErrorDeleteFavourite extends HomeStates{}

class OnLoadingAddFavourite extends HomeStates{}
class OnSuccessAddFavourite extends HomeStates{}
class OnErrorAddFavourite extends HomeStates{}

class OnLoadingGetBooking extends HomeStates{}
class OnSuccessGetBooking extends HomeStates{}
class OnErrorGetBooking extends HomeStates{}

class OnLoadingGetSpeciality extends HomeStates{}
class OnSuccessGetSpeciality extends HomeStates{}
class OnErrorGetSpeciality extends HomeStates{}

class OnLoadingUpdateMedicalProfile extends HomeStates{}
class OnSuccessUpdateMedicalProfile extends HomeStates{
  Response<dynamic> value;
  OnSuccessUpdateMedicalProfile({required Response<dynamic> this.value});
}
class OnErrorUpdateMedicalProfile extends HomeStates{}

class OnLoadingGetMedicalVaccinations extends HomeStates{}
class OnSuccessGetMedicalVaccinations extends HomeStates{}
class OnErrorGetMedicalVaccinations extends HomeStates{}

class OnLoadingGetMedicalRegularly extends HomeStates{}
class OnSuccessGetMedicalRegularly extends HomeStates{}
class OnErrorGetMedicalRegularly extends HomeStates{}

class OnNavigateToInsideScreen extends HomeStates{}
class NavigateToInsideScreen extends HomeStates{}

class SendMessageSuccessState extends HomeStates{}

class SendMessageErrorState extends HomeStates{}

class GetMessageSuccessState extends HomeStates{}

class OnWritingOnTextField extends HomeStates{}

class OnLoadingUploadDocument extends HomeStates{}
class OnSuccessUploadDocument extends HomeStates{}
class OnErrorUploadDocument extends HomeStates{}

class OnLoadingUploadImage extends HomeStates{}
class OnSuccessUploadImage extends HomeStates{}
class OnErrorUploadImage extends HomeStates{}

class OnLoadingUploadAudio extends HomeStates{}
class OnSuccessUploadAudio extends HomeStates{}
class OnErrorUploadAudio extends HomeStates{}

