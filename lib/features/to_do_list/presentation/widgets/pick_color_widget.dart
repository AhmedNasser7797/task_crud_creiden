import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:task_crud/core/theme/theme_data.dart';

class PickColorWidgetForTodo extends StatelessWidget {
  final FormFieldSetter<Color> onChanged;
  final Color? color;

  const PickColorWidgetForTodo({Key? key, required this.onChanged, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ColorPicker(
          color: color ?? primaryColor(context),
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.accent: false,
            ColorPickerType.wheel: false,
          },
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("Color", style: textFieldTitle(context)),
          ),
          padding: EdgeInsets.zero,
          colorCodeHasColor: false,
          enableOpacity: false,
          enableShadesSelection: false,
          includeIndex850: false,
          onColorChanged: onChanged,
        ),
      ),
    );
  }
}
