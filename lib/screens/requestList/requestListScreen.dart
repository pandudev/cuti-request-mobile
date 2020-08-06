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
      .orderByChild('tanggalPengajuan');

  @override
  void initState() {
    super.initState();
    _db.onChildAdded.listen((event) {
      if (event.snapshot.value['tahunCuti'] == DateTime.now().year.toString() &&
          event.snapshot.value['statusCuti'] == 'menunggu konfirmasi') {
        setState(() {
          _list.add(event.snapshot.value);
        });
      }
    });
    _db.onChildRemoved.listen((event) {
      setState(() {
        _list.removeWhere((item) =>
            item['tanggalPengajuan'] ==
            event.snapshot.value['tanggalPengajuan']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DAFTAR PENGAJUAN CUTI'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: RequestListCard(_list[index], index),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
