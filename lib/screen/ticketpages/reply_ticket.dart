import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/apiService/api_service_all_reply.dart';
import 'package:app_karada24/apiService/api_service_upload_image.dart';
import 'package:app_karada24/getxController/list_ticket.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/models/model_add_reply.dart';
import 'package:app_karada24/models/model_upload_file.dart';
import 'package:app_karada24/response/response_reply_all.dart';
import 'package:app_karada24/screen/ticketpages/details_reply_ticket.dart';
import 'package:app_karada24/screen/ticketpages/send_message.dart';
import 'package:app_karada24/screen/ticketpages/ticket_page.dart';
import 'package:app_karada24/utility/description_reply_ticket.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../getxController/storagedata/StrorageAllData.dart';
import '../../widgets/show_toast.dart';

class ReplyTicket extends StatefulWidget {
  final int tckId;
  final int? userRoleId;
  final String? token;
  final String? statTittle;
  final String? tittleTicket;
  final String? bodyTicket;
  final DateTime dataTicket;
  final   int? tckStatId;
  final   int? tckPriorityId;
  final   String? prioTittle;
  const ReplyTicket(this.tckId, this.userRoleId, this.token, this.statTittle,
      this.tittleTicket, this.dataTicket,
      {Key? key, this.bodyTicket, this.tckStatId, this.tckPriorityId, this.prioTittle})
      : super(key: key);

  @override
  _ReplyTicketState createState() => _ReplyTicketState();
}

class _ReplyTicketState extends State<ReplyTicket> {
  late ModelSendReply modelSendReply;
  late Future<void> fListTicketsReply;
  List<TicketReply> listTicketsReply = <TicketReply>[];
  List<TicketReply> supportListReply = <TicketReply>[];
  List<TicketReply> userListReply = <TicketReply>[];
  //final ScrollController _scrollController = ScrollController();
  Future<bool> close(BuildContext context)async
  {
    Navigator.pop(context);
    Get.find<GetListTicketing>().fetchListTicketing(widget.userRoleId!, widget.token!);

return true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
    return close (context);
        },
      child: Scaffold(
        backgroundColor: Palette.backGroundColorD,
        body: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.topRight,
                  child: DescriptionSelectDropListTct(
                      widget.tittleTicket, widget.dataTicket, widget.tckId,bodyTicket: widget.bodyTicket,prioTittle:widget.prioTittle ,tckPriorityId:widget.tckPriorityId ,tckStatId: widget.tckStatId ,)),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: fListTicketsReply,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 0.8,),
                      );
                    }else if (snapshot.hasError){
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }else{
                     return listMessages();
                    }
                  }),
            ],
          ),
        ),
        floatingActionButton:widget.statTittle!.contains("بسته")? null:FloatingActionButton.extended(
          extendedTextStyle: TextStyle(fontFamily: "sansn",fontWeight: FontWeight.bold,fontSize: 12),
          onPressed: () {
            Navigator.push(this.context, MaterialPageRoute(builder: (context) {
              return SendMessage(widget.userRoleId, widget.token,widget.tckId,callback,widget.statTittle,widget.tittleTicket,widget.dataTicket);
            }));
          },
          label: const Text(
            'پیام جدید',
          ),
          icon: const Icon(Icons.note_add,size: 15,),
          backgroundColor: Palette.secondColorDark,
        ),
        appBar: AppBar(

          backgroundColor: Palette.bottomNavUnBack,
          toolbarHeight: 40.0,
          leadingWidth: 40,// double
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.all(6),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Get.find<GetListTicketing>().fetchListTicketing(widget.userRoleId!, widget.token!);
              },
              child: Container(
                width:30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25)),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 6),
                child: Align(alignment: Alignment.center,
                    child: Text("اعلانها",
                      style: TextStyle(color: Colors.black,
                          fontFamily: "sans",
                          fontWeight: FontWeight.bold),
                    )
                )
            )
          ],
        ),
      ),
    );

  }

  Future<void> showDialogSelectedFile(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("گالری"),
                    onTap: () {
                      getFile();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Text("فایل"),
                    onTap: () {
                      getFile();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // _showGallery() async{
  //   var picture=await ImagePicker().pickImage(source: ImageSource.gallery);
  //   print("result is:$picture");
  //   setState(() {
  //     _file=picture;
  //   });
  // }
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    Navigator.of(this.context).pop();
    final file = result!.files.first;

    if (result == null) {
      return null;
    } else {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          context: this.context,
          backgroundColor: Colors.black54,
          builder: (BuildContext context) {
            return Column(
              children: [
                Center(
                  child: Image.file(
                    File(file.path as String),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 70,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                    GestureDetector(
                      onTap: () {
                        final bytes =
                            File(file.path as String).readAsBytesSync();
                        String _img64 = base64Encode(bytes);

                        ModelUploadFile modelUploadFile = ModelUploadFile(
                            fileName: file.name,
                            fileContent: _img64,
                            fileTypeId: 2,
                            ownerId: widget.tckId,
                            ownerName: "reply",
                            serviceName: 'ticketing',
                            userId: widget.userRoleId as int,
                            userTypeId: 2);
                        _uploadFile(modelUploadFile);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent, shape: BoxShape.circle),
                        child: const InkWell(
                          child: Icon(
                            Icons.send,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            );
          });
    }
// OpenFile.open(file.path!);
  }

  void _uploadFile(filePath) async {
    ApiServiceUploadFile apiService = ApiServiceUploadFile();
    apiService.number(filePath, widget.token).then((value) {
      if (value == 200) {

        Navigator.of(this.context).pop();
      } else {
        SnackError(context,"error is");
      }
    });
  }

  Widget supportMessage(TicketReply ticketReply) {
    return Stack(
      children: [
        SizedBox(width: 6,),
        ticketReply.repOwnerType==1?
        Icon(Icons.ac_unit,size: 15,color: Colors.blue,):
        Icon(Icons.check_circle,size: 15,color: Colors.green,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 6,),
            CircleAvatar(

              radius: 14.0,
              backgroundColor: Palette.backGroundColorD,
              child: ClipRRect(
                  child: Image.asset('images/pngwing.png'),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            SizedBox(width: 6,),
            GestureDetector(
              onTap: () {
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) {
                      return DetailsReplyTicket(ticketReply.repContent,ticketReply.repId,ticketReply.repRegDate,widget.token as String,);
                    }));
              },
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 0.2)),
                        child:  Text(
                         ticketReply.repContent.trim(),
                          maxLines: 2,
                          style:const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'sans',
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),

                ),
              ),
            ),
            ticketReply.repHasFile? Container(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child:
                  Padding(padding: EdgeInsets.only(left: 4),child: Icon(Icons.file_present,size: 15,color: Palette.iconSnack,))
              ),
            ):Text("")
          ],
        ),
           ],
    );
  }

  Widget userMessage(TicketReply ticketReply) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ticketReply.repHasFile? Container(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child:
                  Padding(padding: EdgeInsets.only(left: 4),child: Icon(Icons.file_present,size: 15,color: Palette.iconSnack,))
              ),
            ):Text(""),
            GestureDetector(
              onTap: () {
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) {
                  return DetailsReplyTicket(ticketReply.repContent,ticketReply.repId,ticketReply.repRegDate,widget.token as String);
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 10),
                child:
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 280,
                        decoration: BoxDecoration(
                            color: Palette.primaryColorD,
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.white, width: 0.4)),
                        child: Text(
                          ticketReply.repContent.trim(),
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'sans',
                            overflow: TextOverflow.fade,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                )

              ),
            ),
            const CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage(
                'images/profile.png',
              ),
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ],
    );

  }



  Widget listMessages() {
    if (listTicketsReply.isEmpty) {
      return Center(
        child: Column(
          children: [
            Image.asset(
              "images/giphy.gif",
              height: 150,
            ),
            SizedBox(height: 25,),
            const Text(
              "شما هیچ پیامی ندارید ",
              style: TextStyle(fontFamily: "sans", fontSize: 14,),
            ),

          ],
        ),
      );
    } else {
      return ListView.builder(

        itemCount: listTicketsReply.length,
        reverse: false,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            child: Align(
              child: (listTicketsReply[index].repOwnerType == 2||listTicketsReply[index].repOwnerType == 1
                  ? supportMessage(listTicketsReply[index])
                  : userMessage(listTicketsReply[index])),
            ),
          );
        },
      );
    }
  }

  void SnackError(BuildContext context, String str) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(
            width: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              str,
              style: const TextStyle(fontSize: 12, fontFamily: 'sans'),
            ),
          )
        ],
      ),
      backgroundColor: Palette.error,
    );
    // print(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _setData() async {
    ApiServiceAllReplyTickets apiservice = ApiServiceAllReplyTickets();
    await apiservice.listTickets(Get.find<ControllerGetStorageAllData>().IsRolId==4?3:2,widget.tckId, widget.token).then((value) async {
      try {
        if (value.data != null && value.isSuccess==true) {
          for (int i = 0; i < value.data.ticketReplies.length; i++) {
            if (value.data.ticketReplies[i].repOwnerType == 2) {
              supportListReply.add(value.data.ticketReplies[i]);
            } else {
              userListReply.add(value.data.ticketReplies[i]);
            }
          }
          listTicketsReply = value.data.ticketReplies;
          // print("Listr All:$value");
          setState(() {});
        } else {
          if(value.error !=null){
            SnackError(context,value.error[0].toString());
          }
        }
      } catch (e) {
        SnackError(context,e.toString());
      }
    }).catchError((e) {
       SnackError(context,e.toString());
    });

  }

  @override
  void initState() {
    super.initState();
    fListTicketsReply = _setData();
  }
  void callback(Widget nextPage) {
    fListTicketsReply = _setData();
  }
  // Widget TicketReplyAll() {
  //
  // }
}
