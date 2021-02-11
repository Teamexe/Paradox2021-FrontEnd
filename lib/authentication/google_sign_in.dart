import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paradox/providers/api_authentication.dart';

// function to sign in with google
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
  ApiAuthentication().userIsPresent().then((value) => {
        if (value)
          {print('user already in database')}
        else
          {ApiAuthentication().createUser()}
      });
}

// function to logout
void logout() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.signOut();
  await googleSignIn.disconnect();
  await googleSignIn.signOut();
  return;
}
