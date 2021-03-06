import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/stats_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:paradox/widgets/customCard.dart';
import 'package:paradox/widgets/no_data_connection.dart';
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
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Global Stats".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: brightness == BrightnessOption.dark
                ? FontWeight.w300
                : FontWeight.w400,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: AbsorbPointer(
          absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
          child: Opacity(
            opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        actions: [
          loading
              ? Center(
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 35,
                  ),
                )
              : AbsorbPointer(
                absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
                child: Opacity(
                  opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
                  child: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      onPressed: loading
                          ? null
                          : () async {
                              setState(() {
                                loading = true;
                              });
                              try {
                                await Provider.of<StatsProvider>(context,
                                        listen: false)
                                    .fetchAndSetStats();
                              } catch (e) {
                                createToast(
                                    "There was some error. Please try again later");
                              } finally {
                                setState(() {
                                  loading = false;
                                });
                              }
                            }),
                ),
              )
        ],
      ),
      body: loading
          ? Center(
              child: SpinKitFadingGrid(
                color: Colors.blue,
                size: 80,
              ),
            )
          : Stack(
            children: [
              AbsorbPointer(
                absorbing: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? true : false,
                child: Opacity(
                  opacity: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected ? 0.2 : 1,
                  child: TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      child: SafeArea(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomCard2(
                                  heading1: 'Total Users : $users',
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
                            ],
                          ),
                        ),
                      ),
                      duration: Duration(milliseconds: 1000),
                      builder: (ctx, value, child) {
                        return ShaderMask(
                          shaderCallback: (rect) {
                            return RadialGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white,
                                      Colors.transparent,
                                      Colors.transparent
                                    ],
                                    radius: value * 5,
                                    stops: [0.0, .55, .66, 1.0],
                                    center: FractionalOffset(.1, .6))
                                .createShader(rect);
                          },
                          child: child,
                        );
                      },
                    ),
                ),
              ),
              Visibility(
                visible: Provider.of<DataConnectionStatus>(context) == DataConnectionStatus.disconnected,
                child: NoDataConnectionWidget(),
              ),
            ],
          ),
    );
  }

  @override
  void initState() {
    super.initState();
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
