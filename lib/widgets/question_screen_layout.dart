import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/models/question.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/photo_view.dart';
import 'package:paradox/screens/stageCompleted_screen.dart';
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
    final mediumList = Provider.of<QuestionProvider>(context).mediumList;
    final easyList = Provider.of<QuestionProvider>(context).easyList;
    final hardList = Provider.of<QuestionProvider>(context).hardList;
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;

    List<Question> checkList() {
      if (widget.level <= easyList.length) {
        print('1');
        return easyList;
      } else if (widget.level <= easyList.length + mediumList.length) {
        print('2');
        return [
          ...easyList,
          ...mediumList,
        ];
      } else {
        print('3');
        return [...easyList, ...mediumList, ...hardList];
      }
    }

    List<Question> tempList = checkList();

    int index = widget.level;
    bool loading = false;
    void displayDialog(
        {String title, String imgName, String text, Color color}) async {
      // int x = checkList().length;
      // int y = tempList.length;
      // if(tempList)
      setState(() {
        tempList = tempList;
      });

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
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
            ),
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
            answerController.text = "";
            FocusScope.of(context).unfocus();
            FocusScope.of(context).unfocus();
            answerController.clear();
            new TextEditingController().clear();
            Navigator.of(context).pop();
          },
        ),
      );
    }

    void displayDialogforHint(
        {String title, String imgName, String text, Color color, int level}) {
      showDialog(
        context: context,
        builder: (context) => loading
            ? SpinKitDualRing(color: Colors.blue)
            : NetworkGiffyDialog(
                image: Image.asset("assets/images/hint.gif"),
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
                buttonCancelText: Text("No",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                buttonOkText: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onCancelButtonPressed: () {
                  Navigator.of(context).pop();
                },
                onOkButtonPressed: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => SpinKitFadingGrid(
                            color: Colors.blue,
                          ));
                  try {
                    final resp =
                        await Provider.of<UserProvider>(context, listen: false)
                            .availHints();
                    if (resp == true) {
                      createToast("Hint successfully availed");
                    }
                    setState(() {
                      loading = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    createToast("Hint availed Successfully");
                  } catch (e) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    createToast(
                        "Please try again later. There was some issue.");
                  }
                },
              ),
      );
    }

    return (widget.level > tempList.length)
        ? StageCompleted()
        : Container(
            margin: EdgeInsets.only(
              top: 90,
              left: 20,
              right: 20,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SlimyCard(
                  color: brightness == BrightnessOption.light ?
                  Colors.white : Colors.grey[800],
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
                            Center(
                              // width: double.infinity,
                              child: Text(
                                'Are you Ready for',
                                style: TextStyle(
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: brightness == BrightnessOption.dark ? Colors.white : Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(height: 5),
                            Center(
                              // width: double.infinity,
                              child: Text(
                                'Level $index!',
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: brightness == BrightnessOption.dark ? Colors.white : Colors.grey,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ExpandedImageView(
                                        image:
                                            '${widget.questList[index - 1].location}')));
                              },
                              child: Container(
                                height: size.height * 0.3,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    repeat: ImageRepeat.noRepeat,
                                    alignment: Alignment.center,
                                    image: NetworkImage(
                                        '${widget.questList[index - 1].location}'),
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
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 40,
                              width: 280,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: answerController,
                                textAlignVertical: TextAlignVertical.center,
                                showCursor: true,
                                decoration: InputDecoration(
                                  hintText: 'Answer here',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  fillColor: brightness == BrightnessOption.light ? Colors.grey[200] : Colors.grey,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: new BorderSide(
                                        width: 2, color: brightness == BrightnessOption.light ? Colors.blueGrey : Colors.white60),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: new BorderSide(
                                        width: 2, color: brightness == BrightnessOption.light ? Colors.blueGrey : Colors.white60),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: ),
                            Container(
                              width: 150,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                        color: Colors.white, width: 2)),
                                color: Colors.blue[600],
                                child: isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SpinKitCircle(
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                onPressed: isLoading
                                    ? () {}
                                    : () async {
                                        if (answerController.text == null ||
                                            answerController.text == "") {
                                          createToast(
                                              "Please enter an answer to continue.");
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
                                                    user.level,
                                                    id);
                                        answerController.clear();
                                        if (body == null) {
                                          displayDialog(
                                            title: 'Incorrect Answer',
                                            imgName: 'wrong.gif',
                                            text: 'Retry!',
                                            color: Colors.red,
                                          );
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .updateAttempts();
                                        } else {
                                          if (user.level == tempList.length) {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    StageCompleted.routeName);
                                          } else {
                                            displayDialog(
                                              title: 'Correct Answer',
                                              imgName: 'right.gif',
                                              text: 'Next!',
                                              color: Colors.green,
                                            );
                                          }

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
                                        Provider.of<LeaderBoardProvider>(
                                                context)
                                            .fetchAndSetLeaderBoard();
                                      },
                              ),
                            ),
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
                        child: Consumer<UserProvider>(
                          builder: (ctx, provider, _) {
                            int hintNumber = provider.user.hintLevel;
                            return Column(
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
                                      child: Text(
                                          '${hintList[user.level - 1].hint1}',
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
                                      child: Text(
                                          '${hintList[user.level - 1].hint2}',
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
                                      child: Text(
                                          '${hintList[user.level - 1].hint3}',
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                              ],
                            );
                          },
                          child: Column(
                            children: [
                              if (user.hintLevel <= 0)
                                Container(
                                  width: double.infinity,
                                  child: FlatButton(
                                    onPressed: () async {
                                      if (user.hintLevel != 0) {
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
                              if (user.hintLevel >= 1)
                                Container(
                                  width: double.infinity,
                                  child: FlatButton(
                                    child: Text(
                                        '${hintList[user.level - 1].hint1}',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              Divider(),
                              if (user.hintLevel <= 1)
                                Container(
                                  width: double.infinity,
                                  child: FlatButton(
                                    onPressed: () {
                                      if (user.hintLevel != 1) {
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
                              if (user.hintLevel >= 2)
                                Container(
                                  width: double.infinity,
                                  child: FlatButton(
                                    child: Text(
                                        '${hintList[user.level - 1].hint2}',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              Divider(),
                              if (user.hintLevel <= 2)
                                Container(
                                  width: double.infinity,
                                  child: FlatButton(
                                    onPressed: () {
                                      if (user.hintLevel != 2) {
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
                              if (user.hintLevel >= 3)
                                Container(
                                  width: double.infinity,
                                  child: FlatButton(
                                    child: Text(
                                        '${hintList[user.level - 1].hint3}',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                            ],
                          ),
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
