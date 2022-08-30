// import 'dart:async';
// import 'dart:io';
// import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
// import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';
// import 'package:app_karada24/value/const_string.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:signalr_netcore/signalr_client.dart';
//
// import 'package:logging/logging.dart';
//
// typedef HubConnectionProvider = Future<HubConnection> Function();
//
// class ChatMessage {
//   // Properites
//
//   final String senderName;
//   final String message;
//
//   // Methods
//   ChatMessage(this.senderName, this.message);
// }
//
// class ChatPageViewModel {
// // Properties
//   String? _serverUrl;
//   HubConnection? hubConnection;
//   Logger? _logger;
//   StreamSubscription<LogRecord>? _logMessagesSub;
//
//   List<ChatMessage>? _chatMessages;
//   static const String chatMessagesPropName = "chatMessages";
//   List<ChatMessage>? get chatMessages => _chatMessages;
//
//   late bool _connectionIsOpen;
//   static const String connectionIsOpenPropName = "connectionIsOpen";
//   bool get connectionIsOpen => _connectionIsOpen;
//
//
//  late String _userName;
//   static const String userNamePropName = "userName";
//   String get userName => _userName;
//
//
// // Methods
//
//   ChatPageViewModel() {
//     _serverUrl = ConstString.serverUrlChat;
//     _chatMessages = [];
//     _connectionIsOpen = false;
//     _userName = "Fred";
//
//     Logger.root.level = Level.ALL;
//     _logMessagesSub = Logger.root.onRecord.listen(_handleLogMessage);
//     _logger = Logger("ChatPageViewModel");
//
//     openChatConnection();
//   }
//
//   @override
//   void dispose() {
//     _logMessagesSub?.cancel();
//   }
//
//   void _handleLogMessage(LogRecord msg) {
//     print(msg.message);
//   }
//
//   void _httpClientCreateCallback(Client httpClient) {
//     HttpOverrides.global = HttpOverrideCertificateVerificationInDev();
//   }
//
//   Future<void> openChatConnection() async {
//     final logger = _logger;
//
//     if (hubConnection == null) {
//       final httpConnectionOptions = new HttpConnectionOptions(
//           httpClient: WebSupportingHttpClient(logger,
//               httpClientCreateCallback: _httpClientCreateCallback),
//           logMessageContent: false);
//
//       hubConnection = HubConnectionBuilder()
//           .withUrl(_serverUrl!)
//           .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
//           .build();
//       hubConnection?.onclose(({error}) => print("hubConnection?.onclose"));
//       hubConnection?.onreconnecting(({error}) {
//         print("onreconnecting called");
//
//       });
//       hubConnection?.onreconnected(({connectionId}) {
//         print("onreconnected called");
//
//       });
//       hubConnection?.on("RecieveMsg", _handleIncommingChatMessage);
//     }
//
//     if (hubConnection?.state != HubConnectionState.Connected) {
//       await hubConnection?.start();
//
//     }
//   }
//
//   Future<void> sendChatMessage(String chatMessage) async {
//     if (chatMessage == null || chatMessage.length == 0) {
//       return;
//     }
//     await openChatConnection();
//     List<ModelRecivedMessage> message=[ModelRecivedMessage(senderId: Get.find<ControllerGetStorageAllData>().userId,recieverId: 19,content:chatMessage.toString().trim(),isNew: true,sendDate: DateTime.now(),isSenderDeleted: false,isRecieverDeleted: false,id: 0)];
//     hubConnection?.invoke("SendMessageToUser", args: message);
//   }
//
//   void _handleIncommingChatMessage(List<Object>? args) {
//     print(args);
//     // final String senderName = args![0].toString();
//     // final String message = args[1].toString();
//     // _chatMessages?.add(ChatMessage(senderName, message));
//     // notifyPropertyChanged(chatMessagesPropName);
//   }
// }
//
// // class ChatPageViewModelProvider extends ViewModelProvider<ChatPageViewModel> {
// //   // Properties
// //
// //   // Methods
// //   ChatPageViewModelProvider({required Key key, viewModel: ChatPageViewModel, required WidgetBuilder childBuilder})
// //       : super(key: key, viewModel: viewModel, childBuilder: childBuilder);
// //
// //   static ChatPageViewModel? of(BuildContext context) {
// //     return (context
// //         .dependOnInheritedWidgetOfExactType<ChatPageViewModelProvider>())
// //         ?.viewModel;
// //   }
// // }
//
// class HttpOverrideCertificateVerificationInDev extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }