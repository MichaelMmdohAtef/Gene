import '../generated/l10n.dart';

class LanguageModel{
  String? imageCountry;
  String? nameCountry;
  String? langCountry;
  bool? check;
  LanguageModel({
    required this.imageCountry,
     this.nameCountry,
    required this.check,
    required this.langCountry,
  });
  static String getArabicLanguage(){
   return S.current.arabicLanguage;
  }
  static String getEnglishLanguage(){
    return S.current.englishLanguage;
  }
  static String getFrenchLanguage(){
    return S.current.frenchLanguage;
  }
}