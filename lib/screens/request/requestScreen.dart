import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:cuti_flutter_mobile/screens/request/localWidgets/requestForm.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:cuti_flutter_mobile/widgets/customDrawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  Pengguna _pengguna = Pengguna();

  DatabaseReference _db;

  @override
  void initState() {
    super.initState();
    PenggunaState _penggunaState = Provider.of<PenggunaState>(
      context,
      listen: false,
    );

    setState(() {
      _pengguna = _penggunaState.getPengguna;
    });

    _db = FirebaseDatabase.instance
        .reference()
        .child('cuti')
        .child(_pengguna.uid)
        .child(DateTime.now().year.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PENGAJUAN CUTI'),
      ),
      drawer: CustomDrawer(false, 'Pengajuan Cuti'),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                StreamBuilder(
                    stream: _db.onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String _cutiTahun = snapshot
                            .data.snapshot.value['cutiTahunan']
                            .toString();
                        String _cutiHamil = snapshot
                            .data.snapshot.value['cutiHamil']
                            .toString();

                        return Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Sisa Cuti Tahunan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ': ' + _cutiTahun + ' Hari',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Sisa Cuti Melahirkan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _pengguna.jenisKelamin == 'laki-laki'
                                        ? ': -'
                                        : ': ' + _cutiHamil + ' Hari',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            RequestForm(_cutiHamil, _cutiTahun),
                          ],
                        );
                      } else {
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
