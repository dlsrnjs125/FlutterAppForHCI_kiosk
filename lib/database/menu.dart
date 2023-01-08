class Menu {
  final String id;
  final String name;
  final int price;
  final String mainAllergy;
  final String subAllergy;
  final int rankScore;

  Menu(
      {required this.id,
      required this.name,
      required this.price,
      required this.mainAllergy,
      required this.subAllergy,
      required this.rankScore,
      count});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'mainAllergy': mainAllergy,
      'subAllergy': subAllergy,
      'rankScore': rankScore,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Menu{id: $id, name: $name, price: $price, mainAllergy: $mainAllergy, subAllergy: $subAllergy, rankScore: $rankScore}';
  }
}
