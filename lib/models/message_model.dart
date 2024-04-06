import 'package:audioplayers/audioplayers.dart';

class MessageModel {
  int? id;
  String? date;
  String? receiverUserUrl;
  String? senderUserUrl;
  String? message;
  String? voiceRecord;
  String? filePath;
  String? imageURL;
  String? typeOfMessage;
  String? size;
  String? extension;
  String? nameOfDocument;
  String? durationOfAudio;
  AudioPlayer? audioPlayer;
  bool? playing=false;
  bool? paused=false;
  Duration? duration;
  Duration? position;



  MessageModel({
    this.date,
    this.receiverUserUrl,
    this.senderUserUrl,
    String? this.message,
    String? this.voiceRecord,
    String? this.filePath,
    String? this.imageURL,
    String? this.typeOfMessage,
    String? this.size,
    String? this.extension,
    String? this.nameOfDocument,
    String? this.durationOfAudio,
    AudioPlayer? this.audioPlayer,
    int? this.id,
    bool? this.playing,
    bool? this.paused,
    Duration? this.duration,
    Duration? this.position,
  });




  MessageModel.fromJson({required Map<String, dynamic> json, int? id}) {
    this.date = json['date'];
    this.receiverUserUrl = json['receiver_user'];
    this.senderUserUrl = json['sender_user'];
    this.message =json['message'] !=null?json['message']:null;
    this.voiceRecord =json['voice'] !=null?json['voice']:null;
    this.imageURL =json['image_url'] !=null?json['image_url']:null;
    this.filePath =json['file'] !=null? json['file']:null;
    this.typeOfMessage =json['type'] !=null? json['type']:null;
    this.size=json['size']!=null?json['size']:null;
    this.extension=json['extension']!=null?json['extension']:null;
    this.nameOfDocument=json['name']!=null?json['name']:null;
    this.durationOfAudio=json['audio_duration']!=null?json['audio_duration']:null;
    this.id=id!=null?id:null;
    // this.playing=json['playing']!=null?json['playing']:null;
    // this.paused=json['paused']!=null?json['paused']:null;
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      "receiver_user": this.receiverUserUrl,
      'sender_user': this.senderUserUrl,
      'message': this.message,
      'voice': this.voiceRecord,
      'file': this.filePath,
      'image_url': this.imageURL,
      "type":this.typeOfMessage,
      'name': this.nameOfDocument,
      'extension':this.extension,
      'size':this.size,
      "audio_duration":this.durationOfAudio,
      // "playing":this.playing,
      // "paused":this.paused,
    };
  }
}