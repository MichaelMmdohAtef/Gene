class BookingInformationModel{
  String? clinic;
  String? doctor;
  String? dayOfBooking;
  int? role;
  String? time;
  bool? onlinePaymentMethod;
  BookingState? bookingState;
  String? reason;

  BookingInformationModel({
    String? this.clinic,
    String? this.doctor,
    String? this.dayOfBooking,
    int? this.role,
    String? this.time,
    bool? this.onlinePaymentMethod,
    BookingState? this.bookingState,
    String? this.reason,
});

}
enum BookingState{
  Canceled,
  Done,
  waiting
}

enum PaymentMethod{
  online,
  cash
}