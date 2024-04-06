class BookingUserInformation {
  int? id;
  String? parentId;
  String? patientId;
  String? doctorId;
  String? clinicId;
  String? reservationId;
  String? reservationTimeId;
  String? date;
  String? status;
  String? price;
  dynamic discount;
  String? finalPrice;
  String? payment;
  String? pathologicalDescription;
  Prescription? prescription;
  // List<Map<String,dynamic>>  prescription=[];
  List<String> attachments=[];
  String? notes;
  // String? canceledAt;
  String? createdAt;
  String? updatedAt;
  // String? deletedAt;
  DoctorOfBooking? doctor;
  ReservationTimeOfBooking? reservationTime;
  ClinicOfBooking? clinic;


  BookingUserInformation.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    reservationId = json['reservation_id'];
    reservationTimeId = json['reservation_time_id'];
    date = json['date'];
    status = json['status'];
    price = json['price'];
    discount = json['discount'];
    finalPrice = json['final_price'];
    payment = json['payment'];
    pathologicalDescription = json['pathological_description']!=null?json['pathological_description']:"null";
    // print("pathologicalDescription"+pathologicalDescription!.toString());

    if (json['attachments'] != null) {
      json['attachments'].forEach((value) {
        attachments.add("https://clinic.megavisionagency.com/"+value);
      });
    }


    if (json['prescription'].runtimeType != List<dynamic>) {
      prescription=Prescription.fromjson(json['prescription']);
    }
    // print("attachment"+attachments.length.toString());


    // if (json['prescription'].toString() != null) {
      // json['prescription'].forEach((key, value) {
      //   print("prescription lenght"+json['prescription'][key]);
      // });

      //
    // // int i=1;
    // prescription=Prescription.fromjson(json['prescription']);
    // print(prescription!.length);
    // // json['prescription'].forEach((value){
    // //     print(value);
    // //     prescription.add(value);
    // // });
    //
    // print("prescription lenght"+prescription!.toString());
    //
    // // prescription!.forEach((element) {
    // //   return prescriptionModel.add(PrescriptionModel.fromjson(element["${i}"]));
    // // });
    //
    // }


    notes = json['notes'];
    // canceledAt = json['canceled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
    doctor = DoctorOfBooking.fromJson(json['doctor']);
    reservationTime =ReservationTimeOfBooking.fromJson(json['reservation_time']);
    clinic =ClinicOfBooking.fromJson(json['clinic']);
  }

}
class Prescription{
  // PrescriptionModel? prescriptionModel1;
  // PrescriptionModel? prescriptionModel2;
  // PrescriptionModel? prescriptionModel3;
  // PrescriptionModel? prescriptionModel4;
  // PrescriptionModel? prescriptionModel5;
  // PrescriptionModel? prescriptionModel6;
  // PrescriptionModel? prescriptionModel7;
  // PrescriptionModel? prescriptionModel8;
  // PrescriptionModel? prescriptionModel9;
  // PrescriptionModel? prescriptionModel10;
  // PrescriptionModel? prescriptionModel11;
  // PrescriptionModel? prescriptionModel12;
  // PrescriptionModel? prescriptionModel13;
  // PrescriptionModel? prescriptionModel14;
  // PrescriptionModel? prescriptionModel15;
  // PrescriptionModel? prescriptionModel16;
  // PrescriptionModel? prescriptionModel17;
  // PrescriptionModel? prescriptionModel18;
  // PrescriptionModel? prescriptionModel19;
  // PrescriptionModel? prescriptionModel20;
  List<PrescriptionModel> prescriptionModel=[];

  Prescription.fromjson(Map<String,dynamic> json){
    for(int i=0;i<20;i++){
      prescriptionModel.add(PrescriptionModel.fromjson(json['${i+1}']));
    }
    // prescriptionModel1=PrescriptionModel.fromjson(json["1"]);
    // prescriptionModel2=PrescriptionModel.fromjson(json["2"]);
    // prescriptionModel3=PrescriptionModel.fromjson(json['3']);
    // prescriptionModel4=PrescriptionModel.fromjson(json['4']);
    // prescriptionModel5=PrescriptionModel.fromjson(json['5']);
    // prescriptionModel6=PrescriptionModel.fromjson(json['6']);
    // prescriptionModel7=PrescriptionModel.fromjson(json['7']);
    // prescriptionModel8=PrescriptionModel.fromjson(json['8']);
    // prescriptionModel9=PrescriptionModel.fromjson(json['9']);
    // prescriptionModel10=PrescriptionModel.fromjson(json['10']);
    // prescriptionModel11=PrescriptionModel.fromjson(json['11']);
    // prescriptionModel12=PrescriptionModel.fromjson(json['12']);
    // prescriptionModel13=PrescriptionModel.fromjson(json['13']);
    // prescriptionModel14=PrescriptionModel.fromjson(json['14']);
    // prescriptionModel15=PrescriptionModel.fromjson(json['15']);
    // prescriptionModel16=PrescriptionModel.fromjson(json['16']);
    // prescriptionModel17=PrescriptionModel.fromjson(json['17']);
    // prescriptionModel18=PrescriptionModel.fromjson(json['18']);
    // prescriptionModel19=PrescriptionModel.fromjson(json['19']);
    // prescriptionModel20=PrescriptionModel.fromjson(json['20']);
  }
}

class PrescriptionModel{
  String? note;
  String? name;

  PrescriptionModel.fromjson(Map<String, dynamic>? json){
    if(json!=null){
      this.note=json['note']!=null?json['note']:"";
      this.name=json['name']!=null?json['name']:"";
    }
  }
}


class DoctorOfBooking {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  int? age;
  bool? favorite;
  dynamic rating;


  DoctorOfBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    age = json['age'];
    favorite = json['favorite'];
    rating = json['rating'];
  }
}

class ReservationTimeOfBooking {
  int? id;
  String? reservationId;
  String? from;
  String? to;


  ReservationTimeOfBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    from = json['from'];
    to = json['to'];
  }

}

class ClinicOfBooking {
  int? id;
  String? name;



  ClinicOfBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}