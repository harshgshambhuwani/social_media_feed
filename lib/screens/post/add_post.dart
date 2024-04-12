import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed/constants/controller_contants.dart';
import 'package:social_media_feed/extensions/colors.dart';
import 'package:social_media_feed/extensions/style.dart';
import 'package:social_media_feed/utils/app_utils.dart';
import 'package:social_media_feed/widgets/common_text_field.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  void initState() {
    // TODO: implement initState
    postController.clearController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.black, Colors.blue]),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorResources.lightGreyColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  CommonTextField(
                    label: "Title",
                    controller: postController.titleController,
                    borderRadius: 10,
                  ).paddingOnly(top: 20),
                  CommonTextField(
                    label: "Body",
                    controller: postController.bodyController,
                    borderRadius: 10,
                  ).paddingSymmetric(vertical: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: TextButton(
                        onPressed: postController.addPostButton,
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                    side: BorderSide(
                                        color:
                                            ColorResources.lightGreyColor)))),
                        child: Obx(
                          ()=>
                              postController.addPostLoading.value?showLoader():
                              Text(
                            "Add Post",
                            style: fontSemiBoldStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        )).paddingSymmetric(horizontal: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
