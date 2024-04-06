import 'package:Gene/models/message_model.dart';
import 'package:Gene/modules/chat/chat_screen.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AudioPlayerWidget extends StatefulWidget {
  MessageModel? model;
  bool rtl=false;
   AudioPlayerWidget(
     {super.key,
     required this.model,
     this.rtl=false,});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> with TickerProviderStateMixin{

  List<AudioPlayer> audioPlayers=[];

  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  DateTime? dateOfMessage;

  bool paused=false;
  bool played=false;
  int? index;
  Source? source;


  @override
  void initState() {
    index=widget.model!.id;

    if(index!=null){
      print(index);
      // TODO: implement initState
      ChatScreenState.audioPlayers[index!].onPlayerStateChanged.listen((event) {
        if(mounted) {
          setState(() {
            print("played");
            print(index);
            played = event == PlayerState.playing;
          });
        }
      });
      ChatScreenState.audioPlayers[index!].onDurationChanged.listen((newDuration) {
        if(mounted) {
          setState(() {
            duration = newDuration;
          });
        }
      });
      ChatScreenState.audioPlayers[index!].onPositionChanged.listen((newPosition) {
        if(mounted) {
          setState(() {
            position = newPosition;
          });
        }
      });
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        index=widget.model!.id;

        dateOfMessage=DateTime.parse(widget.model!.date.toString());
        source=UrlSource(widget.model!.voiceRecord!);
        getDurationOfAudio();
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///audio
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.14,
                    child: CircleAvatar(
                      backgroundColor:defaultBlueAccentColor,
                      radius: 18,
                      child: IconButton(
                        onPressed: ()async{
                          if(played){
                            pauseAudioPlayer(context: context);
                          }else{
                            if(paused){
                              resumeAudioPlayer(context: context);
                            }else{
                              print(index);
                              startAudioPlayer(context: context);
                            }
                          }
                        },
                        icon:played?
                        Icon(
                            color: Colors.white,
                            Icons.pause
                        ):
                        Icon(
                            color: Colors.white,
                            Icons.play_arrow
                        ),
                        padding: EdgeInsets.all(0),
                      ),
                    ),
                  ),
                  ///progress par
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ProgressBar(
                          buffered: duration,
                          progress: position,
                          total: duration,
                          barCapShape: BarCapShape.square,
                          onSeek: (value) {
                              ChatScreenState.audioPlayers[index!].seek(value);
                          },
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.007,
              ),
              ///date of message
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("${dateOfMessage!.day==DateTime.now().day?"today":"${dateOfMessage!.year}/${dateOfMessage!.month}/${dateOfMessage!.day}"}  ${dateOfMessage!.hour}:${dateOfMessage!.minute}"),
                ],
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(15),
              bottomEnd: Radius.circular(0),
              topEnd: Radius.circular(15),
              bottomStart:widget.rtl?Radius.circular(0): Radius.circular(15),
            ),
          ),
        );
      }
    );
  }



  ///get time of audio
  getDurationOfAudio()async{
    DateTime date=DateTime.parse(widget.model!.durationOfAudio!);
    duration=Duration(hours: date.hour,minutes: date.minute,seconds: date.second,milliseconds: date.millisecond);
  }

  ///start player
  startAudioPlayer({
    required BuildContext context,
  }){
    ChatScreenState.audioPlayers.forEach((element) async{
       element.pause();
    });
    if(mounted){
      setState(() {
        played=true;
      });
    }
      ChatScreenState.audioPlayers[index!].play(source!).catchError((error){
        print("asd"+error.toString());
      });
      if(mounted){
        setState(() {
          played=false;
        });
      }

  }

  ///stop player
  stopAudioPlayer({
    required BuildContext context,
  })async{
    await ChatScreenState.audioPlayers[index!].stop().then((value){
      if(mounted){
        setState(() {
          played=false;
        });
      }

    });
  }

  ///resume player
  resumeAudioPlayer({
    required BuildContext context,
  })async{
    await ChatScreenState.audioPlayers[index!].resume().then((value){
      if(mounted){
        setState(() {
          played=true;
          paused=false;
        });
      }
    });
  }

  ///pause player
  pauseAudioPlayer({
    required BuildContext context,
  })async{
    await ChatScreenState.audioPlayers[index!].pause().then((value){
        if(mounted){
          setState(() {
            played=false;
            paused=true;
          });
        }
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    ChatScreenState.audioPlayers.forEach((element) {
      element.seek(Duration.zero);
      element.stop();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(mounted){
        paused=false;
        played=false;
    }
    super.dispose();
  }




}
