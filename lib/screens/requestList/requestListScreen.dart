import 'package:cuti_flutter_mobile/screens/requestList/localWidgets/requestListCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RequestListScreen extends StatefulWidget {
  @override
  _RequestListScreenState createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<dynamic> _list = [];

  Query _db = FirebaseDatabase.instance
      .reference()
      .child('pengajuan')
      .orderByChild('tahunCuti')
      .equalTo(DateTime.now().year.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DAFTAR PENGAJUAN CUTI'),
      ),
      body: StreamBuilder(
          stream: _db.onValue,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
              int i = 0;
              map.forEach((key, value) {
                String id =
                    (snapshot.data.snapshot.value as Map).keys.elementAt(i);
                map[key]['key'] = id;
                i++;
              });
              _list.clear();

              if (map != null) {
                _list = map.values
                    .where((element) =>
                        element['statusCuti'] == 'menunggu konfirmasi')
                    .toList();
              }

              if (_list.length > 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Jumlah : ' + _list.length.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child:
                                          RequestListCard(_list[index], index),
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Tidak ada data pengajuan cuti'),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
