library social_media_recorder;

import 'package:Gene/library/record_voice/show_counter.dart';
import 'package:Gene/library/record_voice/sound_record_notifier_local.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SoundRecorderWhenLockedDesignLocal extends StatelessWidget {
  final double fullRecordPackageHeight;
  final SoundRecordNotifierLocal soundRecordNotifier;
  final String? cancelText;
  final Function sendRequestFunction;
  final Function(String time)? stopRecording;
  final Widget? recordIconWhenLockedRecord;
  final TextStyle? cancelTextStyle;
  final TextStyle? counterTextStyle;
  final Color recordIconWhenLockBackGroundColor;
  final Color? counterBackGroundColor;
  final Color? cancelTextBackGroundColor;
  final bool rtl;
  final Widget? sendButtonIcon;
  // ignore: sort_constructors_first
  const SoundRecorderWhenLockedDesignLocal({
    Key? key,
    required this.fullRecordPackageHeight,
    required this.sendButtonIcon,
    required this.soundRecordNotifier,
    required this.cancelText,
    required this.sendRequestFunction,
    required this.rtl,
    this.stopRecording,
    required this.recordIconWhenLockedRecord,
    required this.cancelTextStyle,
    required this.counterTextStyle,
    required this.recordIconWhenLockBackGroundColor,
    required this.counterBackGroundColor,
    required this.cancelTextBackGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:rtl? TextDirection.rtl:TextDirection.ltr,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: cancelTextBackGroundColor ?? Colors.grey,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: InkWell(
          onTap: () {
            soundRecordNotifier.isShow = false;
            soundRecordNotifier.resetEdgePadding();
          },
          child: Directionality(
            textDirection:rtl? TextDirection.rtl:TextDirection.ltr,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    soundRecordNotifier.isShow = false;
                    soundRecordNotifier.finishRecording();
                  },
                  child: Transform.scale(
                    scale: 1.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(600),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        width: fullRecordPackageHeight,
                        height: fullRecordPackageHeight,
                        child: Container(
                          color: recordIconWhenLockBackGroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: recordIconWhenLockedRecord ??
                                sendButtonIcon ??
                                Icon(
                                  Icons.send,
                                  textDirection: TextDirection.ltr,
                                  size: 28,
                                  color: (soundRecordNotifier.buttonPressed)
                                      ? Colors.grey.shade200
                                      : Colors.black,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                      onPressed: () {
                        soundRecordNotifier.isShow = false;
                        String _time = soundRecordNotifier.minute.toString() +
                            ":" +
                            soundRecordNotifier.second.toString();
                        if (stopRecording != null) stopRecording!(_time);
                        soundRecordNotifier.resetEdgePadding();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cancelText ?? "",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: cancelTextStyle ??
                              const TextStyle(
                                color: Colors.black,
                              ),
                        ),
                      )),
                ),
                ShowCounterLocal(
                  rtl: rtl,
                  soundRecorderState: soundRecordNotifier,
                  counterTextStyle: counterTextStyle,
                  counterBackGroundColor: counterBackGroundColor,
                  fullRecordPackageHeight: fullRecordPackageHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
