class TicketModel{
  int? id;
  String? userId;
  String? status;
  String? type;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? toAdmin;
  List<CommentModel>? comments=[];

  TicketModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.userId=json['user_id'];
    this.type=json['type'];
    this.title=json['title'];
    this.content=json['content'];
    this.createdAt=json['created_at'];
    this.updatedAt=json['updated_at'];
    this.toAdmin=json['toAdmin'];
    this.deletedAt=json['deleted_at'];
    this.status=json['status'];
    json['comments'].forEach((element){
      comments!.add(CommentModel.fromjson(element));
    });

  }

  Map<String,dynamic> toMap(){
    return {
      "type": this.type,
      "title": this.title,
      "content": this.content,
    };
  }
}
class CommentModel{
  int? id;
  String? userId;
  String? ticketId;
  String? content;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  CommentModel.fromjson(Map<String,dynamic> json){
    this.id=json['id'];
    this.userId=json['user_id'];
    this.ticketId=json['ticket_id'];
    this.content=json['content'];
    this.createdAt=json['created_at'];
    this.updatedAt=json['updated_at'];
    this.deletedAt=json['deleted_at'];
  }

  Map<String,dynamic> toMap(){
    return {
      // "id": this.id,
      // "user_id": this.userId,
      // "ticket_id":this.ticketId,
      "content": this.content,
      // "created_at": this.createdAt,
      // "updated_at": this.updatedAt,
      // "deleted_at": this.deletedAt,
    };
  }
}
class TypesModel{
  String? type;
  bool? check=false;
  TypesModel({String? this.type,bool? this.check});
}