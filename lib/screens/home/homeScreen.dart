import 'package:cuti_flutter_mobile/screens/home/localWidgets/profileAvatar.dart';
import 'package:cuti_flutter_mobile/screens/home/localWidgets/profileInfo.dart';
import 'package:cuti_flutter_mobile/widgets/customDrawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APLIKASI CUTI'),
      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Selamat Datang',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          ProfileAvatar(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Administrator',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'admin@cuti.id',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).accentColor,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ProfileInfo()
        ],
      ),
    );
  }
}
