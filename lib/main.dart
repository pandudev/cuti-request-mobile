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
