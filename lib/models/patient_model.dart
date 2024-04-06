class PatientInformationModel {
  String? weight=null;
  String? height=null;
  String? socialSituation=null;
  String? nationalID=null;
  String? firstname=null;
  String? lastname=null;
  String? phoneNumber=null;
  String? address=null;

  PatientInformationModel(
      {this.weight,
        this.height,
        this.socialSituation,
        this.nationalID,
        this.firstname,
        this.lastname,
        this.phoneNumber,
        this.address});

  PatientInformationModel.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    height = json['height'];
    socialSituation = json['socialSituation'];
    nationalID = json['NationalID'];
    firstname = json['Firstname'];
    lastname = json['Lastname'];
    phoneNumber = json['phone_number'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['socialSituation'] = this.socialSituation;
    data['NationalID'] = this.nationalID;
    data['Firstname'] = this.firstname;
    data['Lastname'] = this.lastname;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}