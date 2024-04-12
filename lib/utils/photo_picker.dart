import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../extensions/colors.dart';
import '../extensions/style.dart';



class PhotoPicker{

  Rx<String> filePath = ''.obs;
  String fileType = '';
  Rx<String> imgThumbnail = ''.obs;
  late Function(String filePath) onImagePickSuccess;


  showOptionDialog({required BuildContext context,required Function(String filePath) onImagePickSuccess}) {
    this.onImagePickSuccess = onImagePickSuccess;
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => selectCameraImage(),
            child: Row(
              children: [
                Icon(
                  Icons.camera,

                  color: ColorResources.textColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    "Click From Camera".tr,
                    style: fontRegularStyle(fontSize: 16, color: ColorResources.textColor),
                  ),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => selectGalleryImage(),
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  color: ColorResources.textColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    "Pick From Gallery".tr,
                    style: fontRegularStyle(fontSize: 16, color: ColorResources.textColor),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          SimpleDialogOption(
            onPressed: () {
              Get.back();
            },
            child: Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: ColorResources.redColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    "Cancel",
                    style: fontRegularStyle(fontSize: 16, color: ColorResources.redColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  selectCameraImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    filePath(image!.path);
    imgThumbnail(image.path);

    fileType = 'IMAGE';

    Get.back();
    onImagePickSuccess(filePath.value);
  }

  selectGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    filePath(image!.path);
    imgThumbnail(image.path);

    fileType = 'IMAGE';

    Get.back();
    onImagePickSuccess(filePath.value);
  }

  Future<void> selectedWebImage({required BuildContext context,required Function(String filePath) onImagePickSuccess}) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      //var f = await image.readAsBytes();
      filePath(image.path);
      imgThumbnail(image.path);
      fileType = 'IMAGE';
//print("Image : $image\npath : ${filePath(image!.path)}\n ImageThumbnail : ${imgThumbnail(image.path)}");
      //Get.back();
      onImagePickSuccess(filePath.value);
    }
    /*var image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List data = await image.readAsBytes();
      String list=data.cast().toString();
      filePath(list);
      imgThumbnail(list);
      fileType = 'IMAGE';
      onImagePickSuccess(filePath.value);
    }*/
  }

  Future<bool> isPermissionGranted() async {

    var status = await Permission.camera.status;
    var storagePermissionStatus = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.camera.request();
    }

    if (!storagePermissionStatus.isGranted) {
      await Permission.storage.request();
    }

    if(status.isGranted && storagePermissionStatus.isGranted){
      return true;
    }

    return false;
  }
}