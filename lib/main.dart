import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
import 'package:paradox/providers/members_provider.dart';
import 'package:paradox/providers/referral_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:provider/provider.dart';
import 'authentication/sign_in.dart';
import 'routes/routes.dart';
import './authentication/sign_in.dart';
import 'screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LeaderBoardProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReferralProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => ExeMembersProvider())
      ],
      child: MaterialApp(
        title: 'Paradox',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return SignIn();
            }
          },
        ),
        // QuestionScreen(),
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
