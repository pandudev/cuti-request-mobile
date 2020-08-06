import 'package:cuti_flutter_mobile/screens/request/requestScreen.dart';
import 'package:cuti_flutter_mobile/screens/requestHistory/localWidgets/requestCard.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:cuti_flutter_mobile/widgets/customDrawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestHistoryScreen extends StatefulWidget {
  @override
  _RequestHistoryScreenState createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  String _uid;
  List<dynamic> _list = [];
  var _db = FirebaseDatabase.instance
      .reference()
      .child('pengajuan')
      .orderByChild('tanggalPengajuan');

  @override
  void initState() {
    super.initState();
    PenggunaState _penggunaState = Provider.of<PenggunaState>(
      context,
      listen: false,
    );

    setState(() {
      _uid = _penggunaState.getPengguna.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => RequestScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                size: 30.0,
              ),
            ),
          )
        ],
        title: Text('INFORMASI CUTI'),
      ),
      drawer: CustomDrawer(false, ''),
      body: StreamBuilder(
          stream: _db.onValue,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
              _list.clear();
              if (map != null) {
                _list = map.values
                    .where((element) =>
                        element['penggunaId'] == _uid &&
                        element['tahunCuti'] == DateTime.now().year.toString())
                    .toList();
              }

              if (_list.length > 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RequestCard(_list[index]),
                        );
                      }),
                );
              } else {
                return Center(
                  child: Text('Tidak ada data cuti'),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
