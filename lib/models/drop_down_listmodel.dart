import 'package:flutter/material.dart';
import 'package:app_karada24/response/response_recive_all_products.dart';
import 'package:app_karada24/response/response_tct_categories.dart';

class DropListModel {
  DropListModel(this.listOptionItems);

  final List<DatProduct> listOptionItems;
}
class DropListModelTctCategories {
  DropListModelTctCategories(this.listOptionItems);

  final List<DataTctCategories> listOptionItems;
}

