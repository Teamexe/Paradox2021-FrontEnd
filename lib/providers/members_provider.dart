import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paradox/models/member.dart';
import 'package:paradox/utilities/constant.dart';
import 'package:http/http.dart';

/// Provider for Exe Members Details Using [ExeMemberProfile] model to store detail of particular uer
class ExeMembersProvider extends ChangeNotifier {
  List<ExeMemberProfile> developers;
  List<ExeMemberProfile> mentors;
  List<ExeMemberProfile> finalYear;
  List<ExeMemberProfile> coordinator;
  List<ExeMemberProfile> executive;
  List<ExeMemberProfile> volunteer;

  void clearList() {
    /// Clear all the lists
    [developers, mentors, finalYear, mentors, coordinator, executive, volunteer]
        .forEach((list) => list.clear());
  }

  void fetchAndSetExeMembers() async {
    /// URl to place request
    String url = "$baseUrl/exe-members/";

    /// Placing request to [url] to retrieve List of Exe Members
    Response response = await get(url);
    if (response.statusCode == 200) {
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
        if (exeMemberProfile.category == 'Developer') {
          developers.add(exeMemberProfile);
        } else if (exeMemberProfile.category == 'Mentor') {
          mentors.add(exeMemberProfile);
        } else if (exeMemberProfile.category == 'Final year') {
          finalYear.add(exeMemberProfile);
        } else if (exeMemberProfile.category == 'Coordinator') {
          coordinator.add(exeMemberProfile);
        } else if (exeMemberProfile.category == 'Executive') {
          executive.add(exeMemberProfile);
        } else {
          volunteer.add(exeMemberProfile);
        }

        /// Notifying Listeners
        notifyListeners();
      }
    } else {
      /// Throwing Exceptions in case of any response code other than 200 Status Ok.
      throw Exception("Cannot fetch members from backend.");
    }
  }
}
