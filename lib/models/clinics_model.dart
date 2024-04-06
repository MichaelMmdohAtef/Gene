class ClinicsModel{
  int? id=1;
  String? name="";
  String? image="";
  String? description="";
  String? specialityId="";
  String? speciality="";
  List<SupCategories>? supCategory=[];
  List<Doctors>? doctors=[];

  ClinicsModel.fromjson(Map<String,dynamic> json){
    this.name=json['name'];
    this.id=json['id'];
    this.image=json['image'];
    this.description=json['description'];
    this.specialityId=json['specialty_id'];
    this.speciality=json['specialty'];
    json['child'].forEach((element){
      this.supCategory!.add(SupCategories.fromjson(element));
    });
    json['doctors'].forEach((element){
      this.doctors!.add(Doctors.fromjson(element,json));
    });
  }
}

class SupCategories{
  int? id=1;
  String? name="";
  String? image="";
  String? description="";
  String? specialityId="";
  String? speciality="";

  SupCategories.fromjson(Map<String,dynamic> json){
    this.name = json['name'];
    this.id = json['id'];
    this.image = json['image'];
    this.description = json['description'];
    this.specialityId = json['specialty_id'];
    this.speciality = json['specialty'];
  }
}

class Doctors{
  // int? id=1;
  int? userId;
  String? firstName="";
  String? middleName="";
  String? lastName="";
  String? gender="";
  String? city="";
  String? phoneNumber;
  String? address="";
  String? image="";
  String? fullName="";
  String? clinicUserId;
  int? age;
  bool? favourite;
  dynamic rating;
  String? price;
  String? speciality;
  // List<MetaData> meta=[];
  // bool? isUserFavourite=false;

  Doctors({
    this.image,
    this.fullName,
    this.favourite,
    this.rating,
  });

  Doctors.fromjson(Map<String,dynamic> json,Map<String,dynamic> parentJson){
    // this.id=json["clinic_id"];
    this.userId=json['id'];
    this.firstName=json["first_name"];
    this.middleName=json["middle_name"];
    this.lastName=json["last_name"];
    this.gender=json["gender"];
    this.city=json["city"];
    this.phoneNumber=json["phone_number"];
    this.address=json["address"];
    this.image=json["image"];
    this.clinicUserId=json["clinic_user_id"];
    this.fullName=json["full_name"];
    this.age=json["age"];
    this.favourite=json["favorite"];
    this.rating=json["rating"];
    this.speciality=parentJson["specialty"];
    this.price=json['price'];
    // json["meta"].forEach((element){
    //   meta.add(MetaData.fromjson(element));
    // });
  }

  //  String getMetaValue(String key){
  //   for(int i=0;i<meta.length;i++){
  //     if(meta[i].key!.compareTo(key) == 0){
  //       return meta[i].value!;
  //     }
  //   }
  //   return "1";
  // }


}
class MetaData{
  String? userId;
  String? key;
  String? value;


  MetaData.fromjson(Map<String,dynamic> json){
    this.userId=json['user_id'];
    this.key=json['meta_key'];
    this.value=json['meta_value'];
  }
}