import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityProvider with ChangeNotifier {
  Connectivity connectivity = new Connectivity();

  bool _isOnline;
  bool get isOnline => _isOnline;
  startListening() async {
    await initializeConnectivity();
    connectivity.onConnectivityChanged.listen((event)async{
      if(event==ConnectivityResult.none){
        _isOnline=false;
        notifyListeners();
      }else{
        await updateCennectionStatus().then((bool isConnected)  {
          _isOnline=isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initializeConnectivity() async {
    try {
      var status = await connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print("plateformException:" + e.message);
    }
  }

  Future<bool>updateCennectionStatus()async{
    bool isConnected;
    try{
     final List<InternetAddress> resultcheck=await InternetAddress.lookup('google.com') ;
     if(resultcheck.isNotEmpty && resultcheck[0].rawAddress.isNotEmpty){
       isConnected=true;

     }
    }on SocketException catch(_){
      isConnected=false;
    }
    return isConnected;
  }
}
