import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/colors.dart';
import '../extensions/style.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int? limit;
  final int? maxLines;
  final IconData? suffixIcon;
  VoidCallback? onPressed;
  Function(String)? onChanged;
  bool? obscureText;
  bool? isDisable;
  double? borderRadius;
  Widget? prefixIcon;
  TextCapitalization? textCapitalization;

  CommonTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.limit,
    this.maxLines,
    this.suffixIcon,
    this.onPressed,
    this.onChanged,
    this.obscureText,
    this.isDisable,
    this.borderRadius,
    this.prefixIcon,
    this.textCapitalization
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      enabled: isDisable == true ? false : true,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      obscuringCharacter: "*",
      cursorColor: ColorResources.primary,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: limit,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limit ?? 50),
      ],
      style: fontRegularStyle(color: ColorResources.whiteColor),
      decoration: InputDecoration(
        //filled: true,
        //fillColor: Colors.white,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(
              vertical: 10, horizontal: borderRadius ?? 10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.borderColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
          ),
          labelText: label,

          labelStyle: fontRegularStyle(color: ColorResources.whiteColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.borderColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.borderColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 5),
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(
              suffixIcon,
              color: ColorResources.borderColor,
            ),
            onPressed: onPressed,
          )
              : const Padding(padding: EdgeInsets.zero),
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints()
        // prefix: Icon(Icons.ice_skating)
      ),
    );
  }
}

class UnderlineField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final int? limit;
  final IconData? suffixIcon;
  final bool isDetailPage;
  VoidCallback? onPressed;
  bool? obscureText;
  bool? enabled;

  UnderlineField({Key? key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.limit,
    this.hintText,
    this.suffixIcon,
    this.isDetailPage = false,
    this.onPressed,
    this.obscureText,
    this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      enabled: enabled ?? true,
      cursorColor: ColorResources.primary,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limit ?? 50),
      ],
      style: Theme
          .of(context)
          .textTheme
          .titleMedium,
      decoration: InputDecoration(
        // filled: true,
        //fillColor: Colors.white,

          contentPadding:  EdgeInsets.all(isDetailPage==false ?10:0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorResources.borderColor),
          ),
          hintText: hintText,
          labelText: label,
          hintStyle: Theme
              .of(context)
              .textTheme
              .bodySmall,
          labelStyle:isDetailPage==false ?Theme
              .of(context)
              .textTheme
              .bodySmall: fontRegularStyle(
            fontSize: 18,
            color: ColorResources.blackWhite(),
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorResources.borderColor),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorResources.borderColor),
          ),
          suffixIconConstraints: suffixIcon != null
              ? const BoxConstraints(maxHeight: 30, maxWidth: 30)
              : const BoxConstraints(maxHeight: 0, maxWidth: 0),
          suffixIcon: suffixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(top: 0),
            child: IconButton(
              icon: Icon(
                suffixIcon,
                color: ColorResources.borderColor,
                size: 30,
              ),
              onPressed: onPressed,
            ),
          )
              : const Padding(padding: EdgeInsets.zero)),
    );
  }
}
