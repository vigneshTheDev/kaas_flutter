import 'package:flutter/material.dart';
import 'package:kaas/colors.dart';
import 'package:kaas/components/tx_icon.dart';

import '../entities/drag_data.dart';

class TxItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final bool bordered;
  final bool draggable;
  final IconType type;

  const TxItem(this.title,
      {Key? key,
      required this.icon,
      required this.backgroundColor,
      required this.color,
      this.type = IconType.none,
      this.draggable = true,
      this.bordered = false})
      : super(key: key);
  TxItem.incomeSource(
    String title, {
    Key? key,
    required IconData icon,
  }) : this(title,
            icon: icon,
            backgroundColor: incomeSourceBgColor,
            color: incomeSourceFgColor,
            type: IconType.incomeSource,
            key: key);

  TxItem.account(
    String title, {
    Key? key,
    required IconData icon,
  }) : this(title,
            icon: icon,
            backgroundColor: accountBgColor,
            color: accountFgColor,
            type: IconType.account,
            key: key);

  TxItem.expense(
    String title, {
    Key? key,
    required IconData icon,
  }) : this(title,
            icon: icon,
            backgroundColor: expenseBgColor,
            color: expenseFgColor,
            draggable: false,
            type: IconType.expense,
            key: key);

  const TxItem.plus({Key? key})
      : this('Add',
            icon: Icons.add,
            backgroundColor: const Color(0xFFfbfbfb),
            color: const Color(0xff444444),
            bordered: true,
            draggable: false,
            key: key);

  @override
  build(BuildContext context) {
    var txIcon = TxIcon(
      bgColor: backgroundColor,
      iconColor: color,
      icon: icon,
      draggable: draggable,
      bordered: bordered,
      type: type,
    );

    return SizedBox(
      width: 50,
      child: Column(
        children: [
          txIcon,
          const SizedBox(
            height: 6,
          ),
          Text(
            title,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
              color: Color.fromRGBO(102, 102, 102, 1),
            ),
          )
        ],
      ),
    );
  }
}
