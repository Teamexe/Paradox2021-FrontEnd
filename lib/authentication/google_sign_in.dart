import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paradox/providers/api_authentication.dart';

final googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// function to sign in with google
Future<void> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  // ignore: deprecated_member_use
  final AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
  );

  final authResult = await firebaseAuth.signInWithCredential(authCredential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = firebaseAuth.currentUser;
  assert(user.uid == currentUser.uid);

  ApiAuthentication().userIsPresent().then((value) => {
    if (value) {
      print('user already in database')
    } else {
      ApiAuthentication().createUser()
    }
  });

}

// function to logout
void logout() async {
  await googleSignIn.disconnect();
  firebaseAuth.signOut();
  print('signed out');
}