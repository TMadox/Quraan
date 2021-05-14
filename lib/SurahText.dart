import 'package:flutter/material.dart';

class SurahText extends StatefulWidget {
  List lang = [];
  String dropdownValue;
  var fullsurahfst = [];
  var fullsurahsnd = [];
  String linefst;
  String linesnd;
  int itemcount;
  String search;
  String fontsizeoption;
  String option;
  SurahText(
    this.fullsurahfst,
    this.fullsurahsnd,
    this.itemcount,
    this.lang,
    this.dropdownValue,
    this.search,
    this.fontsizeoption,
    this.option,
  );
  _SurahTextState createState() => _SurahTextState();
}

class _SurahTextState extends State<SurahText> {
  Map fonts = {
    "Small": 15,
    "Medium": 20,
    "Large": 25,
    "صغير": 15,
    "متوسط": 20,
    "كبير": 25,
  };
  String word;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(2 * size.height / 100);
    return Stack(

      children: [
        Container(
            height: size.height * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.green, width: 5),
                color: Color(0xffE5FFCC)),
            child: ListView.builder(
              itemCount: widget.itemcount,
              itemBuilder: (context, index) {
                return SurahContainer(
                    widget.fullsurahfst[index],
                    fonts[widget.dropdownValue] * size.height / 800,
                    widget.fullsurahsnd[index],
                    word,
                    index);
              },
            )),
        DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.2,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.green, width: 5),
                    color: Color(0xffE5FFCC)),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                            child: Text(
                          widget.option,
                          style: TextStyle(
                              fontSize: 20 * size.height / 800,
                              fontWeight: FontWeight.bold),
                        ))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.green, width: 5),
                              color: Color(0xffE5FFCC)),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.green),
                                padding: EdgeInsets.only(
                                    right: 10, bottom: 5, left: 5),
                                child: Text(
                                  widget.fontsizeoption,
                                  style: TextStyle(
                                    fontSize: 16 * size.height / 800,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 6),
                                child: DropdownButton<String>(
                                    value: widget.dropdownValue,
                                    underline: Container(
                                      height: 2,
                                      color: Colors.green,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        widget.dropdownValue = newValue;
                                      });
                                    },
                                    items: widget.lang.map((values) {
                                      return DropdownMenuItem<String>(
                                        child: Text(values),
                                        value: values,
                                      );
                                    }).toList()),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }
}

class SurahContainer extends StatelessWidget {
  String linefst;
  String linesnd;
  double fontsize;
  String word = "";
  int index;
  SurahContainer(
      this.linefst, this.fontsize, this.linesnd, this.word, this.index);
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
      child: RichText(
        text: TextSpan(children: [
          WidgetSpan(
              child: Center(
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: Text(
                              linefst,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: Text(""),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(right: 10, left: 20, top: 10),
                            child: Text(
                              linesnd,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Text(
                linefst,
                style: TextStyle(
                    fontSize: fontsize.toDouble(),
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          )),
          WidgetSpan(
              child: Divider(
            color: Colors.green,
          ))
        ]),
      ),
    );
  }
}
