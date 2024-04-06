
class RegisterModel{
  String? status;
  String? message;
  UserAccountRegisterPage? userAccount;
  // List<String> errors=[];
  AuthorisationLoginPage? authorisation;
  RegisterModel.fromjson(Map<String,dynamic> json){
    this.status=json['status'];
    this.message=json['message'];
    if(this.status != null){
      this.userAccount=UserAccountRegisterPage.fromjson(json['user']);
      this.authorisation=AuthorisationLoginPage.fromjson(json['authorisation']);
    }else{
      // json['errors']['email'].forEach((element){
      //   errors.add(json['errors']['email'][0]);
      // });
    }


  }

}



class UserAccountRegisterPage{

  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? birthDate;
  String? address;
  String? gender;
  String? country;
  String? state;
  String? language;
  String? updateDate;
  String? createDate;
  int? id;
  String? fullName;

  UserAccountRegisterPage({
  required this.firstName,
    this.middleName,
  required this.lastName,
  required this.email,
  required this.password,
  required this.phoneNumber,
  String? this.birthDate,
  String? this.address,
  required this.gender,
  String? this.country,
  String? this.state,
  required this.language,
  String? this.updateDate,
  String? this.createDate,
  int? this.id,
  required this.fullName,
  });

  UserAccountRegisterPage.fromjson(Map<String,dynamic> json){
    this.firstName=json["first_name"];
    this.middleName=json["middle_name"];
    this.lastName=json["last_name"];
    this.email=json['email'];
    this.phoneNumber=json["phone_number"];
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
  }


  Map<String,dynamic> toMap()=>
      {
      "first_name":this.firstName,
      "middle_name":this.middleName,
      "last_name":this.lastName,
      'email':this.email,
      "password":this.password,
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
      "full_name":this.fullName
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