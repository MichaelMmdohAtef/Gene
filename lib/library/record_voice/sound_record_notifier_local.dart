import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
// import 'package:uuid/uuid.dart';

class SoundRecordNotifierLocal extends ChangeNotifier {
  int _localCounterForMaxRecordTime = 0;
  GlobalKey key = GlobalKey();
  int? maxRecordTime;

  /// This Timer Just For wait about 1 second until starting record
  Timer? _timer;

  /// This time for counter wait about 1 send to increase counter
  Timer? _timerCounter;

  /// Use last to check where the last draggable in X
  double last = 0;

  /// Used when user enter the needed path
  String initialStorePathRecord = "";

  /// recording mp3 sound Object
  Record recordMp3 = Record();

  /// recording mp3 sound to check if all permisiion passed
  bool _isAcceptedPermission = false;

  /// used to update state when user draggable to the top state
  double currentButtonHeihtPlace = 0;

  /// used to know if isLocked recording make the object true
  /// else make the object isLocked false
  bool isLocked = false;

  /// when pressed in the recording mic button convert change state to true
  /// else still false
  bool isShow = false;

  /// to show second of recording
  late int second;

  /// to show minute of recording
  late int minute;
  late int millisecond;

  late DateTime startDate;
  late DateTime endDate;


  /// to know if pressed the button
  late bool buttonPressed;

  /// used to update space when dragg the button to left
  late double edge;
  late bool loopActive;

  /// store final path where user need store mp3 record
  late bool startRecord;

  /// store the value we draggble to the top
  late double heightPosition;

  /// store status of record if lock change to true else
  /// false
  late bool lockScreenRecord;
  late bool cancel=false;
  late String mPath;

  /// function called when start recording
  Function()? startRecording;
  Function(File soundFile, String time) sendRequestFunction;

  /// function called when stop recording, return the recording time (even if time < 1)
  Function(String time)? stopRecording;

  late AudioEncoderType encode;

  // ignore: sort_constructors_first

  SoundRecordNotifierLocal({
    required this.stopRecording,
    required this.cancel,
    required this.sendRequestFunction,
    required this.startRecording,
    this.edge = 0.0,
    this.minute = 0,
    this.second = 0,
    this.buttonPressed = false,
    this.loopActive = false,
    this.mPath = '',
    this.startRecord = false,
    this.heightPosition = 0,
    this.lockScreenRecord = false,
    this.encode = AudioEncoderType.AAC,
    this.maxRecordTime,
  });

  onCancelRequest(){
    this.cancel=!cancel;
    notifyListeners();
  }

  /// To increase counter after 1 sencond
  void _mapCounterGenerater() {
    startDate=DateTime.now();
    _timerCounter = Timer(Duration(seconds: 1), () {
      _increaseCounterWhilePressed();
      if (buttonPressed) _mapCounterGenerater();
    });
  }

  finishRecording() async{
    if (buttonPressed) {
      if (second > 2 || minute > 0) {
        // String path = mPath;
        String? path;
        endDate=DateTime.now();
        // Duration duration=Duration(minutes: (endDate.minute-startDate.minute),seconds: (endDate.second-startDate.second),milliseconds: (endDate.millisecond-startDate.millisecond));
        // DateTime duration=DateTime(0,0,0,0,(endDate.minute-startDate.minute),(endDate.second-startDate.second),(endDate.millisecond-startDate.millisecond));
        await recordMp3.stop().then((value){
          if(value!=null)
            path =value;
        });
        String _time = minute.toString() + ":" + second.toString();
        // String _time = duration.inMinutes.toString() + ":" + duration.inSeconds.toString()+ ":" + duration.inMilliseconds.toString();
        // String _time = duration.toString();
        sendRequestFunction(File(path!), _time);
        stopRecording!(_time);
      }
    }
    resetEdgePadding();
  }

  /// used to reset all value to initial value when end the record
  resetEdgePadding() async {
    _localCounterForMaxRecordTime = 0;
    isLocked = false;
    edge = 0;
    buttonPressed = false;
    second = 0;
    cancel=false;
    minute = 0;
    isShow = false;
    key = GlobalKey();
    heightPosition = 0;
    lockScreenRecord = false;
    if (_timer != null) _timer!.cancel();
    if (_timerCounter != null) _timerCounter!.cancel();
    recordMp3.stop();
    notifyListeners();
  }

  String _getSoundExtention() {
    if (encode == AudioEncoderType.AAC ||
        encode == AudioEncoderType.AAC_LD ||
        encode == AudioEncoderType.AAC_HE ||
        encode == AudioEncoderType.OPUS) {
      return ".m4a";
    } else {
      return ".3gp";
    }
  }

  /// used to get the current store path
  Future<String> getFilePath() async {
    String _sdPath = "";
    Directory tempDir = await getApplicationCacheDirectory();
    _sdPath =tempDir.path;
    // var d = Directory(_sdPath);
    // if (!d.exists()) {
    //   d.createSync(recursive: true);
    // }
    DateTime now = DateTime.now();
    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2, '0')}-${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}:${now.millisecond.toString().padLeft(4, '0')}";
    // print("the current data is $convertedDateTime");
    String storagePath =
        _sdPath + "/" + convertedDateTime + _getSoundExtention();
    File filePath=File(storagePath);
    if(await filePath.exists()){
      print("check");
      // mPath = storagePath;
      return storagePath;
    }else{
      print("create from");
      await filePath.create(recursive: true);
      print("from"+filePath.path);
      print("from"+storagePath);
      // mPath = storagePath;
      return storagePath;
    }
  }

  /// used to change the draggable to top value
  setNewInitialDraggableHeight(double newValue) {
    currentButtonHeihtPlace = newValue;
  }

  lockButton({required BuildContext context}){
    isLocked = true;
    lockScreenRecord = true;
    notifyListeners();
    String _time = minute.toString() + ":" + second.toString();
    if (stopRecording != null) stopRecording!(_time);
    resetEdgePadding();
    notifyListeners();
  }


  /// used to change the draggable to top value
  /// or To The X vertical
  /// and update this value in screen
  updateScrollValue(Offset currentValue, BuildContext context) async {
    if (buttonPressed == true) {
      final x = currentValue;

      /// take the diffrent between the origin and the current
      /// draggable to the top place
      double hightValue = currentButtonHeihtPlace - x.dy;

      /// if reached to the max draggable value in the top
      if (hightValue >= 50) {
        isLocked = true;
        lockScreenRecord = true;
        hightValue = 50;
        notifyListeners();
      }
      if (hightValue < 0) hightValue = 0;
      heightPosition = hightValue;
      lockScreenRecord = isLocked;
      notifyListeners();

      /// this operation for update X oriantation
      /// draggable to the left or right place
      try {
        RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);
        if (position.dx <= MediaQuery.of(context).size.width * 0.6) {
          String _time = minute.toString() + ":" + second.toString();
          if (stopRecording != null) stopRecording!(_time);
          resetEdgePadding();
        } else if (x.dx >= MediaQuery.of(context).size.width) {
          edge = 0;
          edge = 0;
        } else {
          if (x.dx <= MediaQuery.of(context).size.width * 0.5) {}
          if (last < x.dx) {
            edge = edge -= x.dx / 200;
            if (edge < 0) {
              edge = 0;
            }
          } else if (last > x.dx) {
            edge = edge += x.dx / 200;
          }
          last = x.dx;
        }
        // ignore: empty_catches
      } catch (e) {

      }
      notifyListeners();
    }
  }

  /// this function to manage counter value
  /// when reached to 60 sec
  /// reset the sec and increase the min by 1
  _increaseCounterWhilePressed() async {
    if (loopActive) {
      return;
    }

    loopActive = true;
    if (maxRecordTime != null) {
      if (_localCounterForMaxRecordTime >= maxRecordTime!) {
        loopActive = false;
        finishRecording();
      }
      _localCounterForMaxRecordTime++;
    }
    second = second + 1;
    buttonPressed = buttonPressed;
    if (second == 60) {
      second = 0;
      minute = minute + 1;
    }

    notifyListeners();
    loopActive = false;
    notifyListeners();
  }

  /// this function to start record voice
  record(Function()? startRecord) async {
    if (!_isAcceptedPermission) {
      await Permission.microphone.request();
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();
      _isAcceptedPermission = true;
    } else {
      try{
        print("aaaa");
        buttonPressed = true;
        String recordFilePath = await getFilePath();
        File filePath=File(recordFilePath);
        // _timer = Timer(const Duration(milliseconds: 900), () async{

         await recordMp3.start(
              // encoder: AudioEncoder.aacEld,
              path: filePath.path
         );
        // }
        // );

        _mapCounterGenerater();
        notifyListeners();
      }catch(error){
        print(error.toString());
      }
    }
    notifyListeners();
  }

  /// to check permission
  voidInitialSound() async {
    // if (Platform.isIOS) _isAcceptedPermission = true;

    startRecord = false;
    final status = await Permission.microphone.status;
    if (status.isGranted) {
      final result = await Permission.storage.request();
      if (result.isGranted) {
        _isAcceptedPermission = true;
      }
    }
  }
}
