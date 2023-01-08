class Total {
  final int sum;

  Total({
    required this.sum,
  });

  Map<String, dynamic> toMap() {
    return {'sum': sum};
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Total{sum: $sum}';
  }
}
