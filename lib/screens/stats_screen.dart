import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/providers/stats_provider.dart';
import 'package:paradox/utilities/type_writer_text.dart';
import 'package:paradox/widgets/customCard.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  static String routeName = "stats-screen";

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    int question = Provider.of<StatsProvider>(context).totalQuestions;
    int users = Provider.of<StatsProvider>(context).totalUsers;
    int attempts = Provider.of<StatsProvider>(context).attempts;
    int answered = Provider.of<StatsProvider>(context).totalQuestionsAnswered;
    return Scaffold(
        appBar: AppBar(
          title: Text("Global Stats"),
        ),
        body: loading
            ? Center(
                child: SpinKitFadingGrid(
                  color: Colors.blue,
                  size: 80,
                ),
              )
            : SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      CustomCard2(
                          heading1: 'Users : $users',
                          imagePath: 'assets/images/user.jpg'),
                      CustomCard2(
                          heading1: 'Questions : $question',
                          imagePath: 'assets/images/question.jpeg'),
                      CustomCard2(
                          heading1: 'Attempts : $attempts',
                          imagePath: 'assets/images/attempts.jpg'),
                      CustomCard2(
                          heading1: 'Correctly Attempted : $answered',
                          imagePath: 'assets/images/correct_answer.jpg'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "This Page uses caching. It may take upto 5 minutes to update global stats.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    Future.delayed(Duration.zero, () async {
      try {
        await Provider.of<StatsProvider>(context, listen: false)
            .fetchAndSetStats();
        setState(() {
          loading = false;
        });
      } catch (e) {
        Navigator.of(context).pop();
      }
    });
  }
}
