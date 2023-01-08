class MyOrder {
  final String name;
  final int price;
  final int count;
  final String id;

  MyOrder({
    required this.name,
    required this.price,
    required this.count,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'count': count,
      'id': id,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'MyOrder{name: $name, price: $price, count: $count,id : $id}';
  }
}
