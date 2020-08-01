import 'package:cuti_flutter_mobile/widgets/customDrawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'localWidgets/requestAdminCard.dart';

class RequestHistoryAdminScreen extends StatefulWidget {
  @override
  _RequestHistoryAdminScreenState createState() =>
      _RequestHistoryAdminScreenState();
}

class _RequestHistoryAdminScreenState extends State<RequestHistoryAdminScreen> {
  List<dynamic> _list = [];
  DatabaseReference _db =
      FirebaseDatabase.instance.reference().child('pengajuan');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA PENGAJUAN CUTI'),
      ),
      drawer: CustomDrawer(true),
      body: StreamBuilder(
          stream: _db.onValue,
          builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
              _list.clear();
              if (map != null) {
                _list = map.values
                    .where((element) =>
                        element['statusCuti'] != 'menunggu konfirmasi')
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
                          child: RequestAdminCard(_list[index]),
                        );
                      }),
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
