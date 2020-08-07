import 'package:cuti_flutter_mobile/screens/home/homeScreen.dart';
import 'package:cuti_flutter_mobile/screens/login/loginScreen.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus { loggedIn, notLoggedIn, loading }

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.loading;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _isDirektur = false;
  String _token = "";

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onLaunch: (message) async {
        print('on launch');
      },
      onResume: (message) async {
        print('on resume');
      },
      onMessage: (message) async {
        print('on message');
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(alert: true, badge: true, sound: true));

    updateToken(String token) {
      print(token);
      setState(() {
        _token = token;
      });
    }

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('ios setting registered');
    });

    _firebaseMessaging.getToken().then((token) => {updateToken(token)});
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    PenggunaState _penggunaState = Provider.of<PenggunaState>(
      context,
      listen: false,
    );

    String _returnString = await _penggunaState.onStartUp();

    if (_returnString == "success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
        _isDirektur =
            _penggunaState.getPengguna.role == 'direktur' ? true : false;
        FirebaseDatabase.instance
            .reference()
            .child('fcm-token')
            .child(_token)
            .set({'token': _token});
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;

      case AuthStatus.loggedIn:
        retVal = HomeScreen();
        break;

      case AuthStatus.loading:
        retVal = Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            child: Center(
                child: CircularProgressIndicator(
                    // backgroundColor: Theme.of(context).accentColor,
                    )));
        break;

      default:
    }

    return retVal;
  }
}
