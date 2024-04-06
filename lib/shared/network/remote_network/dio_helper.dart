
import 'package:dio/dio.dart';
import 'package:Gene/shared/components/constants.dart';

class DioHelper{

 static Dio? dioHelper;

 ///initialize variable of dio helper with base options
 static initState(){
   dioHelper=Dio(BaseOptions(
      baseUrl:"https://clinic.megavisionagency.com/api/",
      receiveDataWhenStatusError: true,
      headers: {
        "Accept":"application/json",
        "Authorization":"Bearer $globalTokenApi"
      },
     validateStatus: (status) {
       if(status == null) {
         return false;
       } else if(status ==422){
         return true;
       }else return status>=200 && status <300;

     },
   ));
 }

 ///post data to apis without token
  static Future<Response> postDataWithoutBearer({
  String? url,
   Map<String,dynamic>? data,
  Map<String,dynamic>? query,
  }) async{
   dioHelper!.options.headers={
     "Accept":"application/json",
      };
    return await dioHelper!.post(url!,data:data,queryParameters:query);
  }


 ///post data to Website of SMS to Verify Phone Number
 static Future<Response> postDataWithPhoneNumber({
   String? url,
   Map<String,dynamic>? data,
   Map<String,dynamic>? query,
 }) async{
   Dio dio=Dio(BaseOptions(
     baseUrl: "https://smsmisr.com/api/",
   ));
   // dioHelper!.options.headers={
   //   "Accept":"application/json",
   // };
   return await dio.post(url!,data:data,queryParameters:query);
 }

  ///post data to apis with token
 static Future<Response> postDataWithBearer({
   String? url,
   Map<String,dynamic>? data,
   Map<String,dynamic>? query,
 }) async{
   dioHelper!.options.headers={
      "Authorization":"Bearer $userTokenApi",
   };
   return await dioHelper!.post(url!,data:data,queryParameters:query);
 }

 ///post form data to apis with token
 static Future<Response> postDataWithBearerWithImg({
   String? url,
   FormData? formData,
   Map<String,dynamic>? query,
 }) async{
   dioHelper!.options.headers={
     "Authorization":"Bearer $userTokenApi",
   };
   return await dioHelper!.post(url!,data:formData,queryParameters:query);
 }


 ///get data from apis with token
 static Future<Response> getDataWithBearer({String? url}) async{
   dioHelper!.options.headers={
     "Accept":"application/json",
       "Authorization":"Bearer ${userTokenApi ?? globalTokenApi}"
   };
   return await dioHelper!.get(url!);
 }

 ///get data from apis without token
 static Future<Response> getDataWithoutBearer({String? url}) async{
   dioHelper!.options.headers={
     "Accept":"application/json",
     };
   return await dioHelper!.get(url!);
 }

}