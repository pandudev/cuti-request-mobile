import 'package:cuti_flutter_mobile/screens/setting/localWidgets/changePasswordForm.dart';
import 'package:cuti_flutter_mobile/widgets/customDrawer.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PENGATURAN AKUN'),
      ),
      drawer: CustomDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'UBAH PASSWORD',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'admin@cuti.id',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                ChangePasswordForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
