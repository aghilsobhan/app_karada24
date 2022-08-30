// // import 'package:get/get.dart';
// // import 'package:signalr_netcore/hub_connection.dart';
// // import 'package:signalr_netcore/hub_connection_builder.dart';
// //
// // import '../../value/const_string.dart';
// //
// // class HubConnectionChat extends GetxController{
// //   HubConnection hubConnection = HubConnectionBuilder().withUrl(ConstString.serverUrlChat)
// //       .withAutomaticReconnect(retryDelays: [200,400])
// //       .build();
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     openChatConnection();
// //   }
// //
// //   Future<void> openChatConnection() async {
// //     //  final logger = _logger;
// //     try{
// //       if(hubConnection!=null||hubConnection.state==HubConnection.){
// //         print(hubConnection.state);
// //         print(hubConnection.connectionId);
// //
// //         hubConnection.start()!.then((value) {
// //           hubConnection.invoke("UsersOnConnect", args: <Object>[40,"demo","demo"]).then((value) {
// //            update();
// //           });
// //
// //
// //         });
// //         // hubConnection
// //       }
// //       else{
// //         hubConnection = await HubConnectionBuilder().withUrl(ConstString.serverUrlChat)
// //             .withAutomaticReconnect(retryDelays: [200,400])
// //             .build();
// //       }
// //
// //     }catch(e){
// //       print(e);
// //     }
// //
// //
// //
// //   }
// // }
// class ChatPageViewModel extends ViewModel {
// // Properties
//   String _serverUrl;
//   HubConnection hubConnection;
//   Logger _logger;
//   StreamSubscription<LogRecord> _logMessagesSub;
//
//   List<ChatMessage> _chatMessages;
//   static const String chatMessagesPropName = "chatMessages";
//   List<ChatMessage> get chatMessages => _chatMessages;
//
//   bool _connectionIsOpen;
//   static const String connectionIsOpenPropName = "connectionIsOpen";
//   bool get connectionIsOpen => _connectionIsOpen;
//   set connectionIsOpen(bool value) {
//     updateValue(connectionIsOpenPropName, _connectionIsOpen, value,
//             (v) => _connectionIsOpen = v);
//   }
//
//   String _userName;
//   static const String userNamePropName = "userName";
//   String get userName => _userName;
//   set userName(String value) {
//     updateValue(userNamePropName, _userName, value, (v) => _userName = v);
//   }
//
// // Methods
//
//   ChatPageViewModel() {
//     _serverUrl = kChatServerUrl + "/Chat";
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
//     super.dispose();
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
//           logger: logger,
//           logMessageContent: true);
//
//       hubConnection = HubConnectionBuilder()
//           .withUrl(_serverUrl, options: httpConnectionOptions)
//           .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000, null])
//           .configureLogging(logger)
//           .build();
//       hubConnection.onclose(({error}) => connectionIsOpen = false);
//       hubConnection.onreconnecting(({error}) {
//         print("onreconnecting called");
//         connectionIsOpen = false;
//       });
//       hubConnection.onreconnected(({connectionId}) {
//         print("onreconnected called");
//         connectionIsOpen = true;
//       });
//       hubConnection.on("OnMessage", _handleIncommingChatMessage);
//     }
//
//     if (hubConnection.state != HubConnectionState.Connected) {
//       await hubConnection.start();
//       connectionIsOpen = true;
//     }
//   }
//
//   Future<void> sendChatMessage(String chatMessage) async {
//     if (chatMessage == null || chatMessage.length == 0) {
//       return;
//     }
//     await openChatConnection();
//     hubConnection.invoke("Send", args: <Object>[userName, chatMessage]);
//   }
//
//   void _handleIncommingChatMessage(List<Object> args) {
//     final String senderName = args[0];
//     final String message = args[1];
//     _chatMessages.add(ChatMessage(senderName, message));
//     notifyPropertyChanged(chatMessagesPropName);
//   }
// }
//
// class ChatPageViewModelProvider extends ViewModelProvider<ChatPageViewModel> {
//   // Properties
//
//   // Methods
//   ChatPageViewModelProvider(
//       {Key key, viewModel: ChatPageViewModel, WidgetBuilder childBuilder})
//       : super(key: key, viewModel: viewModel, childBuilder: childBuilder);
//
//   static ChatPageViewModel of(BuildContext context) {
//     return (context
//         .dependOnInheritedWidgetOfExactType<ChatPageViewModelProvider>())
//         .viewModel;
//   }
// }
//
// class HttpOverrideCertificateVerificationInDev extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }