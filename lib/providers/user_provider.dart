import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paradox/models/user.dart' as UserModel;
import 'package:paradox/providers/api_authentication.dart';
import 'package:paradox/utilities/Toast.dart';
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
    String url = "${baseUrl}userProfile/${user.uid}/";
    Response response = await get(url);
    if (response.statusCode == 200) {
      var userProfile = jsonDecode(response.body);
      this.user.referralCode = userProfile['ref_code'];
      this.user.level = userProfile['profile']['level'];
      this.user.score = userProfile['profile']['score'];
      this.user.coins = userProfile['profile']['coins'];
      this.user.attempts = userProfile['profile']['attempts'];
      this.user.referralAvailed = userProfile['profile']['refferral_availed'];
      this.user.hintLevel = userProfile['hint']['hintNumber'];
      loadedProfile = true;
      notifyListeners();
    } else {
      loadedProfile = false;
    }
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
    this.user.score += 10 ;
    this.user.coins = coins;
    this.user.referralAvailed = referral;
    this.user.hintLevel = 0;
    notifyListeners();
  }
  void updateData2({int coins, bool referral = false}) {
    this.user.coins += coins;
    this.user.referralAvailed = referral;
    notifyListeners();
  }

  Future<dynamic> availHints() async {
    String url = "${baseUrl}avail-hints/";
    try {
      Response response = await post(url,
          body: jsonEncode(<String, dynamic>{
            'google_id': FirebaseAuth.instance.currentUser.uid,
            'level': this.user.level,
            'hint': this.user.hintLevel + 1
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        this.user.hintLevel = this.user.hintLevel + 1;
        this.user.coins = body['coins'];
        notifyListeners();
        return body;

      } else {
        final body = jsonDecode(response.body);
        createToast(body['message']);
        return null;
      }
    } catch (e) {

      createToast("There was some error. Please try again later.");
      throw Exception();
    }
  }

  Future<dynamic> updateUserImage() async {
    try {
      Response response = await post("${baseUrl}update-photo/",
          body: jsonEncode(<String, dynamic>{
            "google_id": FirebaseAuth.instance.currentUser.uid,
            "image": FirebaseAuth.instance.currentUser.photoURL
                .replaceAll("s96-c/photo.jpg", "s400-c/photo.jpg")
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
    } catch (e) {}
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

  void updateAttempts() {
    this.user.attempts += 1;
    notifyListeners();
  }
}
