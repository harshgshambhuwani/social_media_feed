import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import '../extensions/colors.dart';
import '../extensions/size_config.dart';
import '../extensions/style.dart';
bool isTab = false;

Future<bool?> showToast({required String message}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget showLoader() {
  return Center(
      child: CircularProgressIndicator(
    color: ColorResources.primary,
    strokeWidth: 1.5,
  ));
}

Widget showBottomLoader() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
        child: CircularProgressIndicator(
      color: ColorResources.primary,
      strokeWidth: 1.5,
    )),
  );
}

Widget showNoData({required String message, String? icon}) {
  return Center(
      child: Wrap(
    children: [
      Column(
        children: [
          Image.asset(
            icon ?? "",
          ),
          SizedBox(
            height: icon != null ? 20 : 0,
          ),
          Text(
            message,
            style: fontRegularStyle(color: ColorResources.textColor, fontSize: 16.0),
          ),
        ],
      ),
    ],
  ));
}

void showCustomSnackBar(
    {required String title,
    required String message,
    required bool isError,
    int? duration}) {
  Get.snackbar(
    title,
    message,
    duration: Duration(seconds: duration ?? 3),
    icon: Icon(
      isError
          ? CupertinoIcons.xmark_shield_fill
          : CupertinoIcons.checkmark_circle,
      color: Colors.white,
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
    snackPosition: SnackPosition.TOP,
  );
}

// void showDateTimePicker(
//     BuildContext context, Function(DateTime date) onDateSelect) {
//   DateTime currentDate = DateTime.now();
//   DatePicker.showDateTimePicker(context,
//       showTitleActions: true, maxTime: currentDate, onChanged: (date) {
//     print('change $date');
//   }, onConfirm: (date) {
//     onDateSelect(date);
//     print('confirm $date');
//   }, currentTime: currentDate, locale: LocaleType.en);
// }

Future<void> showDateChooser(BuildContext context, String currentDOB,
    Function(DateTime date) onDateSelect) async {
  DateTime currentDate = DateTime.now();
  try {
    currentDate = DateFormat("dd MMMM yyyy").parse(currentDOB);
  } catch (e) {
    debugPrint('error caught: $e');
  }

  /*DatePicker.showDatePicker(context,
      showTitleActions: true, onChanged: (date) {
        print('change $date');
      }, onConfirm: (date) {
        onDateSelect(date);
        print('confirm $date');
      }, currentTime: currentDate, locale: LocaleType.en);*/

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2200),
    builder: (context, child) {
      return Column(
        children: [
          SizedBox(height: 535, child: child),
        ],
      );
    },
  );
  onDateSelect(pickedDate ?? DateTime.now());
}

String changeDateFormat(String date, String oldFormat, String newFormat) {
  String formattedDate = "";
  try {
    DateTime reqDate = DateFormat(oldFormat).parse(date);
    formattedDate = DateFormat(newFormat).format(reqDate);
  } catch (e) {
    debugPrint('error caught: $e');
  }
  return formattedDate;
}

void showCustomDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required String btnName,
    required Function() onButtonClick}) {
  AlertDialog alert = AlertDialog(
    backgroundColor: ColorResources.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    insetPadding: const EdgeInsets.all(20),
    title: Text(title,
        textAlign: TextAlign.center,
        style: fontMediumStyle(fontSize: 14, color: ColorResources.redColor)),
    content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message,
                textAlign: TextAlign.center,
                style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: OutlinedButton(
                // <-- OutlinedButton
                onPressed: () {
                  onButtonClick();
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: ColorResources.redColor,
                ),
                child: Text(
                  btnName,
                  style: fontRegularStyle(color: ColorResources.whiteColor, fontSize: 13),
                ),
              ),
            )
          ],
        )),
  );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showUpdateAlertDialog(
    {required BuildContext context,
    required String message,
    required bool isMandatory,
    required Function() onCancelClick,
    required Function() onUpdateClick}) {
  WillPopScope alert = WillPopScope(
    onWillPop: () async => false,
    child: AlertDialog(
      backgroundColor: ColorResources.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(20),
      title: Text('update_app'.tr,
          textAlign: TextAlign.center,
          style: fontMediumStyle(fontSize: 14, color: ColorResources.redColor)),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(message,
                    textAlign: TextAlign.center,
                    style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
              ),
              const SizedBox(
                height: 20,
              ),
              isMandatory == true
                  ? Center(
                      child: OutlinedButton(
                        // <-- OutlinedButton
                        onPressed: () {
                          onUpdateClick();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ColorResources.redColor,
                        ),
                        child: Text(
                          'update'.tr,
                          style:
                              fontRegularStyle(color: ColorResources.whiteColor, fontSize: 13),
                        ),
                      ),
                    )
                  : Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            // <-- OutlinedButton
                            onPressed: () {
                              onCancelClick();
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: ColorResources.redColor),
                            ),
                            child: Text(
                              'cancel'.tr,
                              style: fontRegularStyle(
                                  color: ColorResources.textColor, fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            // <-- OutlinedButton
                            onPressed: () {
                              onUpdateClick();
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: ColorResources.redColor,
                            ),
                            child: Text(
                              'update'.tr,
                              style: fontRegularStyle(
                                  color: ColorResources.whiteColor, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          )),
    ),
  );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getTodayDate(String newFormat) {
  String formattedDate = "";
  try {
    DateTime reqDate = DateTime.now();
    formattedDate = DateFormat(newFormat).format(reqDate);
  } catch (e) {
    debugPrint('error caught: $e');
  }
  return formattedDate;
}

void showConfirmBookingDialog(
    BuildContext context, String bookingID, Function() onButtonClick) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          content: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(cornerRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/img_like.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'booking_msg'.tr,
                      style:
                          fontSemiBoldStyle(color: ColorResources.textColor, fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'booking_id_msg'.tr,
                      style: fontRegularStyle(color: ColorResources.textColor, fontSize: 13.0),
                    ),
                    Text(
                      "#$bookingID",
                      style: fontSemiBoldStyle(color: ColorResources.redColor, fontSize: 13.0),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'thank_you_msg'.tr,
                      style: fontRegularStyle(color: ColorResources.textColor, fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    OutlinedButton(
                      // <-- OutlinedButton
                      onPressed: () {
                        Navigator.pop(context);
                        onButtonClick();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorResources.redColor,
                      ),
                      child: Text(
                        'booking_details'.tr,
                        style:
                            fontSemiBoldStyle(color: ColorResources.whiteColor, fontSize: 12),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          contentPadding: EdgeInsets.zero,
        );
      });
}

void showConfirmationMessageDialog(BuildContext context, String title,
    String message, Function() onPositiveButtonClick) {
  bool isWeb = GetPlatform.isWeb;
  double media = MediaQuery.of(context).size.width;
  AlertDialog alert = (isWeb && media > 425)
      ? AlertDialog(
          backgroundColor: ColorResources.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          insetPadding: const EdgeInsets.all(20),
          title: Text(title,
              textAlign: TextAlign.center,
              style: fontMediumStyle(fontSize: 14, color: ColorResources.redColor)),
          content: SizedBox(
              width: media / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message,
                      textAlign: TextAlign.center,
                      style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
                  const SizedBox(
                    height: 20,
                  ),
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          // <-- OutlinedButton
                          onPressed: () {
                            Get.back();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1.0, color: ColorResources.redColor),
                          ),
                          child: Text(
                            'no'.tr,
                            style: fontRegularStyle(
                                color: ColorResources.textColor, fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          // <-- OutlinedButton
                          onPressed: () {
                            onPositiveButtonClick();
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: ColorResources.redColor,
                          ),
                          child: Text(
                            'yes'.tr,
                            style: fontRegularStyle(
                                color: ColorResources.whiteColor, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        )
      : AlertDialog(
          backgroundColor: ColorResources.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          insetPadding: const EdgeInsets.all(20),
          title: Text(title,
              textAlign: TextAlign.center,
              style: fontMediumStyle(fontSize: 14, color: ColorResources.redColor)),
          content: SizedBox(
              width: media,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message,
                      textAlign: TextAlign.center,
                      style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
                  const SizedBox(
                    height: 20,
                  ),
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          // <-- OutlinedButton
                          onPressed: () {
                            Get.back();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1.0, color: ColorResources.redColor),
                          ),
                          child: Text(
                            'no'.tr,
                            style: fontRegularStyle(
                                color: ColorResources.textColor, fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          // <-- OutlinedButton
                          onPressed: () {
                            onPositiveButtonClick();
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: ColorResources.redColor,
                          ),
                          child: Text(
                            'yes'.tr,
                            style: fontRegularStyle(
                                color: ColorResources.whiteColor, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        );
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void redirectToUri({required String scheme, required String data}) async {
  final Uri launchUri = Uri(scheme: scheme, path: data);
  await launchUrl(launchUri);
}

void launchWhatsapp({required String number}) async {
  var whatsapp = number;
  var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=");
  if (!await launchUrl(whatsappAndroid)) {
    throw 'Could not launch $whatsappAndroid';
  }
}

// Future showLanguageAlertDialog(BuildContext context, Function onButtonPressed) {
//   bool isWeb=GetPlatform.isWeb;
//   double media=MediaQuery.of(context).size.width;
//   AlertDialog alert =(isWeb && media>425)?
//   AlertDialog(
//     backgroundColor: ColorResources.whiteColor,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     content: SizedBox(
//         width: media/4,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(
//                 child: Text('select_lang'.tr,
//                     textAlign: TextAlign.center,
//                     style: fontSemiBoldStyle(fontSize: 16, color: ColorResources.textColor))),
//             const SizedBox(
//               height: 20,
//             ),
//             Divider(
//               color: ColorResources.lightGrayColor,
//               height: 1,
//             ),
//             // Obx(
//             //       () => RadioListTile(
//             //     title: Text('str_english'.tr,
//             //         style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
//             //     groupValue: 'ENG',
//             //     value: authController.languageValue.value,
//             //     activeColor: ColorResources..primary,
//             //     onChanged: (value) {
//             //       authController.languageValue('ENG');
//             //     },
//             //   ),
//             // ),
//             Obx(() => RadioListTile(
//               title: Text('str_hindi'.tr,
//                   style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
//               groupValue: 'HIN',
//               value: authController.languageValue.value,
//               activeColor: ColorResources..primary,
//               onChanged: (value) async {
//                 authController.languageValue('HIN');
//               },
//             )),
//             const SizedBox(
//               height: 20,
//             ),
//             CommonBtn(
//                 btnName: 'ok'.tr,
//                 radius: 25,
//                 onPressed: () {
//                   languageController
//                       .changeLanguage(authController.languageValue.value);
//                   Get.back();
//                 }),
//           ],
//         )),
//   ):
//   AlertDialog(
//     backgroundColor: ColorResources.whiteColor,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     content: SizedBox(
//         width: media,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(
//                 child: Text('select_lang'.tr,
//                     textAlign: TextAlign.center,
//                     style: fontSemiBoldStyle(fontSize: 16, color: ColorResources.textColor))),
//             const SizedBox(
//               height: 20,
//             ),
//             Divider(
//               color: ColorResources.lightGrayColor,
//               height: 1,
//             ),
//             Obx(
//               () => RadioListTile(
//                 title: Text('str_english'.tr,
//                     style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
//                 groupValue: 'ENG',
//                 value: authController.languageValue.value,
//                 activeColor: ColorResources..primary,
//                 onChanged: (value) {
//                   authController.languageValue('ENG');
//                 },
//               ),
//             ),
//             Obx(() => RadioListTile(
//                   title: Text('str_hindi'.tr,
//                       style: fontRegularStyle(fontSize: 14, color: ColorResources.textColor)),
//                   groupValue: 'HIN',
//                   value: authController.languageValue.value,
//                   activeColor: ColorResources..primary,
//                   onChanged: (value) async {
//                     authController.languageValue('HIN');
//                   },
//                 )),
//             const SizedBox(
//               height: 20,
//             ),
//             CommonBtn(
//                 btnName: 'ok'.tr,
//                 radius: 25,
//                 onPressed: () {
//                   languageController
//                       .changeLanguage(authController.languageValue.value);
//                   Get.back();
//                 }),
//           ],
//         )),
//   );
//   return showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

Future<String> downloadAndSaveFile(String url, String fileName) async {
  String? downloadDirectory;
  if (Platform.isAndroid) {
    final externalStorageFolder = await getExternalStorageDirectory();
    if (externalStorageFolder != null) {
      downloadDirectory = p.join(externalStorageFolder.path, "");
    }
  } else {
    final downloadFolder = await getDownloadsDirectory();
    if (downloadFolder != null) {
      downloadDirectory = downloadFolder.path;
    }
  }

  final String filePath = '$downloadDirectory/$fileName';
  var response = await http.get(
    Uri.parse(url),
  );
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future showSelectionDialog(
    {required BuildContext context,
    required String title,
    required Widget listWidget}) {
  bool isWeb = GetPlatform.isWeb;
  double media = MediaQuery.of(context).size.width;
  AlertDialog alert = (isWeb && media > 425)
      ? AlertDialog(
          alignment: Alignment.center,
          backgroundColor: ColorResources.whiteColor,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          content: SizedBox(
              width: media / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      title,
                      style: fontMediumStyle(color: ColorResources.redColor, fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(thickness: 1, color: ColorResources.lightGreyColor),
                  SizedBox(
                    width: media / 3, // Change as per your requirement
                    height: 300.0, // Change as per your requirement
                    child: listWidget,
                  )
                ],
              )),
        )
      : AlertDialog(
          alignment: Alignment.bottomCenter,
          backgroundColor: ColorResources.whiteColor,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          content: SizedBox(
              width: media,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      title,
                      style: fontMediumStyle(color: ColorResources.redColor, fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(height: 1, color: ColorResources.lightGreyColor),
                  SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Change as per your requirement
                    height: 300.0, // Change as per your requirement
                    child: listWidget,
                  )
                ],
              )),
        );
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

bool isEmailValid(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}

bool isValidaMobile({String? countryCode, required String mobileNumber}) {
  String pattern = r'(^(?:[+0]9)?[0-9]{8,14}$)';
  if (countryCode == '+91') {
    pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
  }
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(mobileNumber);
}

//   getFormattedAmount({required num amount}) {
// // String finalAmount = '${UrlConstant.CURRENCY_SYMBOL} ${amount}';
// /*String finalAmount = '${UrlConstant.CURRENCY_SYMBOL} ${NumberFormat.compact().format(amount)}';*/
//
// return finalAmount;
// }
getStringFromList({required list}) {
  return list.join(', ');
}

/*
String getFormattedAmount({required String amount}) {
  String symbol = 'RS';
  String finalAmount = '$symbol ${NumberFormat.compact().format(amount)}';
  return finalAmount;
}*/
