import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hover_effect/hover_effect.dart';
import '../authentication/google_sign_in.dart';
import '../screens/home_screen.dart';

class SignIn extends StatelessWidget {
  static String routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SignInWidget(),
    );
  }
}

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: null,
        margin: null,
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Container(
              child: Text('Paradox',
                  style: TextStyle(
                      fontSize: 70,
                      color: Colors.lightBlue[900].withAlpha(1000),
                      fontWeight: FontWeight.bold)),
            ),
            // Container(
            //   child: Text('by',
            //       style: TextStyle(fontSize: 30,
            //           color: Colors.grey[400],
            //           fontWeight: FontWeight.w500)),
            // ),
            // SizedBox(height: 10),
            Container(
              width: 200,
              height: 60,
              child: HoverCard(
                builder: (context, hovering) {
                  return Container(
                    padding: null,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.lightBlue[900].withAlpha(1000),
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: 'Team .E'),
                            TextSpan(
                                text: 'X',
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(text: 'E'),
                          ]),
                    ),
                  );
                },
                depth: 10,
                depthColor: Colors.blue[500],
                shadow: BoxShadow(
                    color: Colors.white,
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0.0, 0.75)),
              ),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(30),
              child: MaterialButton(
                child: isSigningIn
                    ? SpinKitCircle(color: Colors.blue)
                    : GoogleSignInButton(),
                color: Colors.white,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                onPressed: () {
                  setState(() {
                    isSigningIn = true;
                  });
                  signInWithGoogle().whenComplete(() {
                    if (FirebaseAuth.instance.currentUser != null) {
                      Fluttertoast.showToast(
                          msg: 'Signed In Successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 15.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Sign In Unsuccessful',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 15.0);
                    }

                    setState(() {
                      isSigningIn = false;
                    });
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              child: SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/google_logo.jpg'),
              ),
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Text('Sign up with Google',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
