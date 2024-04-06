import 'dart:io';

import 'package:Gene/shared/components/constants.dart';

class LoginModel{

  String? status;
  UserAccountLoginPage? userAccount;
  List<dynamic> errors=[];
  AuthorisationLoginPage? authorisation;

  LoginModel.fromjson(Map<String,dynamic> json){
    this.status=json['status'];
    if(this.status == errorState){
      this.errors=json['errors'];
      // json['errors'].forEach((element){
      //   this.errors.add(element);
      // });
    }else{
      this.userAccount=UserAccountLoginPage.fromjson(json['user']);
      this.authorisation=AuthorisationLoginPage.fromjson(json['authorisation']);
    }

  }

}

class UserAccountLoginPage{
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? birthDate;
  String? gender;
  // String? city;
  String? country;
  String? state;
  // String? zipCode;
  int? phoneCode;
  String? phoneNumber;
  String? address;
  String? email;
  // String? emailVerifiedAt;
  String? updateDate;
  String? createDate;
  String? image;
  File? imagePost;
  String? language;
  String? fullName;
  int? age;

  UserAccountLoginPage.fromjson(Map<String,dynamic> json){
    this.firstName=json["first_name"];
    this.middleName=json["middle_name"];
    this.lastName=json["last_name"];
    this.email=json['email'];
    // this.emailVerifiedAt=json['email_verified_at'];
    this.phoneNumber=json["phone_number"];
    this.phoneCode=json["phone_code"];
    // this.zipCode=json["zipCode"];
    this.birthDate=json["birth_date"];
    this.address=json["address"];
    this.gender=json["gender"];
    this.country=json["country"];
    this.state=json["state"];
    this.language=json["lang"];
    this.updateDate=json["updated_at"];
    this.createDate=json["created_at"];
    this.id=json["id"];
    this.fullName=json["full_name"];
    // this.city=json['city'];
    this.image=json['image'];
    this.age=json['age'];
    // this.imagePost=File(json['image']);
  }

  Map<String,dynamic> toMap()=>
      {
        "first_name":this.firstName,
        "middle_name":this.middleName,
        "last_name":this.lastName,
        'email':this.email,
        // "password":this.password,
        "phone_number":this.phoneNumber,
        "birth_date":this.birthDate,
        "address":this.address,
        "gender":this.gender,
        "country":this.country,
        "state":this.state,
        "lang":this.language,
        "updated_at":this.updateDate,
        "created_at":this.createDate,
        "id":this.id,
        "full_name":this.fullName,
        // 'image':this.imagePost,
        "age":this.age,
      };


}

class AuthorisationLoginPage{
  String? token;
  String? type;

  AuthorisationLoginPage.fromjson(Map<String,dynamic> json){
    this.token=json['token'];
    this.type=json['type'];
  }

}