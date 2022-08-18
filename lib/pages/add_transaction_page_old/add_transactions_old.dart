import 'package:flutter/material.dart';

import 'package:kaas/shared_components/grid.dart';
import 'package:kaas/shared_components/simple_app_bar.dart';
import 'package:kaas/shared_components/x_padding.dart';
import './tx_item.dart';

class AddTransactionPageOld extends StatefulWidget {
  const AddTransactionPageOld({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTransactionPageOldState();
}

class _AddTransactionPageOldState extends State<AddTransactionPageOld> {
  Offset? position;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const SimpleAppBar(title: 'Add Transactions'),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const XPadding(
                    child: Text(
                      'Income Sources',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Grid(cols: 5, rows: 1, children: [
                    TxItem.incomeSource(
                      'Salary',
                      icon: Icons.wallet,
                    ),
                    TxItem.incomeSource('Freelancing',
                        icon: Icons.monetization_on),
                    TxItem.incomeSource('Business', icon: Icons.work),
                    TxItem.incomeSource('Investing', icon: Icons.attach_money),
                    TxItem.incomeSource('F&O', icon: Icons.keyboard_option_key),
                    TxItem.plus()
                  ]),
                  const SizedBox(height: 20),
                  const XPadding(
                    child: Text(
                      'Accounts',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Grid(children: [
                    TxItem.account('Salary', icon: Icons.wallet),
                    TxItem.account('FD', icon: Icons.lock_clock),
                    TxItem.account('Demat A/C', icon: Icons.work_history),
                    TxItem.plus()
                  ]),
                  const SizedBox(height: 20),
                  const XPadding(
                    child: Text(
                      'Expenses',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Grid(
                    cols: 5,
                    rows: 4,
                    children: [
                      TxItem.expense('Books', icon: Icons.book),
                      TxItem.expense('Courses', icon: Icons.book_online),
                      TxItem.expense('Blogs', icon: Icons.wallet),
                      TxItem.expense('Gas', icon: Icons.propane_tank),
                      TxItem.expense('EB', icon: Icons.light),
                      TxItem.expense('Fuel', icon: Icons.electric_bike),
                      TxItem.expense('Travel', icon: Icons.directions_bus),
                      TxItem.expense('Groceries',
                          icon: Icons.local_grocery_store),
                      TxItem.expense('Tax', icon: Icons.attach_money),
                      TxItem.expense('Gadgets', icon: Icons.apple),
                      TxItem.expense('Home', icon: Icons.home),
                      TxItem.expense('Gym', icon: Icons.sports_gymnastics),
                      TxItem.expense('Eat out', icon: Icons.dining),
                      TxItem.expense('Office', icon: Icons.work),
                      TxItem.expense('Grooming', icon: Icons.cut),
                      TxItem.expense('Gadgets', icon: Icons.apple),
                      TxItem.expense('Courses', icon: Icons.video_library),
                      TxItem.expense('Books', icon: Icons.book),
                      TxItem.expense('Home', icon: Icons.home),
                      TxItem.expense('Gym', icon: Icons.sports_gymnastics),
                      TxItem.expense('Eat out', icon: Icons.dining),
                      TxItem.expense('Office', icon: Icons.work),
                      TxItem.expense('Grooming', icon: Icons.cut),
                      TxItem.expense('Gadgets', icon: Icons.apple),
                      TxItem.expense('Courses', icon: Icons.video_library),
                      TxItem.expense('Books', icon: Icons.book),
                      TxItem.expense('Home', icon: Icons.home),
                      TxItem.expense('Gym', icon: Icons.sports_gymnastics),
                      TxItem.expense('Eat out', icon: Icons.dining),
                      TxItem.expense('Office', icon: Icons.work),
                      TxItem.expense('Grooming', icon: Icons.cut),
                      TxItem.expense('Gadgets', icon: Icons.apple),
                      TxItem.expense('Courses', icon: Icons.video_library),
                      TxItem.expense('Books', icon: Icons.book),
                      TxItem.plus()
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (position != null)
            Positioned(
              child: Container(
                color: const Color.fromRGBO(254, 215, 115, 1),
                child: const Text('25,00,000'),
              ),
            )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
