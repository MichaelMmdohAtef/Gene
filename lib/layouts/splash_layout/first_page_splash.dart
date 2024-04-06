
import 'package:Gene/layouts/splash_layout/check_internet_screen.dart';
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';

// ignore: must_be_immutable
class FirstSplashScreen extends StatefulWidget {
  FirstSplashScreen({required this.widget});
  Widget widget;

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {

  bool hasInternet=true;

  getConnectionResult()async{
    hasInternet=await NetworkConnection.getConnectivity();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectionResult();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: statusBar(),
          body:FlutterSplashScreen.gif(
            useImmersiveMode: true,
            gifPath:languageApp!="ar"?imageFirstSplashScreenEN:imageFirstSplashScreenAR,
            gifWidth: MediaQuery.sizeOf(context).width * 0.8,
            gifHeight: MediaQuery.sizeOf(context).height * 0.8,
            duration: Duration(seconds: 3),
            backgroundColor: defaultBlueDarkColor,
            nextScreen:hasInternet?widget.widget:CheckInternetScreen(),
          ),
        );
      }
    );
  }
}

