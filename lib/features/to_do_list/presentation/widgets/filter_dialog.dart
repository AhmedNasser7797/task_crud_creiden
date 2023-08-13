import 'package:flutter/material.dart';
import 'package:task_crud/base/widgets/custom_button.dart';
import 'package:task_crud/base/widgets/simple_textfield.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/features/to_do_list/presentation/pages/search_screen.dart';

import '../manager/todo_provider.dart';
import 'pick_color_widget.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  TextEditingController date = TextEditingController();

  Future<void> selectDate(Function setState) async {
    final provider = context.read<TodoProvider>();
    DateTime? value = await showDatePicker(
      context: context,
      initialDate: provider.searchedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (value != null) {
      date.text = getDateFormated(value);
      provider.setSearchedDate = value;
    }
  }

  @override
  void dispose() {
    date.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = context.read<TodoProvider>();
      provider.setSearchedDate = null;
      provider.setSearchedColor = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter"),
      content: Consumer<TodoProvider>(builder: (context, provider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PickColorWidgetForTodo(
                color: provider.searchedColor,
                onChanged: (value) {
                  provider.setSearchedColor = value;
                }),
            22.ph,
            SimpleTextField(
              validationError: Validator(rules: [
                requireRule(),
              ]),
              onTap: () => selectDate(setState),
              readOnly: true,
              onSaved: (newValue) {},
              controller: date,
              hintText: "pick a searched date",
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
            36.ph,
            CustomButton(onTap: onSearch, title: "Search")
          ],
        );
      }),
    );
  }

  Future<void> onSearch() async {
    final provider = context.read<TodoProvider>();
    if (provider.searchedDate == null && provider.searchedColor == null) {
      return showToast("select date or color first");
    }
    Navigator.pop(context);
    navigateTo(const SearchedScreen(), context);
  }
}
