class MedicalSettingModel{
  int? id;
  String? name;
  bool? check=false;

  MedicalSettingModel({String? this.name,bool? this.check});

  MedicalSettingModel.fromjson(Map<String,dynamic> json){
     this.id=json['id'];
     this.name=json['name'];
  }
}