import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:cuti_flutter_mobile/screens/home/homeScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestDetailScreen extends StatefulWidget {
  final dynamic _pengajuan;
  final Pengguna _pengguna;
  RequestDetailScreen(this._pengajuan, this._pengguna);

  @override
  _RequestDetailScreenState createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool disabled = false;
  dynamic _cuti;
  DatabaseReference _cutiRef;
  bool loading = true;
  bool canCuti = false;

  int getDifferenceWithoutWeekends(DateTime startDate, DateTime endDate) {
    int nbDays = 0;
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday != DateTime.sunday) {
        nbDays += 1;
      }
    }
    return nbDays;
  }

  void cutiAction(String status, BuildContext context) {
    var lamaCuti = getDifferenceWithoutWeekends(
        DateTime.fromMillisecondsSinceEpoch(
            widget._pengajuan['tanggalMulaiCuti']),
        DateTime.fromMillisecondsSinceEpoch(
            widget._pengajuan['tanggalSelesaiCuti']));

    // DateTime.fromMillisecondsSinceEpoch(
    //         widget._pengajuan['tanggalSelesaiCuti'])
    //     .difference(DateTime.fromMillisecondsSinceEpoch(
    //         widget._pengajuan['tanggalMulaiCuti']))
    //     .inDays;

    if (disabled == false) {
      setState(() {
        loading = true;
      });

      if (status == 'diterima') {
        if (widget._pengajuan['jenisCuti'] == 'cuti tahunan') {
          if (lamaCuti <= _cuti['cutiTahunan']) {
            canCuti = true;
          } else {
            canCuti = false;
            Future.delayed(
              Duration(seconds: 2),
            ).asStream().listen(
              (event) {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Sisa cuti tidak cukup',
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(
                      seconds: 2,
                    ),
                  ),
                );
              },
            );
            Future.delayed(
              Duration(seconds: 4),
            ).asStream().listen(
              (event) {
                setState(() {
                  loading = false;
                });
              },
            );
          }
        } else {
          if (lamaCuti <= _cuti['cutiHamil']) {
            canCuti = true;
          } else {
            canCuti = false;
            Future.delayed(
              Duration(seconds: 2),
            ).asStream().listen(
              (event) {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Sisa cuti tidak cukup',
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(
                      seconds: 2,
                    ),
                  ),
                );
              },
            );
            Future.delayed(
              Duration(seconds: 4),
            ).asStream().listen(
              (event) {
                setState(() {
                  loading = false;
                });
              },
            );
          }
        }
      } else {
        canCuti = true;
      }

      if (canCuti) {
        FirebaseDatabase.instance
            .reference()
            .child('pengajuan')
            .orderByChild('tanggalPengajuan')
            .equalTo((widget._pengajuan['tanggalPengajuan']))
            .once()
            .then(
              (DataSnapshot snapshot) => {
                FirebaseDatabase.instance
                    .reference()
                    .child('pengajuan')
                    .child((snapshot.value as Map).keys.first)
                    .update({'statusCuti': status}).whenComplete(
                  () => {
                    if (status == 'diterima')
                      {
                        if (widget._pengajuan['jenisCuti'] == 'cuti tahunan')
                          {
                            _cutiRef.update({
                              'cutiTahunan': _cuti['cutiTahunan'] - lamaCuti
                            })
                          }
                        else
                          {
                            _cutiRef.update({'cutiHamil': 0})
                          }
                      },
                    Future.delayed(
                      Duration(seconds: 2),
                    ).asStream().listen(
                      (event) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Pengajuan cuti ' + status,
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(
                              seconds: 3,
                            ),
                          ),
                        );
                      },
                    ),
                    Future.delayed(
                      Duration(seconds: 3),
                    ).asStream().listen(
                      (event) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                    ),
                  },
                ),
              },
            );
      }
    }
  }

  void getCuti() async {
    _cutiRef = FirebaseDatabase.instance
        .reference()
        .child('cuti')
        .child(widget._pengajuan['penggunaId'])
        .child(DateTime.now().year.toString());

    _cutiRef.once().then((DataSnapshot snapshot) => setState(() {
          _cuti = snapshot.value;
          loading = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    getCuti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('VALIDASI PENGAJUAN CUTI'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: <Widget>[
                      Wrap(
                        runSpacing: 10,
                        children: <Widget>[
                          TextField(
                            enabled: false,
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = widget._pengguna.nip,
                            decoration: InputDecoration(
                              labelText: 'NIP',
                            ),
                          ),
                          TextField(
                            enabled: false,
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = widget._pengguna.nama,
                            decoration: InputDecoration(
                              labelText: 'Nama',
                            ),
                          ),
                          TextField(
                            enabled: false,
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = widget._pengajuan['jenisCuti'],
                            decoration: InputDecoration(
                              labelText: 'Jenis Cuti',
                            ),
                          ),
                          TextField(
                            enabled: false,
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = DateFormat('dd/MM/yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget._pengajuan['tanggalMulaiCuti'])),
                            decoration: InputDecoration(
                              labelText: 'Tanggal Mulai Cuti',
                            ),
                          ),
                          TextField(
                            enabled: false,
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = DateFormat('dd/MM/yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget._pengajuan['tanggalSelesaiCuti'])),
                            decoration: InputDecoration(
                              labelText: 'Tanggal Akhir Cuti',
                            ),
                          ),
                          TextField(
                            enabled: false,
                            readOnly: true,
                            controller: TextEditingController()
                              ..text = getDifferenceWithoutWeekends(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              widget._pengajuan[
                                                  'tanggalMulaiCuti']),
                                          DateTime.fromMillisecondsSinceEpoch(
                                              widget._pengajuan[
                                                  'tanggalSelesaiCuti']))
                                      .toString() +
                                  " hari",
                            decoration: InputDecoration(
                              labelText: 'Lama Cuti',
                            ),
                          ),
                          TextField(
                            enabled: false,
                            readOnly: true,
                            maxLines: 3,
                            controller: TextEditingController()
                              ..text = widget._pengajuan['keterangan'],
                            decoration: InputDecoration(
                              labelText: 'Keterangan',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                cutiAction('ditolak', context);
                              },
                              elevation: 2,
                              child: Text(
                                'TOLAK',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                cutiAction('diterima', context);
                              },
                              elevation: 2,
                              child: Text(
                                'TERIMA',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
