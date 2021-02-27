import 'package:flutter/material.dart';
import 'package:paradox/models/member.dart';
import 'package:paradox/utilities/exe_member_dialog_box.dart';

class MemberCard extends StatelessWidget {
  final ExeMemberProfile exeMemberProfile;

  MemberCard(this.exeMemberProfile);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: FlatButton(
        onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(exeMemberProfile);
                });
        },
        child: Container(
            width: 120,
            height: 240,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                child: Image.network(
                  exeMemberProfile.image,
                  fit: BoxFit.cover,
                ),
              ),
            )),
      ),
    );
  }
}
