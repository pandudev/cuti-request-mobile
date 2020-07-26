import 'package:flutter/material.dart';

class RequestDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VALIDASI PENGAJUAN CUTI'),
      ),
      body: Row(
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
                      controller: TextEditingController()..text = '12312312',
                      decoration: InputDecoration(
                        labelText: 'NIP',
                      ),
                    ),
                    TextField(
                      enabled: false,
                      readOnly: true,
                      controller: TextEditingController()..text = 'Abdul Kadir',
                      decoration: InputDecoration(
                        labelText: 'Nama',
                      ),
                    ),
                    TextField(
                      enabled: false,
                      readOnly: true,
                      controller: TextEditingController()..text = '2 Juli 2020',
                      decoration: InputDecoration(
                        labelText: 'Tanggal Mulai Cuti',
                      ),
                    ),
                    TextField(
                      enabled: false,
                      readOnly: true,
                      controller: TextEditingController()..text = '5 Juli 2020',
                      decoration: InputDecoration(
                        labelText: 'Tanggal Akhir Cuti',
                      ),
                    ),
                    TextField(
                      enabled: false,
                      readOnly: true,
                      controller: TextEditingController()..text = '2 Hari',
                      decoration: InputDecoration(
                        labelText: 'Lama Cuti',
                      ),
                    ),
                    TextField(
                      enabled: false,
                      readOnly: true,
                      maxLines: 3,
                      controller: TextEditingController()
                        ..text =
                            'Keterangan cuti pegawai asdasdas adsdasd asdasd',
                      decoration: InputDecoration(
                        labelText: 'Keterangan',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {},
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
                        onPressed: () {},
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
