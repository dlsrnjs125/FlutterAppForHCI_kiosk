import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kiosk/database/db.dart';
import 'package:flutter_application_kiosk/database/menu.dart';
import 'package:flutter_application_kiosk/database/myOrder.dart';
import 'package:flutter_application_kiosk/screens/final.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyDetailPage2 extends StatefulWidget {
  MyDetailPage2({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MyDetailPage2> createState() => _MyDetailPage2State();
}

class _MyDetailPage2State extends State<MyDetailPage2> {
  @override
  String newSize = 'S/';
  String newSyrup = '시럽O/';
  String newIce = '얼음O';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '1. 사이즈를 선택하세요.',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        ToggleSwitch(
          minWidth: 180.0,
          minHeight: 100.0,
          fontSize: 30.0,
          activeBgColor: [Colors.lightBlue.shade200],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.grey[900],
          totalSwitches: 2,
          initialLabelIndex: 0,
          labels: ['+0원\n작은컵(S)', '+800원\n큰 컵(L)'],
          onToggle: (index) {
            if (index == 0) {
              newSize = 'S/';
            } else {
              newSize = 'L/';
            }
          },
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        Text(
          '2. 시럽을 추가하시겠습니까?',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        ToggleSwitch(
          minWidth: 180.0,
          minHeight: 100.0,
          fontSize: 30.0,
          activeBgColor: [Colors.lightBlue.shade200],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.grey[900],
          totalSwitches: 2,
          initialLabelIndex: 0,
          labels: ['예', '아니요'],
          onToggle: (index) {
            if (index == 0) {
              newSyrup = '시럽O/';
            } else {
              newSyrup = '시럽X/';
            }
          },
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        Text(
          '3. 얼음을 추가하시겠습니까?',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        ToggleSwitch(
          minWidth: 180.0,
          minHeight: 100.0,
          fontSize: 30.0,
          activeBgColor: [Colors.lightBlue.shade200],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.grey[900],
          totalSwitches: 2,
          initialLabelIndex: 0,
          labels: ['예', '아니요'],
          onToggle: (index) {
            if (index == 0) {
              newIce = '얼음O';
            } else {
              newIce = '얼음X';
            }
          },
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 130,
              height: 70,
              child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  color: Colors.lightBlue.shade200,
                  child: Text(
                    "이전",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5))),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
            loadBuilder(widget.id),
          ],
        )
      ]),
    );
  }

  Future<void> saveDB(String name, int price, String id) async {
    DBHelperMenu sd = DBHelperMenu();

    var fido = MyOrder(name: name, price: price, count: 1, id: id);

    await sd.insertMyOrder(fido);

    print(await sd.menus());
  }

  Future<List<Menu>> loadMenu(String id) async {
    DBHelperMenu sd = DBHelperMenu();
    return await sd.findMenu(id);
  }

  Widget loadBuilder(String id) {
    return FutureBuilder<List<Menu>>(
      future: loadMenu(id),
      builder: (BuildContext context, AsyncSnapshot<List<Menu>> snapshot) {
        if (snapshot.data == null || snapshot.data == []) {
          return Container(child: Text("데이터를 불러올 수 없습니다."));
        } else {
          Menu menu = snapshot.data![0];
          int price = 0;
          return SizedBox(
            width: 130,
            height: 70,
            child: RaisedButton(
                onPressed: () {
                  if (newSize == 'S/') {
                    price = 0;
                  } else {
                    price = 800;
                  }
                  saveDB(menu.name + newSize + newSyrup + newIce,
                      menu.price + price, id);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => MyFinalPage(
                                id: menu.id,
                              )));
                },
                color: Colors.lightBlue.shade200,
                child: Text(
                  "다음",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5))),
          );
        }
      },
      //future: loadMenu(id),
    );
  }
}
