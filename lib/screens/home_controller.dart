import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 2.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}