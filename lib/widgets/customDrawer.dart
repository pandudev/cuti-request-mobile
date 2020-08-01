import 'package:cuti_flutter_mobile/screens/home/homeScreen.dart';
import 'package:cuti_flutter_mobile/screens/request/requestScreen.dart';
import 'package:cuti_flutter_mobile/screens/requestHistory/requestHistoryAdminScreen.dart';
import 'package:cuti_flutter_mobile/screens/requestHistory/requestHistoryScreen.dart';
import 'package:cuti_flutter_mobile/screens/root/rootScreen.dart';
import 'package:cuti_flutter_mobile/screens/setting/settingScreen.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer(this._isDirektur);
  final bool _isDirektur;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image(
                  color: Colors.white,
                  height: 70,
                  image: AssetImage(
                    'assets/images/company-logo.png',
                  ),
                ),
                Text(
                  'PT. NAMA PERUSAHAAN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              NavItem('Home', Icons.home, HomeScreen()),
              _isDirektur
                  ? NavItem('Data Pengajuan Cuti', Icons.history,
                      RequestHistoryAdminScreen())
                  : Column(
                      children: <Widget>[
                        NavItem(
                            'Pengajuan Cuti', Icons.create, RequestScreen()),
                        NavItem('Informasi Cuti', Icons.history,
                            RequestHistoryScreen()),
                      ],
                    ),
              NavItem('Pengaturan', Icons.settings, SettingScreen()),
              ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 30,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () async {
                    PenggunaState _penggunaState = Provider.of<PenggunaState>(
                      context,
                      listen: false,
                    );
                    String _returnString = await _penggunaState.signOut();
                    if (_returnString == 'success') {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RootScreen(),
                          ),
                          (route) => false);
                    }
                    // Navigator.pushNamed(context, route);
                  })
            ],
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  NavItem(
    this.name,
    this.icon,
    this.screen,
  );

  final String name;
  final IconData icon;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          size: 30,
          // color: Theme.of(context).accentColor,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            // color: Theme.of(context).accentColor,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => screen,
            ),
          );

          // Navigator.pushNamed(context, route);
        });
  }
}
