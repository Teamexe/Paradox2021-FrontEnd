import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paradox/models/question.dart';
import 'package:paradox/utilities/constant.dart';

class QuestionProvider extends ChangeNotifier{
  List<Question> _questionList= [];

  List<Question> get questionList{
    return [..._questionList];
  }

  void fetchQuestions () async {
    String url = "${baseUrl}questions/";
    Response response = await get(url);
    var questions = jsonDecode(response.body);
    print(questions);

  }
}