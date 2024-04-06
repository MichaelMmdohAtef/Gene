
class Countries{
  int? id;
  String? name;
  String? iso2;
  // List<StatesModel>? states;

  Countries.fromjson(Map<String,dynamic> json, {List<StatesModel>? allStates}){
    this.id=json['id'];
    this.name=json['name'];
    this.iso2=json['iso2'];
    // this.states=allStates;
  }


}

class StatesModel{
  int? id;
  String? name;
  String? iso2;
  bool? check=false;

  StatesModel({
    bool? this.check,
});

  StatesModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.name=json['name'];
    this.iso2=json['iso2'];
  }
}
