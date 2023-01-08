import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kiosk/database/db.dart';
import 'package:flutter_application_kiosk/database/menu.dart';
import 'package:flutter_application_kiosk/database/myOrder.dart';

import 'final.dart';
import 'home.dart';

class MyDetailPage extends StatefulWidget {
  MyDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  // late BuildContext _context;
  String myname = '';
  int myprice = 0;
  //var backcolor1 = Color.fromARGB(255, 158, 158, 158);
  var backcolor1 = Color.fromARGB(255, 239, 235, 235);
  var backcolor2 = Color.fromARGB(255, 239, 235, 235);
  var backcolor3 = Color.fromARGB(255, 239, 235, 235);
  var backcolor4 = Color.fromARGB(255, 239, 235, 235);
  var backcolor5 = Color.fromARGB(255, 239, 235, 235);
  var backcolor6 = Color.fromARGB(255, 239, 235, 235);
  var backcolor7 = Color.fromARGB(255, 239, 235, 235);
  var backcolor8 = Color.fromARGB(255, 239, 235, 235);
  Widget build(BuildContext context) {
    // _context = context;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('1. 사이즈를 선택하세요.          ',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.all(2)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  // shape:RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(18.0),
                  //   side: BorderSide(color: Colors.lightGreen)),
                  elevation: 4,
                  minimumSize: Size(140, 120),
                ),
                onPressed: () {
                  setState(() {
                    if (backcolor1 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor1 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor1 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor1 = Color.fromARGB(255, 239, 235, 235);
                    }
                  });
                  FutureBuilder<List<Menu>>(
                    future: findOrder(widget.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Menu>> snapshot) {
                      if (snapshot.data == null || snapshot.data == []) {
                        return Container(child: Text("데이터를 불러올 수 없습니다."));
                      } else {
                        print(snapshot.data);
                        Menu menu = snapshot.data![0];
                        myprice = menu.price;
                        myname = menu.name;
                        return Text('');
                      }
                    },
                  );
                },
                child: Text(
                  " +0원\n작은 컵",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  elevation: 4,
                  minimumSize: Size(135, 120),
                ),
                onPressed: () {
                  print("id1");
                  print(widget.id);
                  setState(() {
                    if (backcolor2 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor2 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor2 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor2 = Color.fromARGB(255, 239, 235, 235);
                    }
                    //findOrder(widget.id);
                    FutureBuilder<List<Menu>>(
                      future: findOrder(widget.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Menu>> snapshot) {
                        if (snapshot.data == null || snapshot.data == []) {
                          print("데이터 ㅌ");
                          return Container(child: Text("데이터를 불러올 수 없습니다."));
                        } else {
                          print(snapshot.data);
                          Menu menu = snapshot.data![0];
                          print(",enu price");
                          print(menu.price);
                          myprice = menu.price + 800;
                          myname = menu.name;
                          return Text("");
                        }
                      },
                    );
                  });
                  print("가격");
                  print(myprice);
                },
                child: Text(
                  " +800원\n   큰 컵",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            Padding(padding: EdgeInsets.all(2)),
            Text('2. 시럽을 추가하시겠습니까? ',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.all(2)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  elevation: 4,
                  minimumSize: Size(140, 120),
                ),
                onPressed: () {
                  setState(() {
                    if (backcolor3 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor3 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor3 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor3 = Color.fromARGB(255, 239, 235, 235);
                    }
                    FutureBuilder<List<Menu>>(
                      future: findOrder(widget.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Menu>> snapshot) {
                        if (snapshot.data == null || snapshot.data == []) {
                          return Container(child: Text("데이터를 불러올 수 없습니다."));
                        } else {
                          print(snapshot.data);
                          Menu menu = snapshot.data![0];
                          myname += "/시럽";
                          return Text('');
                        }
                      },
                    );
                  });
                },
                child: Text(
                  "예",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  elevation: 4,
                  minimumSize: Size(140, 120),
                ),
                onPressed: () {
                  setState(() {
                    if (backcolor4 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor4 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor4 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor4 = Color.fromARGB(255, 239, 235, 235);
                    }
                  });
                },
                child: Text(
                  "아니오",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            Padding(padding: EdgeInsets.all(2)),
            Text('3. 얼음을 추가하시겠습니까? ',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.all(2)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  elevation: 4,
                  minimumSize: Size(140, 120),
                ),
                onPressed: () {
                  setState(() {
                    if (backcolor5 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor5 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor5 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor5 = Color.fromARGB(255, 239, 235, 235);
                    }
                    FutureBuilder<List<Menu>>(
                      future: findOrder(widget.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Menu>> snapshot) {
                        if (snapshot.data == null || snapshot.data == []) {
                          return Container(child: Text("데이터를 불러올 수 없습니다."));
                        } else {
                          print(snapshot.data);
                          Menu menu = snapshot.data![0];
                          myname += "/아이스";
                          return Text('');
                        }
                      },
                    );
                  });
                },
                child: Text(
                  "예",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  elevation: 4,
                  minimumSize: Size(140, 120),
                ),
                onPressed: () {
                  setState(() {
                    if (backcolor6 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor6 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor6 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor6 = Color.fromARGB(255, 239, 235, 235);
                    }
                  });
                },
                child: Text(
                  "아니오",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            Padding(padding: EdgeInsets.all(5)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  elevation: 4,
                  minimumSize: Size(140, 120),
                ),
                onPressed: () {
                  setState(() {
                    if (backcolor7 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor7 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor7 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor7 = Color.fromARGB(255, 239, 235, 235);
                    }
                  });
                  Navigator.pop(
                    context,
                  );
                },
                child: Text(
                  "이전",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: backcolor8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5)),
                  elevation: 4,
                  minimumSize: Size(140, 120),
                ),
                onPressed: () {
                  setState(() {
                    if (backcolor8 == Color.fromARGB(255, 239, 235, 235)) {
                      backcolor8 = Color.fromARGB(255, 139, 253, 131);
                    } else if (backcolor8 ==
                        Color.fromARGB(255, 139, 253, 131)) {
                      backcolor8 = Color.fromARGB(255, 239, 235, 235);
                    }
                    print(myname);
                    print(myprice);
                    saveOrder(myname, myprice);
                  });
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => MyFinalPage(
                                id: widget.id,
                              )));
                },
                //color: Color.fromARGB(255, 139, 253, 131),
                child: Text(
                  "다음",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Future<List<Menu>> findOrder(String id) async {
    DBHelperMenu sd = DBHelperMenu();
    return await sd.findMenu(id);
  }

  Future<void> saveOrder(String name, int price) async {
    DBHelperMenu sd = DBHelperMenu();

    var fido = MyOrder(name: name, price: price, count: 1, id: widget.id);

    await sd.insertMyOrder(fido);
  }
}
