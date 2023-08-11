import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/theme/theme_data.dart';

export 'package:flrx_validator/flrx_validator.dart';
export 'package:flutter/services.dart';

export '/core/help_functions.dart';

class LoginSimpleTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? errorText;
  final String? label;
  final String? initialValue;
  final FormFieldSetter<String?>? onSaved;
  final FormFieldSetter<String?>? onChanged;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validationError;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final bool? obSecure;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;

  final double? width;
  final double suffixIconMaxHeight;
  final double suffixIconMaxWidth;
  final double styleFontSize;

  const LoginSimpleTextField({
    Key? key,
    @required this.onSaved,
    this.onChanged,
    this.readOnly = false,
    required this.hintText,
    this.textAlign,
    // this.textAlign = TextAlign.left,
    this.contentPadding,
    this.width,
    this.errorText,
    this.initialValue,
    this.controller,
    this.inputFormatters,
    this.maxLines = 1,
    this.validationError,
    this.textInputType,
    this.obSecure = false,
    this.suffixIcon,
    this.maxLength,
    this.label,
    this.prefix,
    this.suffix,
    this.onTap,
    this.suffixIconMaxHeight = 16,
    this.suffixIconMaxWidth = 77,
    this.styleFontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null && label!.isNotEmpty,
          child: Text(
            label!,
            style: textFieldLoginTitle(context)?.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        Visibility(
          visible: label != null && label!.isNotEmpty,
          child: const SizedBox(
            height: 16,
          ),
        ),
        SizedBox(
            width: width ?? double.infinity,
            child: TextFormField(
              cursorColor: primaryColor(context),
              onTap: onTap,
              readOnly: readOnly,
              textAlignVertical: TextAlignVertical.top,
              obscureText: obSecure ?? false,
              controller: controller,
              enabled: onSaved != null,
              onChanged: onChanged,
              validator: validationError,
              onSaved: onSaved,
              inputFormatters: inputFormatters,
              maxLines: maxLines,
              keyboardType: textInputType,
              maxLength: maxLength,
              style: titleStyle(context)?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              initialValue: initialValue,
              textAlign: textAlign ?? TextAlign.start,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                fillColor: const Color(0xffF5F5F5),
                filled: true,
                contentPadding: contentPadding,
                suffixIconConstraints: BoxConstraints(
                  maxWidth: suffixIconMaxWidth,
                  maxHeight: suffixIconMaxHeight,
                  minWidth: 12,
                ),
                prefixIcon: prefix,
                suffixIcon: suffixIcon,
                suffix: suffix,
                hintText: hintText,
                isDense: false,
                counter: const SizedBox(),
              ),
            )),
      ],
    );
  }
}
