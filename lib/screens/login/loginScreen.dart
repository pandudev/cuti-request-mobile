import 'package:cuti_flutter_mobile/screens/login/localWidgets/loginForm.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 60.0,
                    right: 60.0,
                    bottom: 40.0,
                    left: 60.0,
                  ),
                  child: Image.asset('assets/images/company-logo.png'),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'PT. NAMA PERUSAHAAN',
                        style: TextStyle(
                          fontFamily: 'Monstserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'CUTI ONLINE',
                        style: TextStyle(
                          fontFamily: 'Monstserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                LoginForm()
              ],
            ),
          )
        ],
      ),
    );
  }
}
