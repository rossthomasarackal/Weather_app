import 'package:get/get.dart';

class MyController extends  GetxController {
  RxList list = [].obs;
  RxBool light= true.obs;
  void fetch(value) {
    list.add(value);
  }
}