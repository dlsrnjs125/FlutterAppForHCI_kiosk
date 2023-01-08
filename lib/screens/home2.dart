import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kiosk/database/db.dart';
import 'package:flutter_application_kiosk/database/menu.dart';
import 'package:flutter_application_kiosk/screens/detail2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_application_kiosk/screens/detail.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  @override
  List<String> coffeeImg = [
    "assets/coffee_img/01.png",
    "assets/coffee_img/02.png",
    "assets/coffee_img/03.png",
    "assets/coffee_img/04.png",
    "assets/coffee_img/05.png",
    "assets/coffee_img/06.png",
    "assets/coffee_img/07.png",
    "assets/coffee_img/08.png",
    "assets/coffee_img/09.png",
    "assets/coffee_img/10.png",
    "assets/coffee_img/11.png",
    "assets/coffee_img/12.png"
  ];
  List<String> juiceImg = [
    "assets/juice_img/01.png",
    "assets/juice_img/02.png",
    "assets/juice_img/03.png",
    "assets/juice_img/04.png",
    "assets/juice_img/05.png",
    "assets/juice_img/06.png",
    "assets/juice_img/07.png",
    "assets/juice_img/08.png",
    "assets/juice_img/09.png",
    "assets/juice_img/10.png",
    "assets/juice_img/11.png",
    "assets/juice_img/12.png"
  ];
  late BuildContext _context;
  String id = '';
  int toggleState = 1;
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Padding(padding: EdgeInsets.all(15)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ToggleSwitch(
            minWidth: 180.0,
            minHeight: 60.0,
            fontSize: 30.0,
            activeBgColor: [Colors.lightBlue.shade200],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.grey[900],
            totalSwitches: 2,
            initialLabelIndex: toggleState,
            labels: ['주스', '커피'],
            onToggle: (index) {
              //insertMenuAll();
              setState(() {
                toggleState = index!;
              });
              //saveDB();
              //deleteMenu('C3');
            },
          ),
        ]),
        Padding(padding: EdgeInsets.all(10)),
        Container(
          child: Expanded(
              child: GridView.builder(
                  itemCount: 12,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 7.2 / 10,
                    //mainAxisExtent: 350,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (toggleState == 0) {
                      id = 'J';
                    } else {
                      id = 'C';
                    }
                    return Container(
                        margin: EdgeInsets.all(10),
                        //color: Colors.lightBlue,
                        child: Column(
                          children: [
                            Row(children: [
                              loadBuilderRank(
                                  id + (index + 1).toString(), toggleState),
                              IconButton(
                                  onPressed: () {
                                    print(id + (index + 1).toString());
                                    showAlertDialog(
                                        id + (index + 1).toString());
                                  },
                                  icon: Icon(Icons.question_mark_rounded))
                            ]),
                            //fit: BoxFit.fitWidth),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => MyDetailPage2(
                                                id: id + (index + 1).toString(),
                                              )));
                                },
                                child: showmenu(toggleState, index))
                          ],
                        ));
                  })),
        )
      ]),
    );
  }

  Future<void> saveDB() async {
    DBHelperMenu sd = DBHelperMenu();

    var fido = Menu(
        id: 'J12',
        name: '블루베리주스',
        price: 5000,
        mainAllergy: '블루베리',
        subAllergy: '꿀, 우유',
        rankScore: 0);

    await sd.insertMenu(fido);

    print(await sd.menus());
  }

  Future<void> deleteMenu(String id) async {
    DBHelperMenu sd = DBHelperMenu();
    sd.deleteMenu(id);
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
          return SingleChildScrollView(
            child: ListBody(children: [
              Text(
                menu.mainAllergy,
                style: TextStyle(color: Colors.red),
              ),
              Text(menu.subAllergy)
            ]),
          );
        }
      },
      //future: loadMenu(id),
    );
  }

  Widget loadBuilderTitle(String id) {
    return FutureBuilder<List<Menu>>(
      future: loadMenu(id),
      builder: (BuildContext context, AsyncSnapshot<List<Menu>> snapshot) {
        if (snapshot.data == null || snapshot.data == []) {
          return Container(child: Text("데이터를 불러올 수 없습니다."));
        } else {
          print(snapshot.data);
          Menu menu = snapshot.data![0];
          return SingleChildScrollView(
            child: ListBody(children: [
              Text(
                menu.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]),
          );
        }
      },
      //future: loadMenu(id),
    );
  }

  Future<List<Menu>> loadMenuRank(int toggleState) async {
    DBHelperMenu sd = DBHelperMenu();
    return await sd.findMemoRank(toggleState);
  }

  Future<void> insertMenuAll() async {
    DBHelperMenu sd = DBHelperMenu();
    await sd.insertMenuAll();
  }

  Widget loadBuilderRank(String id, int toggleState) {
    return FutureBuilder<List<Menu>>(
      future: loadMenuRank(toggleState),
      builder: (BuildContext context, AsyncSnapshot<List<Menu>> snapshot) {
        if (snapshot.data == null || snapshot.data == []) {
          insertMenuAll();
          return Container(child: Text(snapshot.data.toString()));
        } else {
          Menu menu1 = snapshot.data![0];
          Menu menu2 = snapshot.data![1];
          Menu menu3 = snapshot.data![2];
          if (menu1.id == id || menu2.id == id || menu3.id == id) {
            if (menu1.id == id) {
              return Row(
                children: [
                  Text(
                    'BEST 1위',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 1))
                ],
              );
            } else if (menu2.id == id) {
              return Row(
                children: [
                  Text(
                    'BEST 2위',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 1))
                ],
              );
            } else {
              return Row(
                children: [
                  Text(
                    'BEST 3위',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 1))
                ],
              );
            }
            ;
            // return Row(
            //   children: [
            //     Visibility(
            //       child: Icon(
            //         Icons.star,
            //         color: Colors.red,
            //       ),
            //       visible: true,
            //     ),
            //     Padding(
            //         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50))
            //   ],
            // );
          } else {
            return Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30))
              ],
            );
          }
        }
      },
      //future: loadMenu(id),
    );
  }

  void showAlertDialog(String id) async {
    await showDialog(
      context: _context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: loadBuilderTitle(id),
          //content: Text(id),
          content: loadBuilder(id),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('닫기')),
          ],
        );
      },
    );
  }

  Widget showmenu(int toggleState, int index) {
    if (toggleState == 1) {
      return Image(
          //alignment: Alignment.bottomCenter,
          image: AssetImage(coffeeImg[index]),
          fit: BoxFit.fitWidth);
    } else {
      return Image(
          //alignment: Alignment.bottomCenter,
          image: AssetImage(juiceImg[index]),
          fit: BoxFit.fitWidth);
    }
  }
}
