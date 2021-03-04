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
import '../utilities/myBehaviour.dart';

class QuestionDisplay extends StatefulWidget {
  final List<Question> questList;
  final level;
  bool load = false;

  QuestionDisplay({this.questList, this.level});

  @override
  _QuestionDisplayState createState() => _QuestionDisplayState();
}

class _QuestionDisplayState extends State<QuestionDisplay> {
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
        : Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: size.height * 0.62,
              width: double.infinity,
              decoration: BoxDecoration(
                color: brightness == BrightnessOption.light
                    ? Colors.white
                    : Colors.grey[800],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Are you ready for',
                            style: TextStyle(
                              letterSpacing: 3,
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: brightness == BrightnessOption.dark
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Level $index!',
                            style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: brightness == BrightnessOption.dark
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ExpandedImageView(
                              image:
                                  '${widget.questList[index - 1].location}'),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 0.5,
                            ),
                          ],
                          image: DecorationImage(
                            repeat: ImageRepeat.noRepeat,
                            alignment: Alignment.center,
                            image: NetworkImage(
                                '${widget.questList[index - 1].location}'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        cursorHeight: 20,
                        cursorColor: Colors.black,
                        cursorWidth: 3,
                        autofocus: false,
                        controller: answerController,
                        decoration: InputDecoration(
                          hintText: 'Answer goes here',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: brightness == BrightnessOption.light
                                ? Colors.grey[600]
                                : Colors.white,
                          ),
                          fillColor: brightness == BrightnessOption.light
                              ? Colors.grey[100]
                              : Colors.grey,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[100]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                            borderSide: new BorderSide(
                                width: 2, color: Colors.grey[100]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white, width: 2)),
                        color: Colors.blue[600],
                        child: isLoading
                            ? SpinKitCircle(
                                color: Colors.white,
                                size: 30,
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
                                        .checkAnswer(answerController.text,
                                            user.level, id);
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
                                    createToast("Correct Answer");
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
                                Provider.of<LeaderBoardProvider>(context)
                                    .fetchAndSetLeaderBoard();
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
