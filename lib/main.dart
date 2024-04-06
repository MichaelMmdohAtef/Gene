import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/layouts/splash_layout/cubit/cubit.dart';
import 'package:Gene/layouts/splash_layout/first_page_splash.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:Gene/shared/network/cache_memory/shared_preferences.dart';
import 'package:Gene/shared/network/remote_network/dio_helper.dart';
import 'generated/l10n.dart';
import 'package:Gene/layouts/home_layout/home_screen.dart';
import 'package:Gene/layouts/splash_layout/splash_screen.dart';




void main() async{

  ///initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = PostHttpOverrides();
  await DioHelper.initState();
  await CashHelper.init();

  ///get data from local memory
  bool? splashApp=await CashHelper.getData(key: splashKey);
  isSplashedValue=splashApp!=null?isSplashedValue=splashApp:
  isSplashedValue=false;

  String? token=await CashHelper.getData(key: USER_TOKEN_API);
  userTokenApi=token!=null?userTokenApi=token:
  userTokenApi=null;

  String? countryAppLocal=await CashHelper.getData(key: COUNTRY_KEY);
  countryApp=countryAppLocal!=null?countryApp=countryAppLocal:
  countryApp="65";

  String? countryWithPhone=await CashHelper.getData(key: COUNTRY_Of_Phone);
  countryPhoneNumber=countryWithPhone??"65";


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    /// Phoenix to reload app
      Phoenix(
      child: MyApp()
      ),
  );

}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}




class MyApp extends StatelessWidget {

  MyApp({super.key});

  ///get language from local data fun
  Future _getLanguage() async {
    ///default language is Arabic
    String? languageAppLocal = await CashHelper.getData(key: Lang_Key);
    languageAppLocal != null ? languageApp = languageAppLocal :
    languageApp = "ar";
  }

  @override
  Widget build(BuildContext context) {

    ///create multi providers
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
        HomeCubit()
          ..getMedicalAllergies()
          ..getMedicalVaccinations()
          ..getMedicalRegularly()
          ..getTypesOfTickets()
        ),
        BlocProvider(create: (context) => SplashCubit(),),
        BlocProvider(create: (context) => SignInCubit(),),
      ],
      child: Builder(
          builder: (context) {

            ///get data of user
            getDataOfUser(context: context);

            ///consume on home cubit on update values
            return BlocConsumer<HomeCubit, HomeStates>(
              builder: (context, state) {
                var cubit = HomeCubit.get(context);
                return MaterialApp(
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    MonthYearPickerLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  ///locale language of app
                  locale: Locale.fromSubtags(languageCode: cubit.localLanguage),
                  title: 'GENE',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.deepPurple,
                      ),
                      useMaterial3: true,
                      appBarTheme: const AppBarTheme(
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarIconBrightness: Brightness.light,
                          statusBarColor: Colors.black,
                        ),
                        scrolledUnderElevation: 0,
                      )
                  ),
                  home:FirstSplashScreen(widget: defineWidget()),
                );
              },
              listener: (context, state) {


              },

            );
          }
      ),
    );
  }

  /// get data of user when reload app
  getDataOfUser({
    required BuildContext context,
  }) async {
    ///get language sequentially with localization
    HomeCubit.get(context).onChangeLanguage(lang: languageApp!,);
    await _getLanguage().then((value) async{
      ///get language from local data
      HomeCubit.get(context).onChangeLanguage(lang: languageApp!,);
      HomeCubit.get(context).onChangeLanguageCheckbox(lang: languageApp);
    });
    ///get country
    await getCountryFromCountryApi(idOfCountryFromAPI: int.parse(countryApp), context: context);

    ///get Country With PhoneNumber
    HomeCubit.get(context).onChangeCountriesOfPhoneCheckbox(lang: countryPhoneNumber,);

    ///get States
    await SignInCubit.get(context).getStatesOfCountries(int.parse(countryApp));

    ///get data of user on reload app
    if (userTokenApi != null && SignInCubit.get(context).loginDataModel==null) {
      await SignInCubit.get(context).refreshData(context: context);
    }else if(HomeCubit.get(context).clinics.isEmpty){
      await HomeCubit.get(context).getClinicsData();
    }
  }



  ///predict first screen
  Widget defineWidget() {
      if (userTokenApi != null) {
        return HomeScreen();
      } else if (isSplashedValue != true) {
        return SplashScreen();
      } else {
        return SplashScreen();
        //WelcomePage()
      }
  }

}


///compare country id in api with list of countries and get language
///initialize checkbox of country in local list of countries
getCountryFromCountryApi({
  required int idOfCountryFromAPI,
  required BuildContext context,
})async{
  if( SignInCubit.get(context).allCountries.isNotEmpty){
    for (int i = 0; i < SignInCubit.get(context).allCountries.length; i++) {
      if (idOfCountryFromAPI == SignInCubit.get(context).allCountries[i].id) {
        HomeCubit.get(context).onChangeCountriesCheckbox(
          lang: SignInCubit.get(context).allCountries[i].name,
        );
      }
    }
    print("a");
  }else{
    await SignInCubit.get(context).getCountries().then((value){
      for (int i = 0; i < SignInCubit.get(context).allCountries.length; i++) {
        if (idOfCountryFromAPI == SignInCubit.get(context).allCountries[i].id) {
          HomeCubit.get(context).onChangeCountriesCheckbox(
              lang: SignInCubit.get(context).allCountries[i].name
          );
        }
      }
      print("b");
    });
  }
}