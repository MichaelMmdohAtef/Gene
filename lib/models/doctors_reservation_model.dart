class DoctorsReservationModel{
  int? id;
  String? clinicUserId;
  String? date;
  List<ReservationModel> reservations=[];
  DoctorsReservationModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.clinicUserId=json['clinics_users_id'];
    this.date=json['date'];
    json['reservations'].forEach((element){
      reservations.add(ReservationModel.fromjson(element));
    });
  }
}

class ReservationModel{
  int? id;
  String? startDate;
  String? endDate;
  bool? reserved;
  bool? isSelected=false;
  bool? isMine=false;

  ReservationModel({bool? this.isSelected});

  ReservationModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    startDate=json['from'];
    endDate=json['to'];
    this.reserved=json['reserved'];
  }

}