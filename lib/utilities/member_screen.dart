import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paradox/providers/members_provider.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:paradox/widgets/memberCard.dart';
import 'package:provider/provider.dart';

const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 22);

class MemberScreen extends StatefulWidget {
  static String routeName = "/member-screen";

  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  bool load = true;

  @override
  void initState() {
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
    return Scaffold(
      backgroundColor: Colors.blue,
      body: load
          ? SpinKitFoldingCube(
              color: Colors.white,
            )
          : SafeArea(
              child: Container(
                child: Column(
                  children: [
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
                    // if (members.mentors.length != 0)
                    //   Text("Mentors", style: textStyle),
                    // if (members.mentors.length != 0)
                    //   ListView.builder(
                    //     itemBuilder: (ctx, index) {
                    //       return MemberCard(members.mentors[index]);
                    //     },
                    //     itemCount: members.volunteer.length,
                    //   ),
                    // if (members.finalYear.length != 0)
                    //   Text("Final Year", style: textStyle),
                    // if (members.finalYear.length != 0)
                    //   ListView.builder(
                    //     itemBuilder: (ctx, index) {
                    //       return MemberCard(members.finalYear[index]);
                    //     },
                    //     itemCount: members.volunteer.length,
                    //   ),
                    // if (members.coordinator.length != 0)
                    //   Text("Coordinator", style: textStyle),
                    // if (members.coordinator.length != 0)
                    //   ListView.builder(
                    //     itemBuilder: (ctx, index) {
                    //       return MemberCard(members.coordinator[index]);
                    //     },
                    //     itemCount: members.volunteer.length,
                    //   ),
                    // if (members.executive.length != 0)
                    //   Text("Executive Members", style: textStyle),
                    // if (members.executive.length != 0)
                    //   ListView.builder(
                    //     itemBuilder: (ctx, index) {
                    //       return MemberCard(members.executive[index]);
                    //     },
                    //     itemCount: members.volunteer.length,
                    //   ),
                    // if (members.developers.length != 0)
                    //   Text("Volunteers", style: textStyle),
                    // if (members.volunteer.length != 0)
                    //   Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (ctx, index) {
                    //         return MemberCard(members.volunteer[index]);
                    //       },
                    //       itemCount: members.volunteer.length,
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
    );
  }
}
