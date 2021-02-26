import 'package:flutter/material.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

import '../utilities/myBehaviour.dart';

class QuestionPageLayout extends StatefulWidget {

  @override
  _QuestionPageLayoutState createState() => _QuestionPageLayoutState();
}

class _QuestionPageLayoutState extends State<QuestionPageLayout> {
    @override
  Widget build(BuildContext context) {
    final questionData = Provider.of<QuestionProvider>(context);
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top:100,left: 20,right: 20, bottom: 60),
      child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SlimyCard(
                color: Colors.white,
                width: size.width *0.9,
                topCardHeight: size.height *0.55,
                bottomCardHeight: size.height *0.15,
                borderRadius: 15,
                topCardWidget: questionCard(size),
                bottomCardWidget: hintCard(size),
              ),
            ],
          ),
    );
  }
}

// This widget will be passed as Top Card's Widget.
Widget questionCard(Size size) {
  return Container(
    child: ScrollConfiguration (
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
                child: Text('Are you Ready for',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
            ),
            Container(
              width: double.infinity,
              child: Text('Level xX!',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              height: size.height *0.3,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://wallpaperaccess.com/full/1119651.jpg'),
                  fit: BoxFit.contain,

                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius:10,
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
                showCursor: true,
                decoration: InputDecoration(
                  hintText: 'Answer here',
                  hintStyle: TextStyle(fontSize: 14,),
                  fillColor: Colors.grey[200],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide:
                    new BorderSide(width: 1, color: Colors.blueGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide:
                    new BorderSide(width: 1, color: Colors.grey[200]),
                  ),
                  ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
              color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue[900])
              ),
              height: 25,
              child: FlatButton(
                 onPressed: (){ },
                  child: Text('Submit',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// This widget will be passed as Bottom Card's Widget.
Widget hintCard(Size size) {
  return ScrollConfiguration(
    behavior: MyBehavior(),
    child: SingleChildScrollView(
      child: Container(
        child: Column(children: [
          Container(
            width: double.infinity,
              height: 20,
              child: FlatButton(onPressed: (){},
                  child: Text('First Hint      30 - coins',textAlign: TextAlign.center),
              ),
          ),
          Container(
            width: double.infinity,
            height: 20,
            child: FlatButton(onPressed: (){},
              child: Text('Second Hint  30 - coins',textAlign: TextAlign.center),
            ),
          ),
          Container(
            width: double.infinity,
            height: 20,
            child: FlatButton(onPressed: (){},

              child: Text('Third Hint      40 - coins',textAlign: TextAlign.center,),
            ),
          ),
        ],)
      ),
    ),
  );
}
