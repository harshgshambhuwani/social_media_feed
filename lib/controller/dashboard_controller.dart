
import 'package:get/get.dart';


class DashBoardController extends GetxController {
  static DashBoardController instance = Get.find();

  Rx<bool> loading = false.obs;

  // var dashboardList = <Data>[].obs;
  // var userModel = UserModel().obs;
  var versionName = ''.obs;
  Rx<int> selectedIndex = 0.obs;

  // int selectedIndex = 0;






  void onItemTapped(int index) {
    selectedIndex(index);
  }


}
