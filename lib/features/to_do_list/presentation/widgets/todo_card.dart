import 'package:flutter/material.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/core/theme/theme_data.dart';

class TODOCard extends StatelessWidget {
  const TODOCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: cardColor(context),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.red,
            radius: 10,
          ),
          16.pw,
          Expanded(
            child: Text(
              "Shopping list, food for the week dsf sdgk safklg s...",
              style: titleStyle(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          24.pw,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "18 Jun",
                style: titleBlack(context),
              ),
              6.ph,
              Text(
                "10:26",
                style: subtitleStyle(context)?.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
