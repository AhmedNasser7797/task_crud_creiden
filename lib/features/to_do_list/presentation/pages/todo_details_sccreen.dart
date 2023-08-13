import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_crud/base/widgets/custom_button.dart';
import 'package:task_crud/base/widgets/loading_widget.dart';
import 'package:task_crud/base/widgets/simple_textfield.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/core/theme/theme_data.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';
import 'package:task_crud/features/to_do_list/presentation/manager/todo_provider.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({
    super.key,
  });

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  Color? selectColor;
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  TodoModel todo = TodoModel();

  @override
  void dispose() {
    date.dispose();
    time.dispose();
    name.dispose();
    description.dispose();
    super.dispose();
  }

  Future<void> addTodoItem() async {
    try {
      if (!_formKey.currentState!.validate()) {
        if (!autoValidate) setState(() => autoValidate = true);
        return;
      }
      _formKey.currentState?.save();
      if (selectColor == null) return showToast("choose color first!");
      LoadingScreen.show(context);
      setNewData();
      await context.read<TodoProvider>().saveTodo(todo);
      Navigator.pop(context);
      Navigator.pop(context);
      showToast("item Added successfully!");
    } catch (e, s) {
      Navigator.pop(context);

      error(e, s);
    }
  }

  Future<void> deleteItem() async {
    try {
      LoadingScreen.show(context);

      await context.read<TodoProvider>().deleteTodo();
      Navigator.pop(context);
      Navigator.pop(context);
      showToast("item deleted successfully!");
    } catch (e, s) {
      Navigator.pop(context);

      error(e, s);
    }
  }

  Future<void> updateTodo() async {
    try {
      LoadingScreen.show(context);
      final provider = context.read<TodoProvider>();
      setNewData();
      provider.selectTodo = todo;
      await provider.updateTodo();
      Navigator.pop(context);
      Navigator.pop(context);
      showToast("item updated successfully!");
    } catch (e, s) {
      Navigator.pop(context);
      error(e, s);
    }
  }

  void setNewData() {
    todo.name = name.text;
    todo.description = description.text;
    todo.color = selectColor?.hex ?? "";
  }

  Future<void> selectDate() async {
    DateTime? value = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (value != null) {
      date.text = getDateFormated(value);
      todo.date = value;
      setState(() {});
    }
  }

  String getDateFormated(DateTime value) {
    return "${DateFormat.d().format(value)} - ${DateFormat.MMMM().format(value)} - ${DateFormat.y().format(value)}";
  }

  Future<void> selectTime() async {
    TimeOfDay? value = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (value != null) {
      time.text = value.format(context);
      todo.time = value;
      setState(() {});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setValueIfUpdated();
    });
    super.initState();
  }

  void setValueIfUpdated() {
    final todoProvider = context.read<TodoProvider>();
    if (todoProvider.selectedTodo != null) {
      todo = todoProvider.selectedTodo!;
      time.text = todo.time?.format(context) ?? "";
      name.text = todo.name;
      description.text = todo.description;
      selectColor = todo.color.toColor;
      if (todo.date != null) {
        date.text = getDateFormated(todo.date!);
      }
      setState(() {});
    }
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
                  Selector<TodoProvider, bool>(
                      selector: (p0, p1) => p1.selectedTodo != null,
                      builder: (context, isUpdate, child) {
                        return Text(
                          isUpdate ? "Update Task" : "Add Task",
                          style: appbarTitleBlack(context),
                        );
                      }),
                  32.ph,
                  buildElementWidget(
                    title: "Color",
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: ColorPicker(
                              color: selectColor ?? primaryColor(context),
                              pickersEnabled: const <ColorPickerType, bool>{
                                ColorPickerType.accent: false,
                                ColorPickerType.wheel: false,
                              },
                              onColorChanged: (Color value) {
                                setState(() {
                                  selectColor = value;
                                });
                              },
                            ),
                          ),
                        ),
                        if (autoValidate && selectColor == null)
                          Text(
                            "please choose color",
                            style: titleStyle(context)
                                ?.copyWith(color: Colors.red),
                          )
                      ],
                    ),
                  ),
                  22.ph,
                  buildElementWidget(
                    title: "Name",
                    child: Column(
                      children: [
                        SimpleTextField(
                          controller: name,
                          onSaved: (newValue) {
                            print("newValue $newValue");
                            todo.name = newValue!;
                          },
                          hintText: "Todo Name",
                          withGradiant: true,
                          validationError: Validator(rules: [
                            requireRule(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  22.ph,
                  buildElementWidget(
                    title: "Description",
                    child: SimpleTextField(
                      controller: description,
                      validationError: Validator(rules: [
                        requireRule(),
                      ]),
                      onSaved: (newValue) => todo.description = newValue!,
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
                          validationError: Validator(rules: [
                            requireRule(),
                          ]),
                          onTap: selectDate,
                          readOnly: true,
                          onSaved: (newValue) {},
                          controller: date,
                          hintText: "pick a reminder date",
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x33181743),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x33181743),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  22.ph,
                  buildElementWidget(
                    title: "Time",
                    child: Column(
                      children: [
                        SimpleTextField(
                          validationError: Validator(rules: [
                            requireRule(),
                          ]),
                          onTap: selectTime,
                          readOnly: true,
                          onSaved: (newValue) {},
                          controller: time,
                          hintText: "pick a reminder Time",
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x33181743),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x33181743),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  22.ph,
                  Selector<TodoProvider, bool>(
                      selector: (p0, p1) => p1.selectedTodo != null,
                      builder: (context, isUpdate, child) {
                        if (isUpdate) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                width: getSize(context).width * 0.3,
                                onTap: deleteItem,
                                title: 'Delete',
                                isGradiant: false,
                                color: const Color(0xffE30000),
                              ),
                              CustomButton(
                                width: getSize(context).width * 0.3,
                                onTap: updateTodo,
                                title: 'Update',
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                width: getSize(context).width * 0.3,
                                onTap: addTodoItem,
                                title: 'Add',
                              ),
                            ],
                          );
                        }
                      }),
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
