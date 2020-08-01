import 'package:cuti_flutter_mobile/screens/requestList/requestListScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RequestNotification extends StatefulWidget {
  @override
  _RequestNotificationState createState() => _RequestNotificationState();
}

class _RequestNotificationState extends State<RequestNotification> {
  List<dynamic> _list = [];

  Query _db = FirebaseDatabase.instance
      .reference()
      .child('pengajuan')
      .orderByChild('tahunCuti')
      .equalTo(DateTime.now().year.toString());

  void lihatPengajuan(context) {
    if (_list.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RequestListScreen(),
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Tidak ada data pengajuan cuti!',
          textAlign: TextAlign.center,
        ),
        duration: Duration(
          seconds: 2,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 3,
            )),
            child: Padding(
              padding: EdgeInsets.all(
                20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.notifications,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pengajuan Cuti: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  StreamBuilder(
                      stream: _db.onValue,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                              snapshot.data.snapshot.value;
                          _list.clear();
                          if (map != null) {
                            _list = map.values
                                .where((element) =>
                                    element['statusCuti'] ==
                                    'menunggu konfirmasi')
                                .toList();
                          }

                          return Text(_list.length.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ));
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  lihatPengajuan(context);
                },
                elevation: 2,
                child: Text(
                  'LIHAT PENGAJUAN CUTI',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
