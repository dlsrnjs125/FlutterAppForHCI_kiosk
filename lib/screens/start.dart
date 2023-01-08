// ignore_for_file: deprecated_member_use
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_kiosk/screens/home2.dart';
import 'home.dart';
//import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class MyStartPage extends StatefulWidget {
  const MyStartPage({Key? key, required String title}) : super(key: key);

  @override
  State<MyStartPage> createState() => _MyStartPageState();
}

class _MyStartPageState extends State<MyStartPage> {
  @override
  bool textBool = true;
  double textSize = 60;
  int fontVal = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0)),
                Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 170)),
                    IconButton(
                      onPressed: () {
                        showStatefulDialog();
                      },
                      icon: Icon(Icons.settings),
                      iconSize: 50,
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 300,
                      child: RaisedButton(
                          onPressed: () {
                            goToHome();
                          },
                          color: Colors.lightBlue[200],
                          child: Text(
                            "매장",
                            style: TextStyle(
                                fontSize: textSize,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27.5))),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                      width: 150,
                      height: 300,
                      child: RaisedButton(
                          onPressed: () {
                            goToHome();
                          },
                          color: Colors.lightBlue[200],
                          child: Text(
                            "포장",
                            style: TextStyle(
                                fontSize: textSize,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27.5))),
                    )
                  ],
                ),
              ],
            )));
  }

  Future<dynamic> showStatefulDialog() async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        int? selectedRadio = fontVal;
        return AlertDialog(
          title: Text(
            '글씨 크기 변경',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: StatefulBuilder(
            builder: (__, StateSetter setDialogState) {
              // 변수명 변경
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(2, (int index) {
                  return ListTile(
                    title: makeTitle(index),
                    leading: Radio<int>(
                      value: index,
                      groupValue: selectedRadio,
                      onChanged: (int? value) {
                        setDialogState(() => selectedRadio = value);
                        setState(() => fontVal = value!);
                      },
                    ),
                  );
                }),
              );
            },
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  changeFontSize(fontVal);
                  Navigator.of(context).pop();
                },
                child: Text(
                  '닫기',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        );
      },
    );
  }

  void changeFontSize(int value) async {
    setState(() {
      if (value == 1) {
        textBool = false;
        textSize = 40;
      } else {
        textBool = true;
        textSize = 60;
      }
    });
  }

  void goToHome() {
    if (textBool == true) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => MyHomePage()));
    } else {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => MyHomePage2()));
    }
  }

  Text makeTitle(int index) {
    if (index == 0) {
      return Text('큰 글씨');
    } else {
      return Text('작은 글씨');
    }
  }
}
