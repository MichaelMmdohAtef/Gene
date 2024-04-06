import 'dart:async';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultSplashDialog extends StatefulWidget {
  String text;
  String? text2;
  VoidCallback? nextWidget;
  VoidCallback? closeFun;
  bool haveCloseButton=true;

  DefaultSplashDialog({required String this.text,String? this.text2,VoidCallback? this.nextWidget,VoidCallback? this.closeFun,this.haveCloseButton=false});

  @override
  State<DefaultSplashDialog> createState() => _DefaultSplashDialogState();
}

class _DefaultSplashDialogState extends State<DefaultSplashDialog> {

  int durationInSecond=5;
  Future? future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    future=Future.delayed(Duration(seconds: durationInSecond),widget.nextWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    durationInSecond=0;
    future!.timeout(Duration.zero,onTimeout: () {
      print("done animation");
    },);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      child: Container(
        width: screenWidth,
        height: MediaQuery.sizeOf(context).height * 0.3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: defaultBlackColor.withAlpha(16),
              offset: Offset(0, 0),
              blurStyle: BlurStyle.outer,
              blurRadius: 15,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: defaultWhiteColor,
        ),
        child: Stack(
          children: [

            Padding(
              padding: EdgeInsetsDirectional.only(
                top: screenHeight * 0.0961,
                end: screenWidth * 0.09,
                start: screenWidth * 0.09,
              ),
              child: Column(
                children: [
                  defaultText(
                    text: widget.text,
                    height: MediaQuery.sizeOf(context).height * 0.0440,
                    color: Colors.black,
                    alignment: AlignmentDirectional.center,
                    textAlign: TextAlign.center,
                    // boxFit: BoxFit.fill,
                    context: context,
                  ),
                  if(widget.text2!=null)
                    defaultText(
                      text: widget.text2!,
                      height: MediaQuery.sizeOf(context).height * 0.0340,
                      color: Colors.black,
                      alignment: AlignmentDirectional.center,
                      textAlign: TextAlign.center,
                      context: context,
                    ),
                  SizedBox(
                    height: screenHeight * 0.0377,
                  ),
                  Container(
                    height:screenHeight * 0.0626,
                    decoration: BoxDecoration(
                      color: Color(0xffFE3398),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: InkWell(
                      onTap:widget.nextWidget!=null?widget.nextWidget:(){
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          "Ok",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: defaultWhiteColor,
                            fontFamily: "Roboto",
                            height: 1.318,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
