import 'package:flutter/material.dart';
import 'package:task_crud/base/widgets/simple_textfield.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/core/theme/theme_data.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  Color? selectColor; // A purple color
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  String dateValue = "";
  String name = "";
  String description = "";
  String timeValue = "";

  @override
  void dispose() {
    date.dispose();
    time.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      if (!autoValidate) setState(() => autoValidate = true);
      return;
    }
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      width: getSize(context).width * 0.8,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Color(0x80CAEBFE)],
            stops: [0.05, 0.9],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              autovalidateMode: autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.ph,
                  Text(
                    "Update Task",
                    style: appbarTitleBlack(context),
                  ),
                  32.ph,
                  buildElementWidget(
                    title: "Color", child: SizedBox(),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(6),
                    //     child: Card(
                    //       elevation: 2,
                    //       child: ColorPicker(
                    //         // pickersEnabled: const <ColorPickerType, bool>{
                    //         //   ColorPickerType.accent: false,
                    //         //   ColorPickerType.wheel: false,
                    //         // },
                    //         // recentColors: [
                    //         //   Colors.red,
                    //         //   Colors.black,
                    //         //   Colors.blueAccent,
                    //         //   Colors.greenAccent,
                    //         // ],
                    //         onColorChanged: (Color value) {
                    //           print(value);
                    //
                    //           setState(() {
                    //             selectColor = value;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                  22.ph,
                  buildElementWidget(
                    title: "Name",
                    child: Column(
                      children: [
                        SimpleTextField(
                          onSaved: (newValue) {},
                          hintText: "Todo Name",
                          withGradiant: true,
                        ),
                      ],
                    ),
                  ),
                  22.ph,
                  buildElementWidget(
                    title: "Description",
                    child: SimpleTextField(
                      onSaved: (newValue) {},
                      hintText: "write description",
                      filled: true,
                      filledColor: Colors.white,
                      maxLines: 4,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color(0x33181743),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Color(0x33181743),
                        ),
                      ),
                    ),
                  ),
                  22.ph,
                  buildElementWidget(
                    title: "Date",
                    child: Column(
                      children: [
                        SimpleTextField(
                          readOnly: true,
                          onSaved: (newValue) {},
                          hintText: "Date",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildElementWidget({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textFieldTitle(context),
        ),
        10.ph,
        child,
      ],
    );
  }
}
