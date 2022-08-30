import 'package:get/get.dart';

class ValueDepartmentDepId extends GetxController{
  var valueDepId=(-1).obs;
  var valueCatId=(-1).obs;
  var valuePrioriId=(-1).obs;

  void ValueDepId(int value){
    valueDepId.value=value;
  }
  void ValueCatId(int value){
    valueCatId.value=value;
  }
  void ValuePrioriId(int value){
    valuePrioriId.value=value;
  }
}