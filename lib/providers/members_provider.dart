import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paradox/models/member.dart';
import 'package:paradox/utilities/constant.dart';
import 'package:http/http.dart';

/// Provider for Exe Members Details Using [ExeMemberProfile] model to store detail of particular uer
class ExeMembersProvider extends ChangeNotifier {
  List<ExeMemberProfile> developers = [];
  List<ExeMemberProfile> mentors = [];
  List<ExeMemberProfile> finalYear = [];
  List<ExeMemberProfile> coordinator = [];
  List<ExeMemberProfile> executive = [];
  List<ExeMemberProfile> volunteer = [];
  List<ExeMemberProfile> preFinal = [];

  void clearList() {
    /// Clear all the lists
    [
      developers,
      mentors,
      finalYear,
      mentors,
      coordinator,
      executive,
      volunteer,
      preFinal
    ].forEach((list) => list.clear());
  }

  Future<void> fetchAndSetExeMembers() async {
    /// URl to place request
    String url = "${baseUrl}exe-members/";

    /// Placing request to [url] to retrieve List of Exe Members
    Response response = await get(url);
    print(response.body);
    if (response.statusCode == 200) {
      try {
        /// Decoding Response received
        var members = jsonDecode(response.body);

        /// Clearing Lists to prevent duplication
        clearList();

        /// Loop Over All the members received and add them in respective List based on Position.
        for (var member in members) {
          final ExeMemberProfile exeMemberProfile = new ExeMemberProfile(
              id: member['id'],
              name: member['name'],
              position: member['position'],
              category: member['category'],
              image: member['image'],
              githubUrl: member['githubUrl'],
              linkedInUrl: member['linkedInUrl']);
          if (exeMemberProfile.position == 'Developer') {
            developers.add(exeMemberProfile);
          } else if (exeMemberProfile.position == 'Mentor') {
            mentors.add(exeMemberProfile);
          } else if (exeMemberProfile.position == 'Final year') {
            finalYear.add(exeMemberProfile);
          } else if (exeMemberProfile.position == 'Coordinator') {
            coordinator.add(exeMemberProfile);
          } else if (exeMemberProfile.position == 'Executive') {
            executive.add(exeMemberProfile);
          } else if (exeMemberProfile.position == 'Pre-Final year') {
            preFinal.add(exeMemberProfile);
          } else {
            volunteer.add(exeMemberProfile);
          }

          /// Notifying Listeners
          notifyListeners();
        }
      } catch (e) {
        print(e);
      }
    } else {
      /// Throwing Exceptions in case of any response code other than 200 Status Ok.
      throw Exception("Cannot fetch members from backend.");
    }
  }
}
