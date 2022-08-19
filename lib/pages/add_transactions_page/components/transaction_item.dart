import 'package:flutter/material.dart';

import 'package:kaas/shared_components/x_space.dart';
import '../entities/parsed_description.dart';

class TransactionItem extends StatefulWidget {
  final String? placeholder;
  final ParsedDescription description;
  final String? transactionDate;
  const TransactionItem({
    Key? key,
    this.placeholder,
    this.transactionDate,
    required this.description,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

TextStyle bodyTextStyle =
    const TextStyle(fontSize: 12, color: Color(0xFF000000));
TextStyle tagTextStyle = bodyTextStyle.copyWith(color: const Color(0xFF999999));

TextStyle incomeStyle = bodyTextStyle.copyWith(color: const Color(0xFF389B36));
TextStyle expenseStyle = bodyTextStyle.copyWith(color: const Color(0xFFF64B4B));

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    final placeholder = widget.placeholder;
    final date = widget.transactionDate;

    var amount = widget.description.amount;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          if (date != null)
            Text(
              date,
              style: tagTextStyle,
            ),
          if (date != null) const XSpace(8),
          Expanded(
            child: widget.description.description == '' && placeholder != null
                ? Text(
                    placeholder,
                    style: tagTextStyle,
                  )
                : RichText(
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
            style: amount > 0
                ? incomeStyle
                : amount < 0
                    ? expenseStyle
                    : bodyTextStyle,
          ),
        ],
      ),
    );
  }
}
