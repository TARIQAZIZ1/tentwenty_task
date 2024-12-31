class SeatModel {
  final int row;
  final int number;
  bool isSelected;

  SeatModel({
    required this.row,
    required this.number,
    this.isSelected = false,
  });
}
