import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed/constants/controller_contants.dart';
import 'package:social_media_feed/extensions/colors.dart';
import 'package:social_media_feed/screens/post/widgets.dart';
import 'package:social_media_feed/utils/app_utils.dart';

import '../../extensions/style.dart';
import '../../model/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  void initState() {
    // TODO: implement initState
    postController.packageListScrollController.addListener(() {
      if(postController.packageListScrollController.position.maxScrollExtent==postController.packageListScrollController.offset){
        postController.postListPagination();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text("Social Media Feed"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: ColorResources.appGradient,
          ),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: RefreshIndicator(
                color: ColorResources.secondary,
                onRefresh: () {
                  return postController.postListApi(isFromRefresh: true,isFirstTime: true);
                },
                child: postController.loading.value
                    ? showLoader()
                    : postController.postList.isEmpty
                        ? noListFound(text: "Post Not Found")
                        : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: postController.packageListScrollController,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: postController.postList.length,
                                  itemBuilder: (context, index) {
                                    return postListWidget(
                                        context: context,
                                        model: postController.postList[index],
                                        index: index);
                                  }),
                            ),

                            Obx(() =>
                            postController.bottomLoading.value ==
                                true
                                ? showBottomLoader()
                                : const Padding(padding: EdgeInsets.zero)),
                          ],
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget postListWidget(
      {required BuildContext context,
        required PostData model,
        required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: ColorResources.lightGreyColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.asset(
                    'assets/icons/img_user.png',
                    fit: BoxFit.contain,
                    height: 30,
                  )).paddingOnly(right: 6),
              Text(
                "Harsh Shambhuwani ${model.userId}",
                style: fontSemiBoldStyle(
                    fontSize: 14, color: ColorResources.whiteColor),
              )
            ],
          ).paddingOnly(bottom: 10),
          Text(
            "Title: ${model.title}",
            style:
            fontSemiBoldStyle(fontSize: 12, color: ColorResources.whiteColor),
          ).paddingOnly(bottom: 10),
          ExpandableText(
            model.body.toString(),
            expandText: 'see more',
            collapseText: ' see less',
            maxLines: 2,
            // linkColor: Colors.white,
            style: TextStyle(color: ColorResources.whiteColor),
          ).paddingOnly(bottom: 10),
          Row(
            children: [
              commonIconWidget(icon: model.isLiked.toString()=="true"?Icons.favorite:Icons.favorite_border, onTap: () {
                if(model.isLiked.toString()=="true"){
                  setState(() {
                    model.setIsLiked=false.obs;
                  });
                }else{
                  setState(() {
                    model.setIsLiked = true.obs;
                  });
                }
              },model: model,index: index,color: model.isLiked.toString()=="true"?ColorResources.darkRedColor:ColorResources.whiteColor,),
              commonIconWidget(icon: Icons.messenger_outline, onTap: () {},model: model,index: index,color:ColorResources.whiteColor,),
              commonIconWidget(icon: Icons.share, onTap: () {},model: model,index: index,color:ColorResources.whiteColor,),
            ],
          ).paddingOnly(top: 5)
        ],
      ).paddingAll(20),
    );
  }

}
