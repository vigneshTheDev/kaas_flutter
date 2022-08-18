import 'package:flutter/material.dart';

import 'package:kaas/colors.dart';
import 'package:kaas/shared_components/x_space.dart';
import 'package:kaas/shared_components/y_space.dart';
import 'package:kaas/shared_components/x_padding.dart';

import 'components/balance.dart';
import 'components/income_expense_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: yellowLight,
        elevation: 0,
        title: XPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kaas',
                style: TextStyle(color: yellowText, fontSize: 22),
              ),
              Text(
                'A Penny Saved is a Penny Earned',
                style: TextStyle(fontSize: 10, color: yellowText),
              )
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 70,
              ),
              Container(
                height: 41,
                decoration: BoxDecoration(
                    color: yellowLight,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32))),
              ),
              const Positioned(top: 16, left: 68, right: 68, child: Balance())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '75,00,000 away from goal',
                style: TextStyle(
                    fontSize: 12,
                    color: yellowText,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const YSpace(16),
          const XPadding(
            child: Text(
              'THIS MONTH',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff555555),
              ),
            ),
          ),
          const YSpace(16),
          XPadding(
            child: Row(
              children: const [
                Expanded(
                  child: IncomeExpenseCard(
                    label: 'INCOME',
                    icon: Icons.arrow_circle_up,
                    value: '+2,50,000',
                    color: Color(0xff056A09),
                  ),
                ),
                XSpace(16),
                Expanded(
                  child: IncomeExpenseCard(
                      label: 'EXPENSE',
                      icon: Icons.arrow_circle_down,
                      value: '+2,50,000',
                      color: Color(0xffAA0E0E)),
                ),
              ],
            ),
          ),
          const YSpace(24),
          const XPadding(
            child: Text(
              'MONTHLY LIMIT',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff555555),
              ),
            ),
          ),
          const YSpace(16)
        ],
      ),
    );
  }
}
