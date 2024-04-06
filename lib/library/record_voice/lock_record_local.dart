library social_media_recorder;

import 'package:Gene/library/record_voice/sound_record_notifier_local.dart';
import 'package:flutter/material.dart';

/// This Class Represent Icons To swap top to lock recording
class LockRecordLocal extends StatefulWidget {
  /// Object From Provider Notifier
  final SoundRecordNotifierLocal soundRecorderState;
  // ignore: sort_constructors_first

  final Widget? lockIcon;
  const LockRecordLocal({
    this.lockIcon,
    required this.soundRecorderState,
    Key? key,
  }) : super(key: key);
  @override
  _LockRecordLocalState createState() => _LockRecordLocalState();
}

class _LockRecordLocalState extends State<LockRecordLocal> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    /// If click the Button Then send show lock and un lock icon
    if (!widget.soundRecorderState.buttonPressed) return Container();
    return AnimatedPadding(
      duration: const Duration(seconds: 1),
      padding:
      EdgeInsets.all(widget.soundRecorderState.second % 2 == 0 ? 0 : 8),
      child: Transform.translate(
        offset: const Offset(0, -70),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            opacity: widget.soundRecorderState.edge >= 50 ? 0 : 1,
            child: Container(
              height: 50 - widget.soundRecorderState.heightPosition < 0
                  ? 0
                  : 50 - widget.soundRecorderState.heightPosition,
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.lockIcon ??
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              opacity: widget.soundRecorderState.second % 2 != 0
                                  ? 0
                                  : 1,
                              child: const Icon(Icons.lock_outline_rounded)),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              opacity: widget.soundRecorderState.second % 2 == 0
                                  ? 0
                                  : 1,
                              child: const Icon(Icons.lock_open_rounded)),
                        ),
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
