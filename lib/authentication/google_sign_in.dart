import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<void> signInWithGoogle() async  {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  // ignore: deprecated_member_use
  final AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
  );

  final authResult = await firebaseAuth.signInWithCredential(authCredential);
  final user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  // ignore: deprecated_member_use
  final FirebaseUser currentUser = firebaseAuth.currentUser;
  assert(user.uid == currentUser.uid);

  print('Signed In Successfully');

}

void logout() async {
  await googleSignIn.disconnect();
  firebaseAuth.signOut();
  print('signed out');
}