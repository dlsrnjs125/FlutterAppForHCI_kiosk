import 'package:flutter_application_kiosk/database/total.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_kiosk/database/menu.dart';
import 'package:flutter_application_kiosk/database/myOrder.dart';
import 'package:flutter_application_kiosk/database/total.dart';

final String TableNameV1 = 'menus';
final String TableNameV2 = 'myorder';

class DBHelperMenu {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'menus.db'),
      // 데이터베이스가 처음 생성될 때, dog를 저장하기 위한 테이블을 생성합니다.
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE menus(id TEXT PRIMARY KEY, name TEXT, price INTEGER, mainAllergy TEXT, subAllergy TEXT, rankScore INTEGER)",
        );
        db.execute(
            "CREATE TABLE myorder(name TEXT PRIMARY KEY, price INTEGER, count INTEGER, id TEXT)");
        return db;
        //"INSERT INTO menus(id TEXT PRIMARY KEY, title TEXT, text TEXT, createTime TEXT, editTime TEXT)VALUES");
      },
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );

    return _db;
  }

  Future<void> insertMenu(Menu menu) async {
    final db = await database;

    // Memo를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 memo가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.insert(
      TableNameV1,
      menu.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMenuAll() async {
    final db = await database;

    // Memo를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 memo가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.rawQuery(
        "INSERT INTO menus(id,name,price,mainAllergy,subAllergy,rankScore)VALUES ('C1','에스프레소',2000,'카페인','커피추출액',0),('C2','아메리카노',3000,'카페인','커피추출액, 물',0),('C3','카페라떼',4000,'카페인','커피추출액, 우유',0),('C4','카페모카',4000,'카페인','커피추출액, 초코시럽, 우유, 휘핑크림',0),('C5','카푸치노',4000,'카페인','커피추출액, 우유',0),('C6','카라멜마끼야또',4000,'카페인','커피추출액, 카라멜시럽, 우유',0),('C7','바닐라라떼',4000,'카페인','커피추출액, 바닐라시럽, 우유',0),('C8','비엔나커피',3000,'카페인','커피추출액, 물, 휘핑크림',0),('C9','모카치노',4000,'카페인','커피추출액, 초코시럽, 우유',0),('C10','헤이즐넛라떼',4000,'카페인, 헤이즐넛시럽','커피추출액, 우유',0),('C11','에스프레소콘파냐',3000,'카페인','커피추출액, 휘핑크림',0),('C12','플랫화이트',3000,'카페인','커피추출액, 우유',0),('J1','오렌지주스',5000,'오렌지','꿀, 우유',0),('J2','배주스',5000,'배','꿀, 우유',0),('J3','포도주스',5000,'포도','꿀, 우유',0),('J4','석류주스',5000,'석류','꿀, 우유',0),('J5','감귤주스',5000,'감귤','꿀, 우유',0),('J6','파인애플주스',5000,'파인애플','꿀, 우유',0),('J7','코코넛주스',5000,'코코넛','꿀, 우유',0),('J8','사과주스',5000,'사과','꿀, 우유',0),('J9','레몬주스',5000,'레몬','꿀, 우유',0),('J10','아보카도주스',5000,'아보카도','꿀, 우유',0),('J11','체리주스',5000,'체리','꿀, 우유',0),('J12','블루베리주스',5000,'블루베리','꿀, 우유',0)");
  }

  Future<List<Menu>> menus() async {
    final db = await database;

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('menus');

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return Menu(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        mainAllergy: maps[i]['mainAllergy'],
        subAllergy: maps[i]['subAllergy'],
        rankScore: maps[i]['rankScore'],
      );
    });
  }

  Future<void> updateMenu(Menu menu) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.update(
      TableNameV1,
      menu.toMap(),
      // Memo의 id가 일치하는 지 확인합니다.
      where: "id = ?",
      // Memo의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [menu.id],
    );
  }

  Future<void> deleteMenu(String id) async {
    final db = await database;

    // 데이터베이스에서 Memo를 삭제합니다.
    await db.delete(
      TableNameV1,
      // 특정 memo를 제거하기 위해 `where` 절을 사용하세요
      where: "id = ?",
      // Memo의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );
  }

  Future<List<Menu>> findMenu(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'menus',
      where: 'id = ?',
      whereArgs: [id],
    );
    return List.generate(maps.length, (i) {
      return Menu(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        mainAllergy: maps[i]['mainAllergy'],
        subAllergy: maps[i]['subAllergy'],
        rankScore: maps[i]['rankScore'],
      );
    });
  }

  Future<List<Menu>> findMemoRank(int toggleState) async {
    final db = await database;
    String str;
    if (toggleState == 1) {
      str = 'id LIKE "C%"';
    } else {
      str = 'id LIKE "J%"';
    }
    final List<Map<String, dynamic>> maps = await db.query(
      'menus',
      where: str,
      orderBy: "rankScore DESC",
      limit: 3,
    );
    return List.generate(maps.length, (i) {
      return Menu(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        mainAllergy: maps[i]['mainAllergy'],
        subAllergy: maps[i]['subAllergy'],
        rankScore: maps[i]['rankScore'],
      );
    });
  }

  Future<void> insertMyOrder(MyOrder myOrder) async {
    final db = await database;

    // Memo를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 memo가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.insert(
      TableNameV2,
      myOrder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MyOrder>> myorder() async {
    final db = await database;

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('myorder');

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return MyOrder(
          name: maps[i]['name'],
          price: maps[i]['price'],
          count: maps[i]['count'],
          id: maps[i]['id']);
    });
  }

  Future<void> updateMyOrder(MyOrder myOrder) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.update(
      TableNameV2,
      myOrder.toMap(),
      // Memo의 id가 일치하는 지 확인합니다.
      where: "name = ?",
      // Memo의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [myOrder.name],
    );
  }

  Future<void> updateMyOrderRank(String id) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.rawQuery(
        "UPDATE menus SET rankScore = rankScore + 1 WHERE id = '$id'");
  }

  Future<void> deleteMyOrder(String name) async {
    final db = await database;

    // 데이터베이스에서 Memo를 삭제합니다.
    await db.delete(
      TableNameV2,
      // 특정 memo를 제거하기 위해 `where` 절을 사용하세요
      where: "name = ?",
      // Memo의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [name],
    );
  }

  Future<List<MyOrder>> findMyOrder(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'myorder',
      where: 'name = ?',
      whereArgs: [name],
    );
    return List.generate(maps.length, (i) {
      return MyOrder(
          name: maps[i]['name'],
          price: maps[i]['price'],
          count: maps[i]['count'],
          id: maps[i]['id']);
    });
  }

  Future<List<Total>> getTotal() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT SUM(price*count) AS sum FROM myorder");
    return List.generate(maps.length, (i) {
      return Total(sum: maps[i]['sum']);
    });
  }

  Future<void> deleteMyOrderAll() async {
    final db = await database;

    // 데이터베이스에서 Memo를 삭제합니다.
    await db.delete(
      TableNameV2,
    );
  }
}
