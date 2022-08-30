import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
 class ConnectionStatusSingleton  {

   bool ActiveConnection = false;
   String T = "";
   Future CheckUserConnection() async {
     try {
       final result = await InternetAddress.lookup('google.com');
       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
           ActiveConnection = true;
           T = "Turn off the data and repress again";
       }
     } on SocketException catch (_) {
         ActiveConnection = false;
     }
   }
   // static final ConnectionStatusSingleton _singleton =  ConnectionStatusSingleton._internal();
   // ConnectionStatusSingleton._internal();
   // static ConnectionStatusSingleton getInstance() => _singleton;
  // bool hasConnection = false;
   // StreamController connectionChangeController = StreamController.broadcast();
   // final Connectivity _connectivity = Connectivity();
   // void initialize() {
   //   _connectivity.onConnectivityChanged.listen(_connectionChange);
   //   checkConnection();
   // }
   // Stream get connectionChange => connectionChangeController.stream;
   // void dispose() {
   //   connectionChangeController.close();
   // }
   // void _connectionChange(ConnectivityResult result) {
   //   checkConnection();
   // }
   // Future<bool> checkConnection() async {
   //
   //   try {
   //     final result = await InternetAddress.lookup('www.google.com');
   //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
   //       hasConnection = true;
   //     } else {
   //       hasConnection = false;
   //     }
   //   } on SocketException catch(_) {
   //     hasConnection = false;
   //   }
   //
   //   return hasConnection;
   // }

 }