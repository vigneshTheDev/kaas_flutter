import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kaas/colors.dart';
import 'package:kaas/components/circle.dart';
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
    double size = bordered ? 48 : 50;

    Widget dragTarget = DragTarget(
      builder: (BuildContext context, List<DragData?> candidates, rejected) {
        return TxIcon(
          size: size,
          bgColor: backgroundColor,
          iconColor: color,
          icon: icon,
        );
      },
      onWillAccept: (DragData? data) {
        if (type == IconType.account) {
          return (data?.type == IconType.incomeSource ||
              data?.type == IconType.account);
        }

        if (type == IconType.expense) {
          return data?.type == IconType.account;
        }

        return false;
      },
    );

    Widget draggableContent = draggable
        ? Draggable(
            data: DragData(type: type),
            childWhenDragging: const Circle(size: 50),
            feedback: TxIcon(
              size: size,
              bgColor: backgroundColor,
              iconColor: color,
              shadowVisible: true,
              icon: icon,
            ),
            child: dragTarget,
          )
        : dragTarget;

    Widget borderedContent = bordered
        ? DottedBorder(
            borderType: BorderType.Circle,
            color: const Color.fromRGBO(54, 54, 54, 0.47),
            strokeWidth: 1,
            strokeCap: StrokeCap.round,
            padding: const EdgeInsets.all(1),
            dashPattern: const [5, 5],
            child: draggableContent,
          )
        : draggableContent;

    return SizedBox(
      width: 50,
      child: Column(
        children: [
          borderedContent,
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
