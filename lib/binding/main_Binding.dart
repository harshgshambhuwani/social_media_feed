
import 'package:get/get.dart';
import '../controller/dashboard_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>DashBoardController());
  }
}