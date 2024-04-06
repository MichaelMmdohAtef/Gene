
class MedicalHistoryModel{
  List<String>? vaccine=[];
  String? coronavirus;
  String? medicalHistory;
  String? medicalProblems;
  List<String>? regularly=[];
  List<String>? allergies=[];
  String? insurance;
  String? insuranceCompanyName;
  String? policyNumber;
  String? expiryDate;
  List<String>? gallery=[];

  MedicalHistoryModel({
    this.vaccine,
  String? this.coronavirus,
  String? this.medicalHistory,
  String? this.medicalProblems,
  List<String>? this.regularly,
  List<String>? this.allergies,
  String? this.insurance,
  String? this.insuranceCompanyName,
  String? this.policyNumber,
  String? this.expiryDate,
  List<String>? this.gallery,
});

  MedicalHistoryModel.fromJson(Map<String,dynamic> json){
    json['VaccineList'].forEach((element){
      this.vaccine!.add(element);
    });
    this.coronavirus=json['Coronavirus'];
    this.medicalHistory=json['MedicalHistory'];
    this.medicalProblems=json['MedicalProblems'];
    json['regularly'].forEach((element){
      this.regularly!.add(element);
    });
    json['allergies'].forEach((element){
      this.allergies!.add(element);
    });
    this.insurance=json['insurance'];
    this.insuranceCompanyName=json['InsuranceCompanyName'];
    this.policyNumber=json['PolicyNumber'];
    this.expiryDate=json['ExpiryDate'];
    json['gallery'].forEach((element){
      this.gallery!.add(element);
    });
  }

  Map<String,dynamic> toMap(){
    return {
      "VaccineList":this.vaccine,
      "Coronavirus":this.coronavirus,
      "MedicalHistory":this.medicalHistory,
      'MedicalProblems':this.medicalProblems,
      "regularly":this.regularly,
      "allergies":this.allergies,
      "insurance":this.insurance,
      "InsuranceCompanyName":this.insuranceCompanyName,
      "PolicyNumber":this.policyNumber,
      "ExpiryDate":this.expiryDate,
    };
  }
}