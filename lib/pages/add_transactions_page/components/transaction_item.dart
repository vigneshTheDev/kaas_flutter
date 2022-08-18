import 'package:flutter/material.dart';
import 'package:kaas/shared_components/x_space.dart';
import '../entities/parsed_description.dart';

class TransactionItem extends StatefulWidget {
  final ParsedDescription description;
  const TransactionItem({Key? key, required this.description})
      : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    TextStyle bodyTextStyle =
        const TextStyle(fontSize: 12, color: Color(0xFF000000));
    TextStyle tagTextStyle =
        bodyTextStyle.copyWith(color: const Color(0xFF999999));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              text: TextSpan(
                style: bodyTextStyle,
                children: <TextSpan>[
                  ...widget.description.segments.map(
                    (e) => TextSpan(
                      text: e.string,
                      style: e.isTag ? tagTextStyle : bodyTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
          const XSpace(8),
          Text(
            widget.description.amountFormatted,
            style: bodyTextStyle,
          ),
        ],
      ),
    );
  }
}
