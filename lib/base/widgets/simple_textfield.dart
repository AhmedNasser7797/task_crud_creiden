import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/theme/theme_data.dart';

export 'package:flrx_validator/flrx_validator.dart';
export 'package:flutter/services.dart';

export '/core/help_functions.dart';

class SimpleTextField extends StatelessWidget {
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
  final bool withGradiant;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final Color? filledColor;
  final bool filled;

  final double? width;
  final double suffixIconMaxHeight;
  final double suffixIconMaxWidth;
  final double styleFontSize;

  const SimpleTextField({
    Key? key,
    @required this.onSaved,
    this.onChanged,
    this.readOnly = false,
    this.withGradiant = false,
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
    this.focusedBorder,
    this.filledColor,
    this.filled = false,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty)
          Text(
            label!,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xffc9c9c9),
            ),
          ),
        if (label != null && label!.isNotEmpty)
          const SizedBox(
            height: 16,
          ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
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
                    contentPadding: contentPadding,
                    suffixIconConstraints: BoxConstraints(
                      maxWidth: suffixIconMaxWidth,
                      maxHeight: suffixIconMaxHeight,
                      minWidth: 12,
                    ),
                    focusedBorder: focusedBorder,
                    enabledBorder: focusedBorder,
                    border: border,
                    prefixIcon: prefix,
                    suffixIcon: suffixIcon,
                    suffix: suffix,
                    prefixIconConstraints: const BoxConstraints(maxWidth: 66),
                    hintText: hintText,
                    filled: filled,
                    fillColor: filledColor,
                    isDense: true,
                    counter: const SizedBox(),
                    // contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  ),
                )),
            if (withGradiant)
              Container(
                height: 2,
                width: width ?? double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xff254DDE),
                  Color(0xffFE1E9A),
                ])),
              )
          ],
        ),
      ],
    );
  }
}
