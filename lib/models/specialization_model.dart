class SpecialityModel{
  int? id;
  String? name;
  dynamic parentId;
  String? status;
  String? updateDate;
  String? createDate;
  String? deletedDate;

  SpecialityModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.name=json['name'];
    this.parentId=json['parent_id'];
    this.status=json['status'];
    this.updateDate=json['updated_at'];
    this.createDate=json['created_at'];
    this.deletedDate=json['deleted_at'];
  }
}