import 'package:cuti_flutter_mobile/screens/root/rootScreen.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:cuti_flutter_mobile/utils/customTheme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _token = "";

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(onLaunch: (Map<String, dynamic> msg) {
      print("onLaunch called");
    }, onResume: (Map<String, dynamic> msg) {
      print("onResume called");
    }, onMessage: (Map<String, dynamic> msg) {
      print("onMessage called");
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registered');
    });

    _firebaseMessaging.getToken().then((token) => updateToken(token));
  }

  updateToken(String token) {
    print(token);
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PenggunaState(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: Locale('id', 'ID'),
        supportedLocales: [
          const Locale('id', 'ID'),
        ],
        debugShowCheckedModeBanner: false,
        theme: CustomTheme().buildTheme(),
        home: RootScreen(),
      ),
    );
  }
}
