import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnection{

  static getConnectivity()async{
    var result =await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.none){
      return false;
    }else{
      return true;
    }
  }

}