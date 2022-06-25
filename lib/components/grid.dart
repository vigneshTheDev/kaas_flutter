import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:kaas/components/x_padding.dart';

class Grid extends StatefulWidget {
  final int rows;
  final int cols;
  final List<Widget> children;
  const Grid({this.rows = 1, this.cols = 5, required this.children, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GridState();
}

class _GridState extends State<Grid> {
  final ScrollController _scrollController = ScrollController();
  int offset = -1;

  @override
  Widget build(BuildContext context) {
    List<List<List<Widget>>> pages = [];
    int rowCount = widget.rows;
    int colCount = widget.cols;
    int actualRows = (widget.children.length / colCount).ceil();
    int pageCount = (actualRows / rowCount).ceil();

    for (int i = 0; i < pageCount; i++) {
      List<List<Widget>> rows = [];

      for (int j = 0; j < rowCount; j++) {
        int start = (i * rowCount * colCount) + (j * colCount);
        int end = min(start + colCount, widget.children.length);

        if (end < start) {
          break;
        }

        List<Widget> cols = widget.children.sublist(start, end);
        List<Widget> spacedCols = [];
        for (int k = 0; k < cols.length; k++) {
          spacedCols.add(cols[k]);
          if (k != cols.length - 1) {
            spacedCols.add(const SizedBox(
              width: 16,
            ));
          }
        }
        rows.add(spacedCols);
        if (j != rowCount - 1) {
          rows.add([
            const SizedBox(
              height: 8,
            )
          ]);
        }
      }
      pages.add(rows);
    }

    double width = (colCount * 50 + (colCount - 1) * 16).toDouble() + (2 * 16);
    double height = rowCount * (74) + ((rowCount - 1) * 8);
    return SizedBox(
      width: width,
      height: height,
      child: PageView(allowImplicitScrolling: true, children: [
        ...pages.map(
          (p) => SizedBox(
            width: width,
            child: XPadding(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: p
                      .map(
                        (r) => Row(
                          children: [...r],
                        ),
                      )
                      .toList()),
            ),
          ),
        )
      ]),
    );
  }
}
