import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'SuraPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahList extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SurahList> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  Color backgroundcolor;
  int searchedindex;
  List suralist;
  var surasen = [];
  var surasar = [];
  int itemcount;
  String temp;
  Future loadfromasset(String target) async {
    String jsonString = await rootBundle.loadString(target);
    suralist = jsonDecode(jsonString);
    itemcount = suralist.length;
    suralist.forEach((element) {
      surasen.add("${element["title"]}".toLowerCase());
      surasar.add("${element["titleAr"]}");
    });
    return suralist;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Title(
            color: Colors.greenAccent,
            child: Container(
                child: Text("ISLAMISM"))),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: FutureBuilder(
                  future: loadfromasset("assets/surah.json"),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(child: Text("Loading")),
                      );
                    }
                    return ScrollablePositionedList.builder(
                      itemCount: itemcount,
                      itemBuilder: (context, index) {
                        return Card(
                          color:
                              searchedindex == index ? backgroundcolor : null,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Sura(index + 1,
                                          snapshot.data[index]["titleAr"])));
                            },
                            title: Text(
                              snapshot.data[index]["title"],
                            ),
                            trailing: Text(
                              snapshot.data[index]["titleAr"],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      },
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                    );
                  }),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.green, width: 5),
                color: Color(0xffE5FFCC)),
            child: TextField(
              onSubmitted: (value) {
                if (surasen.contains(value.toLowerCase())) {
                  searchedindex = surasen.indexOf(value);
                  itemScrollController.jumpTo(index: surasen.indexOf(value));
                  setState(() {
                    backgroundcolor = Colors.green;
                  });
                }
                if (surasar.contains(value)) {
                  searchedindex = surasen.indexOf(value);
                  itemScrollController.jumpTo(index: surasar.indexOf(value));
                  setState(() {
                    backgroundcolor = Colors.green;
                  });
                }
              },
              onEditingComplete: () {
                setState(() {
                  backgroundcolor = null;
                });
              },
              cursorColor: Colors.green,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                hintText: "بحث",
              ),
            ),
          )
        ],
      ),
    );
  }
}
