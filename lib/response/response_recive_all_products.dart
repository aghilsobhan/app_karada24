import 'package:flutter/material.dart';
// To parse this JSON data, do
//
//     final responseReciveAllProduct = responseReciveAllProductFromJson(jsonString);

import 'dart:convert';

ResponseReciveAllProduct responseReciveAllProductFromJson(String str) => ResponseReciveAllProduct.fromJson(json.decode(str));

String responseReciveAllProductToJson(ResponseReciveAllProduct data) => json.encode(data.toJson());

class ResponseReciveAllProduct {
  ResponseReciveAllProduct({
    required this.iSuccess,
    this.error,
    required this.data,
  });

  bool? iSuccess;
  dynamic? error;
  List<DatProduct>? data;

  factory ResponseReciveAllProduct.fromJson(Map<String, dynamic> json) => ResponseReciveAllProduct(
    iSuccess: json["iSuccess"],
    error: json["error"],
    data: List<DatProduct>.from(json["data"].map((x) => DatProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "iSuccess": iSuccess,
    "error": error,
    "data": List<dynamic>.from(data?.map((x) => x.toJson()) as List<dynamic>),
  };
}

class DatProduct {
  DatProduct({
    required this.proId,
    required this.proTittle,
    required this.proDescription,
   this.isTouchingGh,
  });

  int? proId;
  String? proTittle;
  String? proDescription;
  bool? isTouchingGh=true;

  factory DatProduct.fromJson(Map<String, dynamic> json) => DatProduct(
    proId: json["proId"],
    proTittle: json["proTittle"],
    proDescription: json["proDescription"],
    isTouchingGh: false,
  );

  Map<String, dynamic> toJson() => {
    "proId": proId,
    "proTittle": proTittle,
    "proDescription": proDescription,
    "isTouchingGh": isTouchingGh,
  };
}

class Products{
  late String title;
  late String name;
  late int id;
  late String image;
   int color;
  bool expanded;

  Products({
    required this.name,
      required this.title,
      required this.id,
      required this.image,
    required this.color,
    this.expanded = false,}
      );
}
List<Products> pro=[
  Products(
      name: "محصولات شرکت ققنوس",
      title:
      '''  همواره هدف اصلی 
 شرکت ققنوس ارائه ی راهکارهایی یکپارچه در زمینه تولید نرم افزارهای 
سفارش مشتری بوده است. سامانه مدیریت پیمانکاران ( پیمان ) یکی 
از سامانه های تولیدی شرکت ققنوس است که شامل آیتم های مرتبط با 
 ارتباط پیمانکاران با سازمان های متوسط و بزرگ از قبیل شرکت 
 های حوزه برق، گاز، نفت، پتروشیمی، خودرویی و … می باش
برخی از امکانات سامانه مدیریت پیمانکاران ( پیمان ):
برگزاری آنلاین کلیه موارد مربوط به فرآیند مناقصه و مزایده
انواع ارزیابی ها به صورت خوداظهاری شامل ارزیابی کیفی، فنی بازرگانی، تاییدصلاحیت
انواع فرآیندهای کنترلی برروی پیمانکاران در حین انجام قرارداد
فرآیندهای کنترلی و ارزیابی های مربوط به صدور و کنترل موارد HSE در حین انجام کار
مدیریت و کنترل پرسنل پیمانکار، آموزش ها، قراردادها، شغل ها و …
مدیریت و کنترل فرآیندهای مرتبط با اخطار و تشویق به پیمانکاران و پرسنل آنها
مدیریت و کنترل نیروهای کلیدی از قبیل سرپرستان، کارشناسان HSE و …
          ''',
      id: 1,
      image: "images/peyman.jpg",
      color: 0xFF602541),
  Products(name: " محصولات شرکت ققنوس",title: "محصولات  1",
      id: 1,
      image: "images/sap.jpg",
      color:0xFF000000),
  Products(name: "محصولات شرکت ققنوس",title: " محصولات  1",
      id: 1,
      image: "images/peyma.jpg",
      color: 0xFF659852),
];
