import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:app_karada24/apiService/api_service_send_file.dart';
import 'package:app_karada24/apiService/api_service_send_ticket.dart';

import 'package:app_karada24/apiService/api_service_upload_image.dart';
import 'package:app_karada24/getxController/value_department_id.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/models/model_list_fileupload.dart';
import 'package:app_karada24/models/model_send_file.dart';
import 'package:app_karada24/models/model_send_ticket.dart';
import 'package:app_karada24/models/model_upload_file.dart';
import 'package:app_karada24/response/response_recive_all_products.dart';

import 'package:app_karada24/utility/dropdown.dart';
import 'package:app_karada24/utility/dropdown_tct_categories.dart';
import 'package:app_karada24/utility/snackbar_error.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../getxController/storagedata/StrorageAllData.dart';
import '../../widgets/login/input_text_login.dart';
import '../../widgets/open_image.dart';
import '../../widgets/show_alert.dart';
import '../../widgets/show_toast.dart';

class SendTicket extends StatefulWidget {

  SendTicket({
    Key? key,
  }) : super(key: key);

  @override
  _SendTicketState createState() => _SendTicketState();
}

class _SendTicketState extends State<SendTicket> {
  late File imageFile;
  String? token = Get.find<ControllerGetStorageAllData>().token;
  int? userRolId = Get.find<ControllerGetStorageAllData>().userRolId;
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtDescription = TextEditingController();
  String? txtTitleTicket="";
  int typeIs = 2;
  int userDepIds = -1;
  bool isLoadingUpload = false;
  List<ModelListUpload> listFiles = [];
  List<int> listFilesIndex = [];
  List<DatProduct> itemsCategorie = [];
  late bool isLoading = false;
 late FocusNode focusNode;
  get dropdownKey1 => null;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(listFiles.length>0 || txtDescription.text.toString().trim().isNotEmpty){
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
                        key: _formKey,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView(
                            children: <Widget>[
                              TextFieldCustom(icon: Icons.subtitles_outlined, hint: 'عنوان تیکت', valueText: (String title) {
                                txtTitleTicket=title;
                              }, validatorEr: (String? valueError) {  if (valueError!.length < 1) {
                                return "عنوان تیکت را وارد کنید";
                              } else {
                                return null;
                              } }, ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, left: 8, top: 5, bottom: 5),
                                child: SelectDropListTct(userDepId: (int userDepId) {
                                  setState(() {
                                    userDepIds=userDepId;
                                  });
                                },)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectDropList( id: 1, nameTitle: 'نام محصول',),

                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SelectDropList( id: 2,nameTitle: "اولویت"),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              buildTextFieldBody(Icons.account_box, "موضوع"),
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                    height: 30,
                                    width: 100,
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
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                        });

                                        _showModelBottom();
                                        // getFile();
                                      },
                                      style: ElevatedButton.styleFrom(

                                        primary: Palette.primaryColorD,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    )),
                              ),
                              listFiles.length <= 0
                                  ? filename("ss")
                                  : filename("ss"),
                            ],
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 8, right: 8, top: 25),
                    ),
                  ),
                ],
              ),
        appBar: AppBar(
          backgroundColor: Palette.bottomNavUnBack,
          toolbarHeight: 40.0,
          leadingWidth: 40,
          elevation: 0.0,// double
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                if(listFiles.length>0 || txtDescription.text.toString().trim().isNotEmpty){
                  AlertShow(context,"آیا از لغو ارسال تیکت مطمئن هستید؟");}else{
                  Navigator.pop(context);
                }

              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(25)),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        floatingActionButton:
        isLoading
            ? CircularProgressIndicator(strokeWidth: 0.8,):
        isLoadingUpload?null:  FloatingActionButton.extended(
          onPressed: ()async{
           SendTicketFiles();
          },
          extendedTextStyle: TextStyle(
              fontFamily: "sans",
              fontWeight: FontWeight.bold,
              fontSize: 14),
          label: const Text('ارسال',),
          icon: const Icon(
            Icons.send,
            size: 14,
          ),
          backgroundColor: Palette.primaryColorD,
        ),

      ),
    );
  }

  @override
  void initState()
  {
    Get.find<ValueDepartmentDepId>().valueDepId(-1);
    Get.find<ValueDepartmentDepId>().valuePrioriId(-1);
    Get.find<ValueDepartmentDepId>().valueCatId(-1);
    focusNode=FocusNode();
    super.initState();
  }

  // Future<void> _setDataCategori() async {
  //   ApiServiceListProduct apiservice = ApiServiceListProduct();
  //   apiservice.listTickets(token,Get.find<ControllerGetStorageAllData>().organId??1).then((value) async {
  //     try {
  //       if (value.data != null) {
  //         for (int i = 0; i < value.data!.length; i++) {
  //
  //           dropListModelProduct.listOptionItems.add(value.data![i]);
  //         }
  //         setState(() {});
  //       } else {}
  //     } catch (e) {
  //       SnackError(context, "مشکل در برقراری ارتباط با سرور");
  //       debugPrint(e.toString());
  //     }
  //   }).catchError((onError){
  //     SnackError(context, "مشکل در برقراری ارتباط با سرور");
  //   });
  // }

  // Future<void> _setDataTctCategories() async {
  //   ApiServiceListTctCategories apiservice = ApiServiceListTctCategories();
  //   apiservice.listTctCategories(token,Get.find<ControllerGetStorageAllData>().organId??1).then((value) async {
  //     try {
  //       if (value.data != null) {
  //         for (int i = 0; i < value.data!.length; i++) {
  //           _listDataTct.add(value.data![i]);
  //           if(value.data![i].parentId==0){
  //             dropListModel.listOptionItems.add(value.data![i]);
  //           }else{
  //             _listDataTctDepartment.add(value.data![i]);
  //           }
  //
  //         }
  //
  //         setState(() {});
  //       } else {}
  //     } catch (e) {
  //       SnackError(context, "مشکل در برقراری ارتباط با سرور");
  //       debugPrint(e.toString());
  //     }
  //   }).catchError((onError){
  //     SnackError(context, "مشکل در برقراری ارتباط با سرور");
  //   });
  // }

  // Widget buildTextFieldTitle(IconData icon, String hint) {
  //   return Container(
  //     height: 55,
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       elevation: 4.0,
  //       child: TextField(
  //         maxLines: 50,
  //         controller: txtTitleTicket,
  //         textDirection: TextDirection.rtl,
  //         decoration: InputDecoration(
  //           hintText: hint,
  //           hintTextDirection: TextDirection.rtl,
  //           border: InputBorder.none,
  //           focusedBorder: const OutlineInputBorder(
  //             borderSide: BorderSide(color: Colors.black, width: 0.7),
  //           ),
  //           enabledBorder: const OutlineInputBorder(
  //             borderSide: BorderSide(color: Colors.black, width: 0.7),
  //           ),
  //           errorBorder: InputBorder.none,
  //           disabledBorder: InputBorder.none,
  //           contentPadding:
  //               const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
  //         ),
  //         obscureText: false,
  //         keyboardType: TextInputType.text,
  //       ),
  //     ),
  //   );
  // }

  Widget buildTextFieldBody(IconData icon, String hint) {
    return Container(
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: TextField(
          focusNode: focusNode,
          maxLines: 50,
          controller: txtDescription,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          obscureText: false,
          textInputAction: TextInputAction.newline,
        ),
      ),
    );
  }

  Future<bool> inValid(context1) async {
    try {
      bool valid = false;
      if (txtTitleTicket=="") {
        SnackError(context1, "عنوان تیکت را وارد کنید");
        valid = false;
      }  else if (Get.find<ValueDepartmentDepId>().valueDepId.value==-1) {
        SnackError(context1, "کارشناس مورد نظر را انتخاب کنید");
        valid = false;
      } else if (Get.find<ValueDepartmentDepId>().valueCatId.value==-1) {
        SnackError(context1, "محصول مورد نظر را انتخاب کنید");
        valid = false;
      } else if (Get.find<ValueDepartmentDepId>().valuePrioriId.value==-1) {
        SnackError(context1, "اولویت خود را انتخاب کنید");
        valid = false;
      } else if (txtDescription.text.isEmpty) {
        SnackError(context1, "موضوع تیکت را وارد کنید");
        valid = false;
      }else if (userRolId! <= 0) {
        SnackError(context1, "کد کاربری شما نامعتبر است");
        valid = false;
      } else {
        valid = true;
      }
      return valid;
    } catch (e) {
      SnackError(context, e.toString());
      return false;
    }
  }

  Future getFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      final file = result!.files.first;
      if (result == null) return;
      String nameFile = file.name;
      final bytes = File(file.path as String).readAsBytesSync();
      String _img64 = base64Encode(bytes);
      String type = nameFile.split(".").last;
      if (type.contains("jpg") || type.contains("png")) {
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
          ownerName: "ticket",
          serviceName: 'ticketing',
          userId: userRolId as int,
          userTypeId: 2);
      if (result == null) {
        return null;
      } else {
        alertShowSendFile(modelUploadFile, nameFile, file.path as String);
      }
      //
    } catch (e) {
      setState(() {
        isLoadingUpload = false;
      });
      SnackError(context, "خطای دریافت فایل");
    }

    // print("result is:$result");

//
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
                  Navigator.of(context).pop(false);
                  Navigator.of(context).pop(false);
                  await _uploadFile(modelUploadFile,fileName, path);
                },
                child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),

            ],
          ),
        ],
      ),
    );
  }
  Future<void> _uploadFile(modelFileUpload, String nameFile, String filePatch) async {
    try {
      ApiServiceUploadFile apiService = ApiServiceUploadFile();
      apiService.number(modelFileUpload, token).then((value) {
        if (value.isSuccess) {
          //lue.isSuccessva;
          setState(() {
            listFilesIndex.insert(0, value.fileId);
            listFiles.insert(
                0, ModelListUpload(name: nameFile, patch: filePatch));
            isLoadingUpload = false;
          });
          showToastFile(context, nameFile);
        } else {
          SnackError(context, "خطا در برقراری ارتباط");
          setState(() {
            isLoadingUpload = false;
          });
        }
      }).catchError((e) {
        SnackError(context, "خطا در برقراری ارتباط");
        setState(() {
          isLoadingUpload = false;
        });
      });
    } catch (e) {
      SnackError(context, "خطا در برقراری ارتباط");
      setState(() {
        isLoadingUpload = false;
      });
    }
  }

  Widget filename(String type) {
    // debugPrint("listFiles${listFiles}");
    return isLoadingUpload
        ?  Column(children: [SizedBox(height: 5,),Container(height: 25,width: 25,child: CircularProgressIndicator(strokeWidth: 0.8,)),
      Text("در حال ارسال فایل ....",textDirection: TextDirection.rtl,style: TextStyle(fontFamily: "sans"),)
    ])
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
                                listFiles.removeAt(index);
                                listFilesIndex.removeAt(index);
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
@override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void sendFiles(int? ownerId, List<int> fileIds) async {
    ModelSendFile modelSendFile =
        ModelSendFile(fileIds: fileIds, ownerId: ownerId);
    print(modelSendFile.toJson());
    ApiServiceSendFile apiServiceSendFile = ApiServiceSendFile();
    await apiServiceSendFile.number(modelSendFile, token).then((value) {
      if (value.isSuccess) {
        setState(() {
          isLoading = false;
        });
        showToastSendTicket(context);
        Navigator.of(context).pop();
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
    });
  }

  void SendTicketFiles() async {

    _formKey.currentState!.save();
    final isValidLogin = _formKey.currentState!.validate();
   if(isValidLogin){
     inValid(context).then((value) async {
       if (value) {
         setState(() {
          isLoading = true;
         });
         ModelSendTicket requestModel = ModelSendTicket(
             tckTittle: txtTitleTicket.toString(),
             tckBody: txtDescription.text.toString(),
             tckProId:Get.find<ValueDepartmentDepId>().valueCatId.value,
             tckOwnerId: userRolId as int,
             tckTags: "open",
             tckpriorityId: Get.find<ValueDepartmentDepId>().valuePrioriId.value,
             tckCategoryId:Get.find<ControllerGetStorageAllData>().IsRolId==4?0:userDepIds,
             tckIsPrivate: Get.find<ControllerGetStorageAllData>().IsRolId ,
             tckHasFile: listFilesIndex.length != 0 ? true : false,
             tckOrganId: Get.find<ControllerGetStorageAllData>().organId??1,
             responsibleUserId:Get.find<ValueDepartmentDepId>().valueDepId.value,//user id کارشناس پاسخگو);
             tckParentId: 0);
         print(requestModel.toJson());
         ApiServiceSendTicket apiService = ApiServiceSendTicket();
         await apiService.number(requestModel, token as String).then((value) {
           if (value.isSuccess == true) {

             if (listFilesIndex.isNotEmpty) {
             //  setState(() {isLoading = false;});

               sendFiles(value.data.tckId, listFilesIndex);

             } else {
               setState(() {isLoading = false;});
               showToastSendTicket(context);
               Navigator.of(context).pop();
             }
           }
         }).catchError((e) {
           setState(() {});
           isLoading = false;
         });
       } else {
         setState(() {});
         isLoading = false;
       }
     });
   }

  }

  void _showModelBottom() {
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
                    leading: Icon(Icons.camera_alt_outlined),
                    title: Text(
                      'دوربین',
                      style: TextStyle(fontFamily: "sans", fontSize: 12),
                    ),
                    onTap: () {
                      _getFromCamera();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.image_sharp),
                    title: Text(
                      'گالری و تصاویر',
                      style: TextStyle(fontFamily: "sans", fontSize: 12),
                    ),
                    onTap: () {
                      _getFromGallery();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.attach_file),
                    title: Text(
                      'فایل',
                      style: TextStyle(fontFamily: "sans", fontSize: 12),
                    ),
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
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 600,
        maxWidth: 800,
      );
      if (pickedFile != null) {
        final bytes = File(pickedFile.path).readAsBytesSync();
        String _img64 = base64Encode(bytes);
        ModelUploadFile modelUploadFile = ModelUploadFile(
            fileName: pickedFile.name,
            fileContent: _img64,
            fileTypeId: 1,
            ownerId: 0,
            ownerName: "ticket",
            serviceName: 'ticketing',
            userId: userRolId as int,
            userTypeId: 2);
        print("pickedFile  " + pickedFile.path);
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
                  SizedBox(
                    height: 35,
                  ),
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
                          onTap: () async {
                            setState(() {
                              isLoadingUpload = true;
                            });
                            await _uploadFile(modelUploadFile, pickedFile.name,
                                pickedFile.path);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle),
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
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            });
      } else {
        SnackError(context, "مشکل در خواندن فایل");
      }
    } catch (e) {
      print("catch " + e.toString());
      setState(() {
        isLoadingUpload = false;
      });
    }
  }

  _getFromGallery() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 600,
        maxWidth: 800,
      );
      if (pickedFile != null) {
        final bytes = File(pickedFile.path).readAsBytesSync();
        String _img64 = base64Encode(bytes);
        ModelUploadFile modelUploadFile = ModelUploadFile(
            fileName: pickedFile.name,
            fileContent: _img64,
            fileTypeId: 1,
            ownerId: 0,
            ownerName: "ticket",
            serviceName: 'ticketing',
            userId: userRolId as int,
            userTypeId: 2);
        print("pickedFile  " + pickedFile.path);
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
                  SizedBox(
                    height: 35,
                  ),
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
                          onTap: () async {
                            setState(() {
                              isLoadingUpload = true;
                            });
                            await _uploadFile(modelUploadFile, pickedFile.name,
                                pickedFile.path);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle),
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
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            });
      } else {
        SnackError(context, "مشکل در خواندن فایل");
      }
    } catch (e) {
      print("catch " + e.toString());
      setState(() {
        isLoadingUpload = false;
      });
    }
  }
}
