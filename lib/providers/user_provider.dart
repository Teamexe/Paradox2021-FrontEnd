import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paradox/models/user.dart' as UserModel;
import 'package:paradox/providers/api_authentication.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/utilities/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  /// Instance of [User] for currently loggedIn User.
  UserModel.User user;
  bool loadedProfile = false;

  /// Create new [User] and assign it to [user].
  Future<void> assignUser(String uid, String email, String name) async {
    this.user = new UserModel.User(email: email, uid: uid, name: name);
    return;
  }

  /// This function creates new User in the backend.
  Future<void> createUser(String uid, String email, String displayName) async {
    final String postUrl = "${baseUrl}user/";

    /// Sending Request to backend with [google_id], [name], [email] to create new User.
    Response postResponse = await post(
      postUrl,
      body: jsonEncode(<String, String>{
        'google_id': uid,
        'name': displayName,
        'email': email
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (postResponse.statusCode == 201) {
      var body = jsonDecode(postResponse.body);

      /// Response Body contains a field [ref_code] assigning it to ref_code of [user].
      user.referralCode = body['ref_code'];
      notifyListeners();
    } else if (postResponse.statusCode == 400) {
      print('some error');
    }
  }

  /// This function is used to fetch details of User from backend and assign it to user.
  Future<void> fetchUserDetails() async {
    if (user.uid == null) {
      return;
    }
    if (loadedProfile == false) {
      String url = "${baseUrl}userProfile/${user.uid}/";
      Response response = await get(url);
      if (response.statusCode == 200) {
        var userProfile = jsonDecode(response.body);
        this.user.referralCode = userProfile['ref_code'];
        this.user.level = userProfile['profile']['level'];
        this.user.score = userProfile['profile']['level'];
        this.user.coins = userProfile['profile']['coins'];
        this.user.attempts = userProfile['profile']['attempts'];
        this.user.referralAvailed = userProfile['profile']['refferral_availed'];
        notifyListeners();
      }
      return;
    }
    loadedProfile = true;
    notifyListeners();
  }

  /// Check whether a present in backend or not using the uid provided by firebase on authentication.
  Future<bool> userIsPresent() async {
    try {
      final String getUrl = "${baseUrl}user-present-or-not/${user.uid}";
      Response getResponse = await get(getUrl);
      if (getResponse.statusCode == 404) {
        return false;
      } else if (getResponse.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  /// function to sign in with google
  Future<void> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    // ignore: deprecated_member_use
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return;
    }
    await ApiAuthentication().userIsPresent().then((value) async => {
          if (value)
            {print('user already in database')}
          else
            {await ApiAuthentication().createUser()}
        });
  }

  /// function to logout
  void logout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    this.user = null;
    return;
  }
  ///update user level,coins and referral availed
  void updateData({int level, int coins, bool referral = false}) {
    this.user.level = level;
      this.user.score = level;
      this.user.coins = coins;
      this.user.referralAvailed = referral;
      notifyListeners();
  }

  String getUserName() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = firebaseAuth.currentUser;
    return user.displayName;
  }

  String getUserEmail() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = firebaseAuth.currentUser;
    return user.email;
  }

  String getUserProfileImage() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = firebaseAuth.currentUser;
    return user.photoURL;
  }
  String getUserId() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = firebaseAuth.currentUser;
    return user.uid;
  }

}
