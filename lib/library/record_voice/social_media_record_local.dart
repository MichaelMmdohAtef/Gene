library social_media_recorder;

import 'dart:io';
import 'package:Gene/library/record_voice/show_counter.dart';
import 'package:Gene/library/record_voice/show_mic_with_text_local.dart';
import 'package:Gene/library/record_voice/sound_record_notifier_local.dart';
import 'package:Gene/library/record_voice/sound_recorder_when_locked_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';


class SocialMediaRecorderLocal extends StatefulWidget {
  /// use it for change back ground of cancel
  final Color? cancelTextBackGroundColor;

  /// function return the recording sound file and the time
  final Function(File soundFile, String time) sendRequestFunction;

  /// function called when start recording
  final Function()? startRecording;

  /// function called when stop recording, return the recording time (even if time < 1)
  final Function(String time)? stopRecording;

  /// recording Icon That pressesd to start record
  final Widget? recordIcon;

  /// recording Icon when user locked the record
  final Widget? recordIconWhenLockedRecord;

  /// use to change the backGround Icon when user recording sound
  final Color? recordIconBackGroundColor;

  /// use to change the Icon backGround color when user locked the record
  final Color? recordIconWhenLockBackGroundColor;

  /// use to change all recording widget color
  final Color? backGroundColor;

  /// use to change the counter style
  final TextStyle? counterTextStyle;

  /// text to know user should drag in the left to cancel record
  final String? slideToCancelText;

  /// use to change slide to cancel textstyle
  final TextStyle? slideToCancelTextStyle;

  /// this text show when lock record and to tell user should press in this text to cancel recod
  final String? cancelText;

  /// use to change cancel text style
  final TextStyle? cancelTextStyle;

  /// put you file directory storage path if you didn't pass it take deafult path
  final String? storeSoundRecoringPath;

  /// Chose the encode type
  final AudioEncoderType encode;

  /// use if you want change the raduis of un record
  final BorderRadius? radius;

  // use to change the counter back ground color
  final Color? counterBackGroundColor;

  // use to change lock icon to design you need it
  final Widget? lockButton;

  // use it to change send button when user lock the record
  final Widget? sendButtonIcon;

  // this function called when cancel record function

  // use to set max record time in second
  final int? maxRecordTimeInSecond;

  // use to change full package Height
  final double fullRecordPackageHeight;

  final double initRecordPackageWidth;
  final bool rtl;

  // ignore: sort_constructors_first
  const SocialMediaRecorderLocal({
    this.sendButtonIcon,
    this.initRecordPackageWidth = 40,
    this.fullRecordPackageHeight = 50,
    this.maxRecordTimeInSecond,
    this.storeSoundRecoringPath = "",
    required this.sendRequestFunction,
    this.startRecording,
    this.stopRecording,
    this.recordIcon,
    this.lockButton,
    this.counterBackGroundColor,
    this.recordIconWhenLockedRecord,
    this.recordIconBackGroundColor = Colors.blue,
    this.recordIconWhenLockBackGroundColor = Colors.blue,
    this.backGroundColor,
    this.cancelTextStyle,
    this.counterTextStyle,
    this.slideToCancelTextStyle,
    this.rtl=false,
    this.slideToCancelText = " Slide to Cancel >",
    this.cancelText = "Cancel",
    this.encode = AudioEncoderType.AAC,
    this.cancelTextBackGroundColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  _SocialMediaRecorder createState() => _SocialMediaRecorder();
}

class _SocialMediaRecorder extends State<SocialMediaRecorderLocal> {
  late SoundRecordNotifierLocal soundRecordNotifierLocal;

  @override
  void initState() {
    soundRecordNotifierLocal = SoundRecordNotifierLocal(
      cancel: false,
      maxRecordTime: widget.maxRecordTimeInSecond,
      startRecording: widget.startRecording ?? () {},
      stopRecording: widget.stopRecording ?? (String x) {},
      sendRequestFunction: widget.sendRequestFunction,
    );

    soundRecordNotifierLocal.initialStorePathRecord =
        widget.storeSoundRecoringPath ?? "";
    soundRecordNotifierLocal.isShow = false;
    soundRecordNotifierLocal.voidInitialSound();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    soundRecordNotifierLocal.maxRecordTime = widget.maxRecordTimeInSecond;
    soundRecordNotifierLocal.startRecording = widget.startRecording ?? () {};
    soundRecordNotifierLocal.stopRecording = widget.stopRecording ?? (String x) {};
    soundRecordNotifierLocal.sendRequestFunction = widget.sendRequestFunction;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => soundRecordNotifierLocal),
        ],
        child: Consumer<SoundRecordNotifierLocal>(
          builder: (context, value, _) {
            return Directionality(
                textDirection:widget.rtl? TextDirection.rtl:TextDirection.ltr,
                child: makeBody(value));
          },
        ));
  }

  Widget makeBody(SoundRecordNotifierLocal state) {

    return Directionality(
      textDirection:widget.rtl? TextDirection.rtl:TextDirection.ltr,
      child: Builder(
        builder: (context) {
          if(mounted){
            if(state.cancel){
              state.onCancelRequest();
            }
          }
          return Column(
            children: [
              GestureDetector(
                onHorizontalDragUpdate: (scrollEnd) {
                   state.updateScrollValue(scrollEnd.globalPosition, context);
                },
                onHorizontalDragStart: (x) {
                  print("start");
                  if(mounted){
                    if(!state.cancel){
                      state.onCancelRequest();
                    }
                  }
                    state.resetEdgePadding();
                  // if (state.buttonPressed && !state.isLocked) state.finishRecording();
                },
                onHorizontalDragEnd: (x) {
                  print("end");
                  // if(widget.rtl)
                  if(mounted){
                    if(!state.cancel){
                      state.onCancelRequest();
                    }
                  }
                    state.resetEdgePadding();
                  // if (state.buttonPressed && !state.isLocked) state.finishRecording();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: recordVoice(state),
                ),
              )
            ],
          );
        }
      ),
    );
  }

  Widget recordVoice(SoundRecordNotifierLocal state) {
    if (state.lockScreenRecord == true) {
      return Directionality(
        textDirection:widget.rtl? TextDirection.rtl:TextDirection.ltr,
        child: SoundRecorderWhenLockedDesignLocal(
          rtl: widget.rtl,
          cancelText: widget.cancelText,
          fullRecordPackageHeight: widget.fullRecordPackageHeight,
          // cancelRecordFunction: widget.cacnelRecording ?? () {},
          sendButtonIcon: widget.sendButtonIcon,
          cancelTextBackGroundColor: widget.cancelTextBackGroundColor,
          cancelTextStyle: widget.cancelTextStyle,
          counterBackGroundColor: widget.counterBackGroundColor,
          recordIconWhenLockBackGroundColor:
          widget.recordIconWhenLockBackGroundColor ?? Colors.blue,
          counterTextStyle: widget.counterTextStyle,
          recordIconWhenLockedRecord: widget.recordIconWhenLockedRecord,
          sendRequestFunction: widget.sendRequestFunction,
          soundRecordNotifier: state,
          stopRecording: widget.stopRecording,
        ),
      );
    }

    return Listener(
      onPointerDown: (details) async {
        state.setNewInitialDraggableHeight(details.position.dy);
        state.resetEdgePadding();
        soundRecordNotifierLocal.isShow = true;
        state.record(widget.startRecording);
      },
      onPointerUp: (details) async {
        if (!state.isLocked && state.cancel==false) {
          state.finishRecording();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: soundRecordNotifierLocal.isShow ? 0 : 300),
        height: widget.fullRecordPackageHeight,
        width: (soundRecordNotifierLocal.isShow)
            ? MediaQuery.of(context).size.width
            : widget.initRecordPackageWidth,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: state.edge),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: soundRecordNotifierLocal.isShow
                        ? BorderRadius.circular(12)
                        : widget.radius != null && !soundRecordNotifierLocal.isShow
                        ? widget.radius
                        : BorderRadius.circular(0),
                    color: widget.backGroundColor ?? Colors.grey.shade100,
                  ),
                  child: Stack(
                    children: [
                        ShowMicWithTextLocal(
                          initRecordPackageWidth: widget.initRecordPackageWidth,
                          counterBackGroundColor: widget.counterBackGroundColor,
                          backGroundColor: widget.recordIconBackGroundColor,
                          fullRecordPackageHeight:
                          widget.fullRecordPackageHeight,
                          recordIcon: widget.recordIcon,
                          shouldShowText: soundRecordNotifierLocal.isShow,
                          soundRecorderState: state,
                          slideToCancelTextStyle: widget.slideToCancelTextStyle,
                          slideToCancelText: widget.slideToCancelText,
                        ),
                      if (soundRecordNotifierLocal.isShow)
                        ShowCounterLocal(
                          rtl: widget.rtl,
                            counterBackGroundColor:
                            widget.counterBackGroundColor,
                            soundRecorderState: state,
                            fullRecordPackageHeight:
                            widget.fullRecordPackageHeight),
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 60,
            //   child: LockRecordLocal(
            //     soundRecorderState: state,
            //     lockIcon: widget.lockButton,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
