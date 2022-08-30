import 'dart:convert';
import 'dart:io';
import 'package:app_karada24/screen/ticketpages/view_checked_all.dart';
import 'package:device_info/device_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/apiService/api_service_send_file.dart';
import 'package:app_karada24/apiService/api_service_send_reply.dart';
import 'package:app_karada24/apiService/api_service_upload_image.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/models/model_add_reply.dart';
import 'package:app_karada24/models/model_list_fileupload.dart';
import 'package:app_karada24/models/model_send_file.dart';
import 'package:app_karada24/models/model_upload_file.dart';
import 'package:app_karada24/screen/ticketpages/reply_ticket.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../../getxController/storagedata/StrorageAllData.dart';
import '../../widgets/open_image.dart';
import '../../widgets/open_pdf.dart';
import '../../widgets/show_alert.dart';

class SendMessage extends StatefulWidget {
  final int? userRoleId;
  final String? token;
  final int? ticketId;
  final  Function callback;
  final String? statTittle;
  final String? tittleTicket;
  final DateTime dataTicket;
  SendMessage(this.userRoleId, this.token, this.ticketId, this.callback,
      this.statTittle, this.tittleTicket, this.dataTicket,
      {Key? key})
      : super(key: key);

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  List<ModelListUpload> listFiles = [];
  List<int> listFilesIndex = [];
  int typeIs = 2;
  TextEditingController textMessage = TextEditingController();
  bool _buttonVisibility = false;
  bool isLoading = false;
  bool isLoadingUpload = false;
  int? ownerId = 0;
  int? isPrivate = -1;
  int indexItemLoad = 0;
  late File imageFile;
  Map<String, dynamic> deviceData = <String, dynamic>{};
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(listFiles.length>0 || textMessage.text.isNotEmpty){
          AlertShow(context,"آیا از لغو ارسال تیکت مطمعن هستید؟");}else{
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Palette.backGroundColorD,
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  ":متن پیام",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'sans',
                                      color: Colors.black),
                                ))),
                        buildTextFieldBody("متن پیام"),
                        SizedBox(
                          height: 15,
                        ),
                        Get.find<ControllerGetStorageAllData>().IsRolId==3? ViewCheckedAll(onChangedCallbackValue: (int ) {
                          setState(() {
                            isPrivate=int;
                          });
                        },):SizedBox(),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                              height: 30,
                              width: 85,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.attachment,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                label: const Text(
                                  'فایل',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'sans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                onPressed: () {
                                  _showModelBottom();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Palette.primaryColorD,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              )

                              ),
                        ),
                        listFiles.length <= 0 ? filename("ss") : filename("ss"),
                      ],
                    ),
                  ),
                ),
                margin:
                    const EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 25),
              ),
            ),
          ],
        ),
        appBar: AppBar(

          backgroundColor: Palette.bottomNavUnBack,
          toolbarHeight: 46.0,
          leadingWidth: 46,// double
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                if(listFiles.length>0 || textMessage.text.isNotEmpty){
                  AlertShow(context,"آیا از لغو ارسال تیکت مطمعن هستید؟");}else{
                  Navigator.pop(context);
                }

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
                    child: Text("پیام جدید",
                      style: TextStyle(color: Colors.black,
                          fontFamily: "sans",
                          fontWeight: FontWeight.bold),
                    )
                )
            )
          ],
        ),
        floatingActionButton: isLoading
            ? CircularProgressIndicator()
            : FittedBox(
              child: FloatingActionButton(
                mini: true,
                backgroundColor: _buttonVisibility
                    ? Palette.primaryColorD
                    : Palette.gradient2,
                onPressed: () {
                  _buttonVisibility&&isLoadingUpload==false ? sendMessage() : null;
                },
                child: Icon(Icons.send,size: 20,),
              ),
            ),
      ),
    );
  }

  Widget buildTextFieldBody(String hint) {
    return Container(
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: TextField(
          maxLines: 50,
          controller: textMessage,
          onChanged: (value) {
            VisibilityBtn();
          },
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.7),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.7),
            ),
            contentPadding:
                const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }

  Future getFile() async {
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      final file = result!.files.first;
      if (result == null) return;
      String nameFile = file.name;
      final bytes = File(file.path as String).readAsBytesSync();
      String _img64 = base64Encode(bytes);
      String type = nameFile.split(".").last;
      if (type.contains("jpg")||type.contains("png")) {
        typeIs = 1;
      } else if (type.contains("pdf")) {
        typeIs = 2;
      } else {
        typeIs = 3;
      }
      ModelUploadFile modelUploadFile = ModelUploadFile(
          fileName: file.name,
          fileContent: _img64,
          fileTypeId: typeIs,
          ownerId: 0,
          ownerName: "reply",
          serviceName: 'ticketing',
          userId: widget.userRoleId as int,
          userTypeId: 2);
      if (result == null) {
        return null;
      } else {
        alertShowSendFile(modelUploadFile, nameFile, file.path as String);
       //  _uploadFile(modelUploadFile, nameFile, file.path as String);
       //  Navigator.of(context).pop();
      }
      //
    }catch(e){
      setState(() {
        isLoadingUpload = false;
      });
      SnackError(context, "خطای دریافت فایل");

    }

    // print("result is:$result");

//
  }

  Future<void> _uploadFile(modelFileUpload, String nameFile, String filePatch) async {
    ApiServiceUploadFile apiService = ApiServiceUploadFile();
    apiService.number(modelFileUpload, widget.token).then((value) {
      if (value.isSuccess) {
        //lue.isSuccessva;
        try{
          setState(() {
            listFilesIndex.insert(0, value.fileId);
            listFiles.insert(
                0, ModelListUpload(name: nameFile, patch: filePatch));
            isLoadingUpload = false;
            if (listFiles.length > 0) {
              setState(() {
                _buttonVisibility = true;
              });
            } else {
              setState(() {
                _buttonVisibility = false;
              });
            }
          });
          _showToast(context, nameFile);
        }catch(e){
          SnackError(context, "خطا در برقراری ارتباط");
          setState(() {
            _buttonVisibility = false;
            isLoadingUpload = false;
          });
        }

      } else {
        SnackError(context, "خطا در برقراری ارتباط");
        setState(() {
          _buttonVisibility = false;
          isLoadingUpload = false;
        });
      }
    });
  }

  Widget filename(String type) {
    // debugPrint("listFiles${listFiles}");
    return isLoadingUpload
        ?
         Center(child  : Column(children: [CircularProgressIndicator(strokeWidth: 0.8),
         Text("ارسال فایل ....",textDirection: TextDirection.rtl,style: TextStyle(fontFamily: "sans"),)
         ]),
            )
        : SingleChildScrollView(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(5),
                        width: 380,
                        decoration: BoxDecoration(
                            color: Palette.primaryColorD,
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.white, width: 0.4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                String fileExtension = p.extension(listFiles[index].patch);
                                if(fileExtension.contains("png")||fileExtension.contains("jpg")||fileExtension.contains("jpeg")){
                                  ShowImageFile(listFiles[index].patch,context);
                                }

                                //debugPrint("listFiles${listFiles}");
                              },
                              child: Container(
                                width: 300,
                                child: Text(
                                  listFiles[index].name,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: 'sans',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                setState(() {
                                  listFiles.removeAt(index);
                                  listFilesIndex.removeAt(index);
                                });
                                if (listFiles.length <= 0) {
                                  VisibilityBtn();
                                } else {
                                  setState(() {
                                    _buttonVisibility = true;
                                  });
                                }
                              }),
                              child: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                  // return Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children:
                  // [
                  //   GestureDetector(
                  //     onTap: () {
                  //       OpenFile.open(listFiles[index]);
                  //       debugPrint("listFiles${listFiles}");
                  //     },
                  //       child: Text(listFiles[index].toString())),
                  //  const Icon(Icons.delete_forever,color: Colors.red,),
                  // ]);
                }),
          );
  }

  alertShowSendFile(ModelUploadFile modelUploadFile,String fileName,path)async{
    showDialog(context: context,
      builder: (context)=>AlertDialog(
        content: Directionality(textDirection:TextDirection.rtl,child: Text("آیا میخواهید فایل $fileName ارسال شود ؟",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed:() {
                Navigator.of(context).pop(false);
              }, child:  Text("خیر",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(primary: Palette.primaryColorD)),
              ElevatedButton(
                onPressed: () async{
                  setState(() {
                    isLoadingUpload = true;
                  });
                  await _uploadFile(modelUploadFile,fileName, path);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),

            ],
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String nameFile) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Palette.iconSnack,
            ),
            Container(
              width: 250,
              child: Text(
                "  فایل ${nameFile} اضافه شد ",
                maxLines: 2,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontFamily: 'sans', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToastSend(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Palette.iconSnack,
            ),
            Container(
              width: 250,
              child: Text(
                text,
                maxLines: 2,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontFamily: 'sans', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void sendData() async {
    if (textMessage.text.trim().isNotEmpty) {
      sendMessage();
    } else {
      setState(() {
        _buttonVisibility = false;
      });
    }
  }

  VisibilityBtn() {
    if (textMessage.text.trim().isNotEmpty) {
      setState(() {
        _buttonVisibility = true;
      });
    } else {
      setState(() {
        _buttonVisibility = false;
      });
    }
  }

  void sendMessage() async {
    setState(() {
      isLoading = true;
    });
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    }
    final String _queryString = Uri(
        queryParameters:
        deviceData.map((key, value) => MapEntry(key, value?.toString()))).query;

    var date = (DateTime.now());
    ModelSendReply modelSendReply = ModelSendReply(
      repContent: textMessage.text.toString().trim().isEmpty
          ? "فایل"
          : textMessage.text.toString().trim(),
      repOwnerId: widget.userRoleId ,
      repOwnerType: Get.find<ControllerGetStorageAllData>().IsRolId==4?3:2 ,
      repTckId: widget.ticketId as int,
      repIsPrivate:isPrivate==-1?0:isPrivate,
      repRegDate: date.toString(),
      repHasFile: listFilesIndex.isNotEmpty?true:false, repId: 0, repSeen: false,
      repDescription: _queryString==""?"device data":_queryString,
    );
    print(modelSendReply.toJson());
    ApiServiceSendReplyTicket apiService = ApiServiceSendReplyTicket();
    await apiService.number(modelSendReply, widget.token).then((value) {
      if (value.isSuccess) {
        ownerId = value.data.repId;
        if (listFilesIndex.isNotEmpty) {
          sendFiles(value.data.repId, listFilesIndex);
          print("listFilesIndex:" +listFilesIndex.length.toString());
          print("listFiles:" +listFiles.length.toString());
        } else {
          Navigator.pop(context);
          setState(() {
            isLoading = false;
            widget.callback(
                ReplyTicket(
                widget.ticketId as int,
                widget.userRoleId,
                widget.token,
                widget.statTittle,
                widget.tittleTicket,
                widget.dataTicket,));
          });

        }
      } else {
        setState(() {
          isLoading = false;
        });
        SnackError(context, "فایل ارسال نشد دوباره تلاش کنید");
      }
    }).catchError((onError){
      setState(() {
        isLoading = false;
        SnackError(context,onError.toString());
      });
    });
  }
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{

      'version.sdkInt': build.version.sdkInt,
      'brand': build.brand,
      'device': build.device,
      'host': build.host,
      'id': build.id,
      'model': build.model,
    };
  }
  void sendFiles(int? ownerId, List<int> fileIds) async {
    ModelSendFile modelSendFile =
        ModelSendFile(fileIds: fileIds, ownerId: ownerId);
    ApiServiceSendFile apiServiceSendFile = ApiServiceSendFile();
    await apiServiceSendFile.number(modelSendFile, widget.token).then((value) {

      if (value.isSuccess) {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        widget.callback(ReplyTicket(
            widget.ticketId as int,
            widget.userRoleId,
            widget.token,
            widget.statTittle,
            widget.tittleTicket,
            widget.dataTicket));
        _showToastSend(context, "پیام ارسال شد");
      } else {
        setState(() {
          isLoading = false;
        });
        SnackError(context, value.error[0]);
      }
    }).catchError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });
      SnackError(context,"خطا در برقراری ارتباط");
    });
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
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _showModelBottom(){
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return Container(

            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:  Icon(Icons.camera_alt_outlined),
                    title:  Text('دوربین',style: TextStyle(fontFamily: "sans",fontSize: 12),),
                    onTap: () {
                      _getFromCamera();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading:  Icon(Icons.image_sharp),
                    title:  Text('گالری و تصاویر',style: TextStyle(fontFamily: "sans",fontSize: 12),),
                    onTap: () {
                      _getFromGallery();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading:  Icon(Icons.attach_file),
                    title:  Text('فایل',style: TextStyle(fontFamily: "sans",fontSize: 12),),
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
  _getFromCamera() async {
    try{
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 600,
        maxWidth: 800,
      );
      if (pickedFile != null) {
        final bytes = File(pickedFile.path ).readAsBytesSync();
        String _img64 = base64Encode(bytes);
        ModelUploadFile modelUploadFile = ModelUploadFile(
            fileName: pickedFile.name,
            fileContent: _img64,
            fileTypeId: 1,
            ownerId: 0,
            ownerName: "reply",
            serviceName: 'ticketing',
            userId:  widget.userRoleId as int,
            userTypeId: 2);
        print("pickedFile  "+pickedFile.path);
        setState(() {
          imageFile = File(pickedFile.path);
        });
        showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: this.context,
            backgroundColor: Colors.black54,
            builder: (BuildContext context) {
              return ListView(
                children: [
                  SizedBox(height:35,),
                  Center(
                    child: Image.file(
                      imageFile,
                      height: 500,
                      width: 400,
                      alignment: Alignment.center,

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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: ()async {
                            setState(() {
                              isLoadingUpload = true;
                            });
                            await _uploadFile(modelUploadFile, pickedFile.name, pickedFile.path);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
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
                      ),
                      const SizedBox(
                        width:10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            });
      }else{
        SnackError(context, "مشکل در خواندن فایل");
      }
    }catch(e){
      print("catch "+e.toString());
      setState(() {
        isLoadingUpload = false;
      });
    }

  }
  _getFromGallery() async {
    try{
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 600,
        maxWidth: 800,
      );
      if (pickedFile != null) {
        final bytes = File(pickedFile.path ).readAsBytesSync();
        String _img64 = base64Encode(bytes);
        ModelUploadFile modelUploadFile = ModelUploadFile(
            fileName: pickedFile.name,
            fileContent: _img64,
            fileTypeId: 1,
            ownerId: 0,
            ownerName: "reply",
            serviceName: 'ticketing',
            userId: widget.userRoleId as int,
            userTypeId: 2);
        print("pickedFile  "+pickedFile.path);
        setState(() {
          imageFile = File(pickedFile.path);
        });
        showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: this.context,
            backgroundColor: Colors.black54,
            builder: (BuildContext context) {
              return ListView(
                children: [
                  SizedBox(height:35,),
                  Center(
                    child: Image.file(
                      imageFile,
                      height: 500,
                      width: 400,
                      alignment: Alignment.center,

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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: ()async {
                            setState(() {
                              isLoadingUpload = true;
                            });
                            await _uploadFile(modelUploadFile, pickedFile.name, pickedFile.path);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
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
                      ),
                      const SizedBox(
                        width:10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            });
      }else{
        SnackError(context, "مشکل در خواندن فایل");
      }
    }catch(e){
      print("catch "+e.toString());
      setState(() {
        isLoadingUpload = false;
      });
    }

  }

}
