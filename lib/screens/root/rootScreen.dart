import 'package:cuti_flutter_mobile/screens/home/homeScreen.dart';
import 'package:cuti_flutter_mobile/screens/login/loginScreen.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  loggedIn,
  notLoggedIn,
}

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

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

      default:
    }

    return retVal;
  }
}
