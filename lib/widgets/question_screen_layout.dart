import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:paradox/models/question.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

import '../utilities/myBehaviour.dart';

class QuestionPageLayout extends StatefulWidget {
  final List<Question> questList;
  QuestionPageLayout(this.questList);
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
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final id = Provider.of<UserProvider>(context).getUserId();
    final hintList = Provider.of<QuestionProvider>(context).hintsList;
    void displayDialog({String title, String imgName, String text,Color color}) {
      showDialog(
          context: context,
          builder: (_) => AssetGiffyDialog(
                image: Image.asset("assets/images/$imgName",height: double.infinity,),
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
                buttonOkText: Text(text,style:TextStyle(color: Colors.white,fontSize: 18)),
                onOkButtonPressed: () {
                  Navigator.pop(context);
                },
              ));
    }

    return Container(
      margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 60),
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
                          'Level ${widget.questList[index].level}!',
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
                        width: 120,
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
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var body =
                                      await Provider.of<QuestionProvider>(
                                              context,
                                              listen: false)
                                          .checkAnswer(
                                              answerController.text,
                                              widget.questList[index].level,
                                              id);
                                  answerController.clear();
                                  if (body == null) {
                                    displayDialog(
                                        title: 'Incorrect Answer',
                                        imgName: 'wrong.gif',
                                        text: 'Retry!',color: Colors.red,);
                                  } else {
                                    displayDialog(
                                        title: 'Correct Answer',
                                        imgName: 'right.gif',
                                        text: 'Next!',color: Colors.green,);
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
                      //     onPressed: () {
                      //       setState(() {
                      //         index++;
                      //       });
                      //     },
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
                      Container(
                        width: double.infinity,
                        height: 20,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text('${hintList[index].hint1} 30 - coins',
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 20,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text('${hintList[index].hint2} 30 - coins',
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 20,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            '${hintList[index].hint3}  40 - coins',
                            textAlign: TextAlign.center,
                          ),
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
