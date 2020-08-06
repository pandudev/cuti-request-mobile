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
  Query _db = FirebaseDatabase.instance
      .reference()
      .child('pengajuan')
      .orderByChild('tanggalPengajuan');

  @override
  void initState() {
    super.initState();
    setState(() {
      _list.clear();
    });
    _db.onChildAdded.listen((event) {
      if (event.snapshot.value['tahunCuti'] == DateTime.now().year.toString() &&
          event.snapshot.value['statusCuti'] != 'menunggu konfirmasi') {
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
          title: Text('DATA PENGAJUAN CUTI'),
        ),
        drawer: CustomDrawer(true, 'Data Pengajuan Cuti'),
        body: _list.length > 0
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RequestAdminCard(
                            _list[(_list.length - (index + 1))]),
                      );
                    }),
              )
            : Center(
                child: Text('Tidak ada data'),
              ));
  }
}
