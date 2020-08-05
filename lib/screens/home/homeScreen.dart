import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:cuti_flutter_mobile/screens/home/localWidgets/profileAvatar.dart';
import 'package:cuti_flutter_mobile/screens/home/localWidgets/profileInfo.dart';
import 'package:cuti_flutter_mobile/screens/home/localWidgets/requestNotification.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:cuti_flutter_mobile/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Pengguna _pengguna = Pengguna();
  bool _isDirektur = false;

  @override
  void initState() {
    super.initState();
    PenggunaState _penggunaState = Provider.of<PenggunaState>(
      context,
      listen: false,
    );

    setState(() {
      _pengguna = _penggunaState.getPengguna;
      _isDirektur = _pengguna.role == 'direktur';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APLIKASI CUTI'),
      ),
      drawer: CustomDrawer(_isDirektur, 'Home'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Selamat Datang',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_isDirektur)
            Text(
              'Direktur',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          SizedBox(
            height: 20,
          ),
          ProfileAvatar(_pengguna),
          SizedBox(
            height: 20,
          ),
          Text(
            _pengguna.nama.toString(),
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
            _pengguna.email,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).accentColor,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          _isDirektur ? RequestNotification() : ProfileInfo(_pengguna),
        ],
      ),
    );
  }
}
