import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kiosk/database/db.dart';
import 'package:flutter_application_kiosk/database/myOrder.dart';
import 'package:flutter_application_kiosk/database/total.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class MyFinalPage extends StatefulWidget {
  const MyFinalPage({Key? key, required String id}) : super(key: key);

  @override
  State<MyFinalPage> createState() => _MyFinalPageState();
}

class _MyFinalPageState extends State<MyFinalPage> {
  @override
  late BuildContext _context;
  var f = NumberFormat('###,###,###,###');
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                    child: myOrderBuilder(context),
                    width: 350,
                    height: 350,
                    color: Colors.lightBlue[50],
                    margin: EdgeInsets.only(top: 30)),
                myTotalBuilder(context),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 150,
                      child: RaisedButton(
                          onPressed: () {
                            int count = 0;
                            Navigator.of(context).popUntil((_) => count++ >= 2);
                          },
                          color: Colors.lightBlue[200],
                          child: Text(
                            "메뉴추가",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27.5))),
                    ),
                    loadBuilderRank(),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 0)),
                //SizedBox(height: 15.0),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: RaisedButton(
                      onPressed: () {
                        showAlertDialog();
                      },
                      color: Colors.red,
                      child: Text(
                        "전체주문취소",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.5))),
                ),
              ],
            )));
  }

  Future<void> saveDB() async {
    DBHelperMenu sd = DBHelperMenu();

    var fido = MyOrder(
      name: '아메리카노/L/시럽/얼음',
      price: 3800,
      count: 1,
      id: 'C2',
    );

    await sd.insertMyOrder(fido);

    print(await sd.myorder());
  }

  Future<void> deleteMyOrder(String name) async {
    DBHelperMenu sd = DBHelperMenu();
    sd.deleteMyOrder(name);
  }

  Future<void> deleteMyOrderAll() async {
    DBHelperMenu sd = DBHelperMenu();
    sd.deleteMyOrderAll();
  }

  Future<List<MyOrder>> findMyOrder(String name) async {
    DBHelperMenu sd = DBHelperMenu();
    return await sd.findMyOrder(name);
  }

  Future<List<MyOrder>> loadMyOrder() async {
    DBHelperMenu sd = DBHelperMenu();
    return await sd.myorder();
  }

  void updateDB(String name, int price, int count, String id) {
    DBHelperMenu sd = DBHelperMenu();

    var fido = MyOrder(name: name, price: price, count: count, id: id);
    sd.updateMyOrder(fido);
  }

  Future<void> updateMyOrderRank(String id) async {
    DBHelperMenu sd = DBHelperMenu();
    sd.updateMyOrderRank(id);
  }

  Future<List<Total>> gettotal() async {
    DBHelperMenu sd = DBHelperMenu();
    return await sd.getTotal();
  }

  Widget myTotalBuilder(BuildContext parentContext) {
    return FutureBuilder<List<Total>>(
      builder: (context, snap) {
        if (snap.data == null || snap.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              '총: 0원',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          Total total = snap.data![0];
          return Container(
            alignment: Alignment.center,
            //Total total = snap.data![0];
            child: Text(
              '총 : ' + f.format(total.sum) + '원',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }
      },
      future: gettotal(),
    );
  }

  Widget loadBuilderRank() {
    return FutureBuilder<List<MyOrder>>(
      future: loadMyOrder(),
      builder: (BuildContext context, AsyncSnapshot<List<MyOrder>> snapshot) {
        if (snapshot.data == null || snapshot.data == []) {
          return Container(child: Text("데이터를 불러올 수 없습니다."));
        } else {
          List idList = [];
          for (int i = 0; i < snapshot.data!.length; i++) {
            MyOrder myorder = snapshot.data![i];
            idList.add(myorder.id);
          }
          return SizedBox(
            width: 130,
            height: 150,
            child: RaisedButton(
                onPressed: () {
                  for (int i = 0; i < idList.length; i++) {
                    updateMyOrderRank(idList[i]);
                  }
                  setState(() {
                    deleteMyOrderAll();
                  });
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 3);
                  Fluttertoast.showToast(
                      msg: '\n결제가\n완료되었습니다.\n',
                      backgroundColor: Colors.lightBlue[50],
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.black,
                      fontSize: 40);
                },
                color: Colors.lightBlue[200],
                child: Text(
                  "결제하기",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5))),
          );
        }
      },
      //future: loadMenu(id),
    );
  }

  void showAlertDialog() async {
    await showDialog(
      context: _context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '전체취소 경고',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          //content: Text(id),
          content: Text("정말 모든 메뉴를\n전체취소하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  setState(() {
                    deleteMyOrderAll();
                  });
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 4);
                },
                child:
                    Text('확인', style: TextStyle(fontWeight: FontWeight.bold))),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    Text('취소', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        );
      },
    );
  }

  Widget myOrderBuilder(BuildContext parentContext) {
    return FutureBuilder<List<MyOrder>>(
      builder: (context, snap) {
        if (snap.data == null || snap.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              '장바구니에 메뉴가\n존재하지 않습니다.',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }
        return CupertinoScrollbar(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20),
            itemCount: snap.data?.length,
            itemBuilder: (context, index) {
              MyOrder myorder = snap.data![index];
              return Column(children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myorder.name,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "가격: " + myorder.price.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '수량 :  ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0)),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (myorder.count < 9) {
                                      setState(() {
                                        updateDB(myorder.name, myorder.price,
                                            myorder.count + 1, myorder.id);
                                      });
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5)),
                              Text(
                                myorder.count.toString(),
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5)),
                              InkWell(
                                onTap: () {
                                  if (myorder.count > 1) {
                                    setState(() {
                                      updateDB(myorder.name, myorder.price,
                                          myorder.count - 1, myorder.id);
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 50)),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    deleteMyOrder(myorder.name);
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    //boxShadow: [BoxShadow(color: Colors.lightBlue, blurRadius: 3)],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
              ]);
            },
          ),
        );
      },
      future: loadMyOrder(),
    );
  }
}
