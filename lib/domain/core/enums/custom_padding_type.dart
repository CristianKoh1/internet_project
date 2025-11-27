enum CustomPaddingType {
  webFriendly(
    left: 17,
    top: 4,
    right: 17,
    bottom: 3,
  ),
  mobile(
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
  );

  final double top;
  final double bottom;
  final double right;
  final double left;

  const CustomPaddingType({
    required this.top,
    required this.bottom,
    required this.right,
    required this.left,
  });
}
