import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/splash_layout/cubit/states.dart';
import 'package:Gene/models/Splash_Model.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:Gene/shared/network/cache_memory/shared_preferences.dart';
import '../../../generated/l10n.dart';

class SplashCubit extends Cubit<SplashState>{

  SplashCubit():super(SplashInitState());

  static SplashCubit get(context)=>BlocProvider.of(context);
  int indexOfSplash=0;

  ///screens of splash screen
  List<SplashModel> screens=[
    SplashModel(urlImage: "assets/Background/Splash_Screen.png", text: S.current.splashText),
    SplashModel(urlImage: "assets/Background/default_background.png",
        text: S.current.splashText),
    SplashModel(urlImage: "assets/Background/default_background.png",
        text: S.current.splashText),
  ];

  ///variable that control with the screen view
  onchangeIndex({required int index,required BuildContext context}){
    indexOfSplash=index;
    emit(OnChangeSplashIndex());
  }
  ///on skip splash screen
  navigateOnBoarding({
    required BuildContext context,
    required Widget screen,
  })async{
    indexOfSplash=0;
    await CashHelper.setBoolean(key:splashKey, value: true);
   return navigateAndFinish(context,screen);
  }

}