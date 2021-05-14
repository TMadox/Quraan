import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'SurahText.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

class Sura extends StatefulWidget {
  final String surahnamear;
  final int data;
  Sura(this.data, this.surahnamear);
  _State createState() => _State();
}

class _State extends State<Sura> with SingleTickerProviderStateMixin {
  TabController _controller;
  var tafser = [];
  List langEn = ["Small", "Medium", "Large"];
  List langAr = ["صغير", "متوسط", "كبير"];
  int _selectedIndex = 0;
  var fullsurahen = [];
  var fullsurahar = [];
  Map surah;
  Map tafsertext;
  Map temp;
  TextAlign alignen = TextAlign.start;
  TextAlign alignar = TextAlign.end;
  ArabicNumbers arabicNumber = ArabicNumbers();
  Future loadfromasset(int target) async {
    String jsonString = await rootBundle
        .loadString("assets/translation/en/en_translation_$target.json");
    surah = await jsonDecode(jsonString);
    temp = surah["verse"];
    temp.forEach((key, value) {
      fullsurahen.add(temp[key]);
    });
    jsonString = await rootBundle
        .loadString("assets/translation/ar/ar_translation_$target.json");
    tafsertext = await jsonDecode(jsonString);
    temp = tafsertext["verse"];
    temp.forEach((key, value) {
      tafser.add(temp[key]);
    });
    jsonString = await rootBundle.loadString("assets/surah/surah_$target.json");
    surah = await jsonDecode(jsonString);
    temp = surah["verse"];
    temp.forEach((key, value) {
      fullsurahar.add(temp[key]);
    });
    return surah;
  }

  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      print("test");
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: FutureBuilder(
          future: loadfromasset(widget.data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.green, width: 5),
                        color: Color(0xffE5FFCC)),
                    child: Center(
                        child: Text(
                      "Loading",
                      style: TextStyle(color: Colors.green),
                    ))),
              );
            }
            return Scaffold(
              appBar: AppBar(
                actions: [
                  SizedBox(
                      width: size.width * 0.3,
                      child: Container(
                        padding: EdgeInsets.only(top: 8, right: 5, left: 10),
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Widget setupAlertDialoadContainer() {
                                return Container(
                                  height:
                                      300.0, // Change as per your requirement
                                  width:
                                      300.0, // Change as per your requirement
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: tafser.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(
                                          tafser[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "تفسير السورة",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: setupAlertDialoadContainer(),
                                    );
                                  });
                            },
                            child: Text(
                              "تفسير السورة",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                      )),
                ],
                backgroundColor: Colors.green,
                title: Center(
                  child: Title(
                      color: Colors.greenAccent,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) => _selectedIndex == 0,
                        widgetBuilder: (context) {
                          return Text(
                            snapshot.data["name"],
                            style: TextStyle(fontSize: 18 * size.height / 800),
                          );
                        },
                        fallbackBuilder: (context) {
                          return Container(
                              padding: EdgeInsets.only(left: 20, top: 5),
                              child: Text(widget.surahnamear));
                        },
                      )),
                ),
                bottom: TabBar(
                  controller: _controller,
                  tabs: [
                    Tab(
                      text: "English",
                    ),
                    Tab(
                      text: "arabic",
                    )
                  ],
                ),
              ),
              body: TabBarView(controller: _controller, children: [
                SurahText(
                  fullsurahen,
                  fullsurahar,
                  temp.length,
                  langEn,
                  'Medium',
                  'Search for a word',
                  "Font size",
                  "Options",
                ),
                SurahText(fullsurahar, fullsurahen, temp.length, langAr,
                    'متوسط', 'ابحث عن كلمة', " حجم الخط ", "خيارات"),
              ]),
            );
          }),
    );
  }
}
