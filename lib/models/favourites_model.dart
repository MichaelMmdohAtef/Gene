class FavouritesModel {
  int? idOfFavourite;
  String? userId;
  String? doctorUserId;
  String? createdAt;
  String? updatedAt;
  DoctorOfFavourite? doctor;


  FavouritesModel.fromJson(Map<String, dynamic> json) {
    idOfFavourite = json['id'];
    userId = json['user_id'];
    doctorUserId = json['doctor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor =
    json['doctor'] != null ? new DoctorOfFavourite.fromJson(json['doctor']) : null;
  }


}

class DoctorOfFavourite {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? birthDate;
  String? gender;
  String? city;
  String? country;
  String? state;
  String? zipCode;
  Null phoneCode;
  String? phoneNumber;
  String? address;
  String? email;
  Null emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? lang;
  Null token;
  String? fullName;
  int? age;
  bool? favorite;
  dynamic rating;


  DoctorOfFavourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    zipCode = json['zipCode'];
    phoneCode = json['phone_code'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    lang = json['lang'];
    token = json['token'];
    fullName = json['full_name'];
    age = json['age'];
    favorite = json['favorite'];
    rating = json['rating'];
  }

}