

import 'package:signalr_netcore/hub_connection.dart';

class ConstString{
  //urlAPI
  static const baseUrlServer="https://crm.phx.ir/";
  static const String serverUrlChat="https://crm.phx.ir/chathub";
  static const baseUrlLocalMessage="http://192.168.1.102:8082/";

  static const String urlSrvUserInfo="http://192.168.1.102:8082/api/";//GetAppUserInfo?userId=1019;
  static const String urlSrvAccount="http://192.168.1.102:8082/api/";
  static const String urlSrvRegistering="http://192.168.1.102:8082/api/";
  static const String urlSrvTickets="http://192.168.1.102:8083/api/Ticket";
  static const String urlSrvTicket="http://192.168.1.102:8083/api/";

  static const String urlSrvProduct="${baseUrlServer}srvproduct/api/";
 // static const String urlSrvTicket="${baseUrlServer}srvticket/api/";
 // static const String urlSrvTickets="${baseUrlServer}srvticket/api/";
  static const String urlSrvUpload="${baseUrlServer}srvupload/api/";
 // static const String urlSrvAccount="${baseUrlServer}srvaccount/api/";
  static const String urlSrvAllHelp="${baseUrlServer}srvproduct/api/";
 // static const String urlSrvUserInfo="${baseUrlServer}srvaccount/api/";//GetAppUserInfo?userId=1019;
//  static const String urlSrvRegistering= '${baseUrlServer}srvaccount/api/';

  static const String urlSrvAccountChatLocal= 'http://192.168.1.102:8082/api/';
  //static const String urlSrvAccountMessage= '${baseUrlServer}srvaccount/api/';


}