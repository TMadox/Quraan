import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'SurahList.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(Firstmenu());
}

class Firstmenu extends StatefulWidget {
  @override
  _FirstmenuState createState() => _FirstmenuState();
}

class _FirstmenuState extends State<Firstmenu> {
  List dua = [
    "اللهم ارحمني بالقرءان واجعله لي إماما ونورا وهدى ورحمة *",
    "اللهم ذكرني منه مانسيت وعلمني منه ماجهلت وارزقني تلاوته آناء الليل وأطراف النهار واجعله لي حجة يارب العالمين *",
    "اللهم ذكرني منه مانسيت وعلمني منه ماجهلت وارزقني تلاوته آناء الليل وأطراف النهار واجعله لي حجة يارب العالمين *",
    "للهم اجعل خير عمري آخره وخير عملي خواتمه وخير أيامي يوم ألقاك فيه *",
    "اللهم إني أسألك عيشة هنية وميتة سوية ومردا غير مخز ولا فاضح *",
    "اللهم إني أسألك خير المسألة وخير الدعاء وخير النجاح وخير العلم وخير العمل وخير الثواب وخير الحياة وخير الممات وثبتني وثقل موازيني وحقق إيماني وارفع درجتي وتقبل صلاتي واغفر خطيئاتي وأسألك العلا من الجنة *",
    "اللهم إني أسألك موجبات رحمتك وعزائم مغفرتك والسلامة من كل إثم والغنيمة من كل بر والفوز بالجنة والنجاة من النار *",
    "اللهم أحسن عاقبتنا في الأمور كلها، وأجرنا من خزي الدنيا وعذاب الآخرة *",
    "اللهم اقسم لنا من خشيتك ماتحول به بيننا وبين معصيتك ومن طاعتك ماتبلغنا بها جنتك ومن اليقين ماتهون به علينا مصائب الدنيا ومتعنا بأسماعنا وأبصارنا وقوتنا ماأحييتنا واجعله الوارث منا واجعل ثأرنا على من ظلمنا وانصرنا على من عادانا ولا تجعل مصيبتنا في ديننا ولا تجعل الدنيا أكبر همنا ولا مبلغ علمنا ولا تسلط علينا من لا يرحمنا *",
    "للهم لا تدع لنا ذنبا إلا غفرته ولا هما إلا فرجته ولا دينا إلا قضيته ولا حاجة من حوائج الدنيا والآخرة إلا قضيتها ياأرحم الراحمين *",
    "ربنا آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار وصلى الله على سيدنا ونبينا محمد وعلى آله وأصحابه الأخيار وسلم تسليما كثيرا."
  ];
  Map surah;
  Map temp;
  Random random = new Random();
  int randomsurah;
  int randomaiah;
  int length;
  var surahsen = [];
  var surahar = [];
  void randomize() {
    randomsurah = random.nextInt(114);
  }

  Future loadfromasset(int target) async {
    String jsonString = await rootBundle
        .loadString("assets/translation/en/en_translation_$target.json");
    surah = await jsonDecode(jsonString);
    temp = surah["verse"];
    temp.forEach((key, value) {
      surahsen.add(temp[key]);
    });
    jsonString = await rootBundle.loadString("assets/surah/surah_$target.json");
    surah = await jsonDecode(jsonString);
    temp = surah["verse"];
    temp.forEach((key, value) {
      surahar.add(temp[key]);
    });
    return surahar.length;
  }

  void initState() {
    super.initState();
    randomize();
  }

  String dropdownValue = 'One';
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("ISLAMISM")),
            backgroundColor: Colors.green,
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                children: [
                  Container(
                    child: FlatButton(
                        onPressed: () {
                          Widget setupAlertDialoadContainer() {
                            return Container(
                              height: 300.0, // Change as per your requirement
                              width: 300.0, // Change as per your requirement
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: dua.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(
                                      dua[index],
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
                                  content: setupAlertDialoadContainer(),
                                );
                              });
                        },
                        child: Text(
                          "دعاء حفظ القران",
                          style: TextStyle(fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Thequaraan(),
                  SizedBox(
                    height: 50,
                  ),
                  FutureBuilder(
                      future: loadfromasset(randomsurah),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(child: Text("Loading")),
                          );
                        }
                        randomaiah =
                            2 + random.nextInt((snapshot.data - 1) - 2);

                        return Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 15, left: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.green, width: 5),
                                    color: Color(0xffE5FFCC)),
                                child: Text(
                                  surahar[randomaiah],
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.green, width: 5),
                                    color: Color(0xffE5FFCC)),
                                child: Text(
                                  surahsen[randomaiah],
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          )),
    );
  }
}

class Thequaraan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      onTap: () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => SurahList()));
      },
      child: Card(
        elevation: 20,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset("assets/Images/quran-icon-png-8820.png"),
            SizedBox(
              height: 25,
              child: Container(
                padding: EdgeInsets.fromLTRB(64, 0, 64, 0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Qur'aan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
