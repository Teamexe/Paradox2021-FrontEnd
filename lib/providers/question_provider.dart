import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paradox/models/hint.dart';
import 'package:paradox/models/question.dart';
import 'package:paradox/utilities/constant.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> easyList =[];
  List<Question> mediumList =[];
  List<Question> hardList =[];
  void clearList() {
    /// Clear all the lists
    [
      easyList,
      mediumList,
      hardList,
    ].forEach((list) => list.clear());
  }

  List<Question> _questionList = [];
  bool loaded = false;
  bool loadedHints = false;

  List<Question> get questionList {
    return _questionList;
  }

  List<Hint> _hintsList = [];

  List<Hint> get hintsList {
    return [..._hintsList];
  }

  Future<void> fetchQuestions() async {
    String url = "${baseUrl}questions/";
    Response response = await get(url);
    if (response.statusCode == 200) {
      _questionList.clear();
      clearList();
      var data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        _questionList.add(Question(
          level: data[i]['level'],
          location: data[i]['location'],
          difficulty: data[i]['category'],
        ));
        if(_questionList[i].difficulty == 'Easy'){
          easyList.add(_questionList[i]);
        } else  if(_questionList[i].difficulty == 'Medium'){
          mediumList.add(_questionList[i]);
        }else  if(_questionList[i].difficulty == 'Hard'){
          hardList.add(_questionList[i]);
        }
      }

      notifyListeners();
    } else {
      throw Exception();
    }
    loaded = true;
    return;
  }



 Future<void> fetchHints() async {
    if (loadedHints == false) {

      String url = "${baseUrl}hints/";
      Response response = await get(url);
      if (response.statusCode == 200) {
        _hintsList.clear();
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          _hintsList.add(Hint(
            level: data[i]['level'],
            hint1: data[i]['hint1'],
            hint2: data[i]['hint2'],
            hint3: data[i]['hint3'],
          ));
        }
        notifyListeners();
      } else {
        throw Exception();
      }
    loadedHints = true;
    return;
  }}

  Future<dynamic> checkAnswer(String answer, int level, String uid) async {
    String url = "${baseUrl}check-answer/";
    print(
      jsonEncode(<String, dynamic>{
        'answer': answer,
        'google_id': uid,
        'level': level
      }),
    );
    try {
      Response response = await post(
        url,
        body: jsonEncode(<String, dynamic>{
          'answer': answer.toLowerCase(),
          'google_id': uid,
          'level': level
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        return null;
      } else if (response.statusCode == 500) {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }

    // notifyListeners();
  }
}
