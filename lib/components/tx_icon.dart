import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kaas/components/circle.dart';
import 'package:kaas/entities/drag_data.dart';

class TxIcon extends StatelessWidget {
  final bool bordered;
  final bool draggable;
  final double size;
  final Color iconColor;
  final Color bgColor;
  final IconData icon;
  final IconType type;

  const TxIcon({
    Key? key,
    required this.iconColor,
    required this.bgColor,
    required this.size,
    required this.icon,
    required this.draggable,
    this.type = IconType.none,
    this.bordered = false,
  }) : super(key: key);

  Widget buildCircle({bool withShadow = false}) {
    return Circle(
      size: size,
      color: bgColor,
      decoration: BoxDecoration(
        boxShadow: withShadow
            ? [
                BoxShadow(
                    offset: Offset.fromDirection(pi / 2, 2),
                    blurRadius: 2,
                    color: const Color(0x66999999))
              ]
            : [],
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }

  Widget buildDragTarget() {
    return DragTarget(
      builder: (BuildContext context, List<DragData?> candidates, rejected) {
        return candidates.isNotEmpty
            ? Circle(
                size: 50,
                color: const Color(0xFFFFFFFF),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: bgColor,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
              )
            : buildCircle();
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
      onAccept: (DragData value) {
        print('dropped: ${value.type}');
      },
    );
  }

  Widget buildDraggable(Widget child) {
    return draggable
        ? Draggable(
            data: DragData(type: type),
            childWhenDragging: const Circle(size: 50),
            feedback: buildCircle(withShadow: true),
            child: child,
          )
        : child;
  }

  Widget buildBorder(Widget child) {
    return bordered
        ? DottedBorder(
            borderType: BorderType.Circle,
            color: const Color.fromRGBO(54, 54, 54, 0.47),
            strokeWidth: 1,
            strokeCap: StrokeCap.round,
            padding: const EdgeInsets.all(1),
            dashPattern: const [5, 5],
            child: child,
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    Widget dragTarget = buildDragTarget();
    Widget draggableContent = buildDraggable(dragTarget);
    Widget borderedContent = buildBorder(draggableContent);

    return borderedContent;
  }
}
