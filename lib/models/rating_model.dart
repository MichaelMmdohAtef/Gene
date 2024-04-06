
class RatingModel {
  int? id;
  String? userId;
  String? doctorId;
  String? rating;
  String? comments;
  String? status;
  String? createdAt;
  String? updatedAt;
  DoctorForRating? doctor;

  RatingModel(
      {this.id,
        this.userId,
        this.doctorId,
        this.rating,
        this.comments,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.doctor});

  RatingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    rating = json['rating'];
    comments = json['comments'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor =
    json['doctor'] != null ?DoctorForRating.fromJson(json['doctor']) : null;
  }

}

class DoctorForRating {
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
  String? phoneCode;
  String? phoneNumber;
  String? address;
  String? email;
  Null emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? lang;
  String? token;
  String? fullName;
  int? age;
  bool? favorite;
  dynamic rating;

  DoctorForRating(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.birthDate,
        this.gender,
        this.city,
        this.country,
        this.state,
        this.zipCode,
        this.phoneCode,
        this.phoneNumber,
        this.address,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.lang,
        this.token,
        this.fullName,
        this.age,
        this.favorite,
        this.rating});

  DoctorForRating.fromJson(Map<String, dynamic> json) {
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