enum IconType { incomeSource, account, expense, none }

class DragPayload {
  final IconType type;
  const DragPayload({required this.type});
}
