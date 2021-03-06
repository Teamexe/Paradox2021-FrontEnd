import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:paradox/providers/GalleryProvider.dart';
import 'package:paradox/providers/leaderboard_provider.dart';
import 'package:paradox/providers/members_provider.dart';
import 'package:paradox/providers/referral_provider.dart';
import 'package:paradox/providers/stats_provider.dart';
import 'package:paradox/providers/theme_provider.dart';
import 'package:paradox/providers/user_provider.dart';
import 'package:paradox/providers/question_provider.dart';
import 'package:paradox/utilities/brightness.dart';
import 'package:provider/provider.dart';
import 'authentication/sign_in.dart';
import 'routes/routes.dart';
import './authentication/sign_in.dart';
import 'screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  void getTheme() async {
    themeProvider = new ThemeProvider();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LeaderBoardProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReferralProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => ExeMembersProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
        ChangeNotifierProvider(create: (_) => GalleryProvider()),
      ],
      child: Consumer<ThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return StreamProvider<DataConnectionStatus>(
          create: (_) {
            return DataConnectionChecker().onStatusChange;
          },
          child: MaterialApp(
            title: 'Paradox',
            theme: ThemeData(
              brightness: brightness(context),
              accentColor: Colors.transparent,
              highlightColor: Colors.transparent,
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Provider.of<ThemeProvider>(context, listen: true).brightness;
                  Provider.of<DataConnectionStatus>(context, listen: true);
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
      }),
    );
  }
}
