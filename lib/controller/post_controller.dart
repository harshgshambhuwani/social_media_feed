


import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_feed/constants/url_constant.dart';

import '../constants/controller_contants.dart';
import '../model/post_model.dart';
import '../utils/api_helper.dart';
import '../utils/app_utils.dart';

class PostController extends GetxController{
  static PostController instance = Get.find();

  var postList = <PostData>[].obs;
  var loading = false.obs;
  var addPostLoading = false.obs;
  var bottomLoading = false.obs;
  var totalPost=100.obs;
  var page = 1.obs;
  final ScrollController packageListScrollController = ScrollController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  ///================================= Buttons =====================================


   void addPostButton(){
    if(isVaild()){
      addPostApi();
    }
  }


  bool isVaild() {
     if(titleController.text.isEmpty){
       showToast(message: "Please Enter the title");
       return false;
     }
     if(bodyController.text.isEmpty){
       showToast(message: "Please Enter the body");
       return false;
     }
     return true;

  }










  ///===================================== API =====================================

  //==================================== Post List API =============================
  postListPagination() {
    if (!bottomLoading.value) {
      bottomLoading(true);

      if (totalPost.value > postList.length) {
        page.value++;
        bottomLoading(true);
        postController.postListApi(isFirstTime: false);
      }
    }
  }

  postListApi({bool? isFromRefresh, required bool isFirstTime}) async {
    if (isFromRefresh != true && bottomLoading.value != true) {
      loading(true);
    }
    if (isFirstTime == true) {
      page.value = 1;
    }
    await ApiHelper.get(
      api: "${UrlConstant.postListUrl}?_limit=10&_page=${page.value}",
      body: {},
      onSuccess: ({required response}) {
        loading(false);
        log(response.body);
        var obj = jsonDecode(response.body);
        log(obj.toString());
        if (isFirstTime == true) {
          postList.clear();
          postList(createPackageList(obj));
        }else{
          postList.addAll(createPackageList(obj));
        }
        // PostModel model = PostModel.fromJson(obj);
        // totalPost = model.data?.length;

        bottomLoading(false);
        return postList;
      },
      onFailure: ({required message}) {
        loading(false);
        bottomLoading(false);
        showToast(message: message);
      },
    );
  }

  List<PostData> createPackageList(List data) {
    List<PostData> list = [];
    for (int i = 0; i < data.length; i++) {
      PostData model = PostData.fromJson(data[i]);
      list.add(model);
    }
    return list;
  }

  //==================================== Add Post API ===============================


  addPostApi() async {
    addPostLoading(true);

    await ApiHelper.post(
      api: UrlConstant.postListUrl,
      body:
        {
          "userId": 1,
          "title": titleController.text,
          "body": bodyController.text
        },
      onSuccess: ({required response}) {
        addPostLoading(false);
        log(response.body);
        var obj = jsonDecode(response.body);clearController();
        log(obj.toString());
        showToast(message: "Successfully added");
        clearController();
        },
      onFailure: ({required message}) {
        addPostLoading(false);
        showToast(message: message);
      },
    );
  }

  void clearController(){
    titleController.clear();
    bodyController.clear();
  }

}