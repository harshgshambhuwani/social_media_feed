import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed/screens/post/post.dart';
import 'package:visibility_aware_state/visibility_aware_state.dart';

import '../../utils/app_utils.dart';
import '../constants/controller_contants.dart';
import '../extensions/colors.dart';
import '../extensions/style.dart';
import 'post/add_post.dart';
import 'profile/profile.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  int? pageIndex;

  DashboardScreen({Key? key, this.pageIndex}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends VisibilityAwareState<DashboardScreen> {
  //use this for store current state
  final PageStorageBucket bucket = PageStorageBucket();
  bool isDoubleBackPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    // dashBoardController.initialiseDashboard();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initialiseDashboard();

    });
    super.initState();
  }

  void initialiseDashboard() async{
    await postController.postListApi(isFromRefresh: false,isFirstTime: true);
  }

  List<Widget> pages = [
   const PostScreen(),
    const AddPostScreen(),
   const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final hasPagePushed = Navigator.of(context).canPop();
        if (dashBoardController.selectedIndex.value == 2) {
          // dashBoardController.changeTab(page: 0);
          return false;
        } else {
          if (!hasPagePushed) {
            if (isDoubleBackPressed == false) {
              isDoubleBackPressed = true;
              Future.delayed(const Duration(seconds: 2)).then((value) async {
                isDoubleBackPressed = false;
              });
              showToast(message: 'Press once again to exit');
              return false;
            } else {
              return true;
            }
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        extendBody: false,

        bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                // elevation: 20,
                type: BottomNavigationBarType.fixed,
                currentIndex: dashBoardController.selectedIndex.value,
                selectedItemColor: ColorResources.primary,
                backgroundColor: ColorResources.whiteBlack(),
                // unselectedLabelStyle: fontRegularStyle(color:ColorResources.blackWhite() ),
                selectedFontSize: 0,
                unselectedFontSize: 0,
                unselectedItemColor: ColorResources.grey3,

                useLegacyColorScheme: false,

                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: bottomBarIconWidget(
                      context: context,
                      icon: Icons.feed_outlined,
                      title: "Home".tr,
                      isActiveIcon: false,
                    ),
                    activeIcon: bottomBarIconWidget(
                      context: context,
                      icon: Icons.feed,
                      title: "Home".tr,
                      isActiveIcon: true,
                    ),
                    label: ''.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: bottomBarIconWidget(
                      context: context,
                      icon: Icons.messenger_outline,
                      title: "Add Post",
                      isActiveIcon: false,
                    ),
                    activeIcon: bottomBarIconWidget(
                      context: context,
                      icon: Icons.messenger,
                      title: "Add Post",
                      isActiveIcon: true,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: bottomBarIconWidget(
                      context: context,
                      icon: Icons.person_outline_rounded,
                      title: "Profile",
                      isActiveIcon: false,
                    ),
                    activeIcon: bottomBarIconWidget(
                      context: context,
                      icon: Icons.person,
                      title: "Profile",
                      isActiveIcon: true,
                    ),
                    label: "Profile",
                  ),

                ],
                onTap: dashBoardController.onItemTapped,
              ),
        ),

        body: PageStorage(
          bucket: bucket,
          child: Obx(
                () => pages[dashBoardController.selectedIndex.value],
          ),
        ),
        // body: pages[dashBoardController.currentPage.value],
      ),
    );
  }

  @override
  void onVisibilityChanged(WidgetVisibility visibility) {
    switch (visibility) {
      case WidgetVisibility.VISIBLE:
        if (runtimeType.toString() == '_DashboardScreenState') {
          // dashBoardController.checkAPPVersionAPI(context: context);
        }
        // Like Android's Activity.onResume()
        break;
      case WidgetVisibility.INVISIBLE:
      // Like Android's Activity.onPause()
        break;
      case WidgetVisibility.GONE:
      // Like Android's Activity.onDestroy()
        break;
    }
    super.onVisibilityChanged(visibility);
  }
}

Widget bottomBarIconWidget({
  required BuildContext context,
  required IconData icon,
  required String title,
  required bool isActiveIcon,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0),
    child: Column(
      children: [
        Icon(
          icon,
          size: isActiveIcon ? 25 : 20,
        ),
        bottomBarText(
            context: context, title: title, isActiveIcon: isActiveIcon,),
      ],
    ),
  );
}

Widget bottomBarText({
  required BuildContext context,
  required String title,
  required bool isActiveIcon,
}) {
  return Text(
    !isTab
        ? title
        : isActiveIcon
        ? " $title"
        : "   $title",
    style: fontRegularStyle(
      fontSize: isTab ? 12 : 10,
      color: isActiveIcon ? ColorResources.primary : ColorResources.grey3,
    ),
  );
}
