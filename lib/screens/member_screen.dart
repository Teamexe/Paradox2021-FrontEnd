import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/models/brightness_options.dart';
import 'package:paradox/providers/members_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:paradox/widgets/memberCard.dart';
import 'package:provider/provider.dart';

const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2, fontWeight: FontWeight.w400);

class MemberScreen extends StatefulWidget {
  static String routeName = "/member-screen";

  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  bool load = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        await Provider.of<ExeMembersProvider>(context, listen: false)
            .fetchAndSetExeMembers();
        setState(() {
          load = false;
        });
      } catch (e) {
        createToast("There is some error. Please try again later");
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<ExeMembersProvider>(context);
    print(members.developers);
    final brightness = Provider.of<ThemeProvider>(context).brightnessOption;
    bool alumniListNotEmpty = members.alumni.length != 0,
        finalListNotEmpty = members.finalYear.length != 0,
        preFinalListNotEmpty = members.preFinal.length != 0,
        developersListNotEmpty  = members.developers.length != 0,
        execListNotEmpty = members.executive.length != 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('members'.toUpperCase(),
          style: TextStyle(
            fontWeight: brightness == BrightnessOption.light ? FontWeight.w400 : FontWeight.w300,
            letterSpacing: 2,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Container(
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
      backgroundColor: brightness == BrightnessOption.light ? Colors.blue : Colors.grey[800],
      body: load
          ? SpinKitFoldingCube(
              color: Colors.white,
            )
          : SafeArea(
              child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        if (members.alumni.length != 0)
                          Text("Alumni", style: textStyle),
                        if (members.alumni.length != 0)
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return MemberCard(members.alumni[index]);
                                },
                                itemCount: members.alumni.length),
                          ),
                        if (alumniListNotEmpty)
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider()
                          ),
                        if (alumniListNotEmpty)
                          SizedBox(height: 10),
                        if (members.finalYear.length != 0)
                          Text("Final Year", style: textStyle),
                        if (members.finalYear.length != 0)
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return MemberCard(members.finalYear[index]);
                                },
                                itemCount: members.finalYear.length),
                          ),
                        if (finalListNotEmpty)
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider()
                          ),
                        if (finalListNotEmpty)
                          SizedBox(height: 10),
                        if (members.preFinal.length != 0)
                          Text("Pre Final Year", style: textStyle),
                        if (members.preFinal.length != 0)
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return MemberCard(members.preFinal[index]);
                                },
                                itemCount: members.preFinal.length),
                          ),
                        if (preFinalListNotEmpty)
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider()
                          ),
                        if (preFinalListNotEmpty)
                          SizedBox(height: 10),
                        if (members.developers.length != 0)
                          Container(
                            child: Text(
                              "Developers",
                              style: textStyle,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        if (members.developers.length != 0)
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return MemberCard(members.developers[index]);
                                },
                                itemCount: members.developers.length),
                          ),
                        if (developersListNotEmpty)
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider()
                          ),
                        if (developersListNotEmpty)
                          SizedBox(height: 10),
                        if (members.executive.length != 0)
                          Text("Executive Members", style: textStyle),
                        if (members.executive.length != 0)
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return MemberCard(members.executive[index]);
                                },
                                itemCount: members.executive.length),
                          ),
                        if (execListNotEmpty)
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider()
                          ),
                        if (execListNotEmpty)
                          SizedBox(height: 10),
                        if (members.volunteer.length != 0)
                          Text("Volunteers", style: textStyle),
                        if (members.volunteer.length != 0)
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return MemberCard(members.volunteer[index]);
                                },
                                itemCount: members.volunteer.length),
                          ),
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
                          center: FractionalOffset(.1, .6)
                      ).createShader(rect);
                    },
                    child: child,
                  );
                },
              ),
            ),
    );
  }
}
