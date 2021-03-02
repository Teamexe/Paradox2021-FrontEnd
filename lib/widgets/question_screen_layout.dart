import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:paradox/models/question.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/question_screen.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

import '../utilities/myBehaviour.dart';

class QuestionPageLayout extends StatefulWidget {
  final List<Question> questList;
  final level;
  bool load = false;

  QuestionPageLayout({this.questList, this.level});

  @override
  _QuestionPageLayoutState createState() => _QuestionPageLayoutState();
}

class _QuestionPageLayoutState extends State<QuestionPageLayout> {
  var answerController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final id = Provider.of<UserProvider>(context).getUserId();
    final hintList = Provider.of<QuestionProvider>(context).hintsList;
    final user = Provider.of<UserProvider>(context).user;
    final hintNumber =
        Provider.of<UserProvider>(context, listen: true).user.hintLevel;
    int index = widget.level;
    void displayDialog(
        {String title, String imgName, String text, Color color}) async {
      await showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
          image: Image.asset(
            "assets/images/$imgName",
            height: double.infinity,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
          ),
          description: Text(
            'Press $text to continue',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          onlyOkButton: true,
          buttonOkColor: color,
          entryAnimation: EntryAnimation.RIGHT,
          buttonOkText:
              Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
          onOkButtonPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      );
    }

    void displayDialogforHint(
        {String title, String imgName, String text, Color color, int level}) {
      showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
          image: Image.network(
              "https://media.giphy.com/media/gH94kBTHmFum6aMYzu/giphy.gif"),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
          ),
          description: Text(
            'Press $text to continue',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          buttonOkColor: Colors.blue,
          buttonCancelColor: color,
          entryAnimation: EntryAnimation.RIGHT,
          buttonCancelText:
              Text("No", style: TextStyle(color: Colors.white, fontSize: 18)),
          buttonOkText:
              Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
          onCancelButtonPressed: () {
            Navigator.of(context).pop();
          },
          onOkButtonPressed: () async {
            final resp = await Provider.of<UserProvider>(context, listen: false)
                .availHints();
            if (resp == true) {
              createToast("Hint successfully availed");
            }
            Navigator.of(context).pop();
          },
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(
        top: 100,
        left: 20,
        right: 20,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SlimyCard(
            color: Colors.white,
            width: size.width * 0.9,
            topCardHeight: size.height * 0.55,
            bottomCardHeight: size.height * 0.15,
            borderRadius: 15,
            topCardWidget: Container(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Are you Ready for',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Level ${index}!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: size.height * 0.3,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            repeat: ImageRepeat.noRepeat,
                            alignment: Alignment.center,
                            image: NetworkImage(
                                '${widget.questList[index].location}'),
                            fit: BoxFit.contain,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 40,
                        width: 300,
                        child: TextField(
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          showCursor: true,
                          onChanged: (value) {
                            answerController.text = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Answer here',
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                            fillColor: Colors.grey[200],
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: new BorderSide(
                                  width: 1, color: Colors.blueGrey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: new BorderSide(
                                  width: 1, color: Colors.grey[200]),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: isLoading
                            ? SpinKitCircle(
                                color: Colors.blue[600],
                                size: 30,
                              )
                            : MaterialButton(
                                height: 25,
                                color: Colors.blue[800],
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () async {
                                  if (answerController.text == null ||
                                      answerController.text == "") {
                                    createToast("Please Enter a answer");
                                    return;
                                  }
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var body =
                                      await Provider.of<QuestionProvider>(
                                              context,
                                              listen: false)
                                          .checkAnswer(
                                              answerController.text,
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .user
                                                  .level,
                                              id);
                                  answerController.clear();
                                  if (body == null) {
                                    await displayDialog(
                                      title: 'Incorrect Answer',
                                      imgName: 'wrong.gif',
                                      text: 'Retry!',
                                      color: Colors.red,
                                    );
                                  } else {
                                    displayDialog(
                                      title: 'Correct Answer',
                                      imgName: 'right.gif',
                                      text: 'Next!',
                                      color: Colors.green,
                                    );
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .updateData(
                                      level: body['level'],
                                      coins: body['coins'],
                                    );
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                              ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(color: Colors.blue[900])),
                      //   height: 25,
                      //   child: FlatButton(
                      //     onPressed: () async {
                      //                                   setState(() {
                      //                                     isLoading = true;
                      //                                   });
                      //                                   var body =
                      //                                       await Provider.of<QuestionProvider>(
                      //                                               context,
                      //                                               listen: false)
                      //                                           .checkAnswer(
                      //                                               answerController.text,
                      //                                               widget.questList[index].level,
                      //                                               id);
                      //                                   answerController.clear();
                      //                                   if (body == null) {
                      //                                     displayDialog(
                      //                                         title: 'Incorrect Answer',
                      //                                         imgName: 'wrong.gif',
                      //                                         text: 'Retry!',color: Colors.red,);
                      //                                   } else {
                      //                                     displayDialog(
                      //                                         title: 'Correct Answer',
                      //                                         imgName: 'right.gif',
                      //                                         text: 'Next!',color: Colors.green,);
                      //                                     Provider.of<UserProvider>(context,
                      //                                             listen: false)
                      //                                         .updateData(
                      //                                       level: body['level'],
                      //                                       coins: body['coins'],
                      //                                     );
                      //                                     setState(() {
                      //                                       index++;
                      //                                     });
                      //                                   }
                      //                                   setState(() {
                      //                                     isLoading = false;
                      //                                   });
                      //     child: Text(
                      //       'Submit',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            bottomCardWidget: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      if (hintNumber <= 0)
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: () async {
                              if (hintNumber != 0) {
                                createToast(
                                    "Please Avail Previous Hint First.");
                                return;
                              }
                              displayDialogforHint(
                                  title:
                                      'Are you sure you want to Retrieve hint 1?',
                                  imgName: 'hint.gif',
                                  text: 'Yes',
                                  color: Colors.red);
                            },
                            child: Text('Avail Hint 1 for 20 - coins',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      if (hintNumber >= 1)
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text('${hintList[user.level - 1].hint1}',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      Divider(),
                      if (hintNumber <= 1)
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              if (hintNumber != 1) {
                                createToast(
                                    "Please Avail Previous Hint First.");
                                return;
                              }
                              displayDialogforHint(
                                title:
                                    'Are you sure you want to Retrieve hint 2?',
                                imgName: 'wrong.gif',
                                text: 'Yes',
                                color: Colors.red,
                              );
                            },
                            child: Text('Avail Hint 2 for 30 - coins',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      if (hintNumber >= 2)
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text('${hintList[user.level - 1].hint2}',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      Divider(),
                      if (hintNumber <= 2)
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              if (hintNumber != 2) {
                                createToast(
                                    "Please Avail Previous Hint First.");
                                return;
                              }
                              displayDialogforHint(
                                title:
                                    'Are you sure you want to Retrieve hint 3?',
                                imgName: 'wrong.gif',
                                text: 'Yes',
                                color: Colors.red,
                              );
                            },
                            child: Text('Avail Hint 3 for 40 - coins',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      Divider(),
                      if (hintNumber >= 3)
                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text('${hintList[user.level - 1].hint3}',
                                textAlign: TextAlign.center),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
