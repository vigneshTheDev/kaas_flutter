enum IconType { incomeSource, account, expense, none }

class DragData {
  final IconType type;
  const DragData({required this.type});
}
