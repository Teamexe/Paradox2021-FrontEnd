import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hover_effect/hover_effect.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/screens/home_screen.dart';
import 'package:paradox/utilities/Toast.dart';
import 'package:paradox/utilities/clipper.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

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

class _SignInWidgetState extends State<SignInWidget>
    with SingleTickerProviderStateMixin {
  bool isSigningIn = false;
  AnimationController animationController;
  Animation fadeAnimation;
  Animation scaleAnimation;

  @override
  void initState() {
    super.initState();
    // animation controller for fade animation
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    // animation for fade in effect to widgets
    fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    // animation to scale up effect
    scaleAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // to start the animation
    animationController.forward();

    return LoaderOverlay(
      child: SafeArea(
        child: Container(
          padding: null,
          margin: null,
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue.shade400,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [Colors.red, Colors.yellow, Colors.blue, Colors.purple]
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      height: 195,
                      padding: null,
                      margin: null,
                      child: ClipPath(
                        clipper: CustomizedClipper(),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      height: 165,
                      padding: null,
                      margin: null,
                      child: ClipPath(
                        clipper: CustomizedClipper(),
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      height: 150,
                      padding: null,
                      margin: null,
                      child: ClipPath(
                        clipper: CustomizedClipper(),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      height: 140,
                      padding: null,
                      margin: null,
                      child: ClipPath(
                        clipper: CustomizedClipper(),
                        child: Container(
                          color: Colors.blue[900].withAlpha(1000),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      height: 135,
                      padding: null,
                      margin: null,
                      child: ClipPath(
                        clipper: CustomizedClipper(),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Expanded(
                // width: 260,
                // height: 80,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: Text(
                    'Paradox',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 5,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 200,
                height: 60,
                child: HoverCard(
                  builder: (context, hovering) {
                    return FadeTransition(
                      opacity: fadeAnimation,
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
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
                      ),
                    );
                  },
                  depth: 10,
                  depthColor: Colors.blue,
                  shadow: BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: Offset(0.0, 0.75)),
                ),
              ),
              SizedBox(height: 100),
              Container(
                padding: EdgeInsets.all(30),
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: Container(
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
                        UserProvider()
                            .signInWithGoogle()
                            .whenComplete(() async {
                          if (FirebaseAuth.instance.currentUser != null) {
                            createToast('Sign in Successful');
                            Navigator.of(context).pushNamed(Home.routeName);
                          } else {
                            createToast('Sign In Unsuccessful');
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
                ),
              ),
              Spacer()
            ],
          ),
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
              child: Text('Sign in with Google',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
