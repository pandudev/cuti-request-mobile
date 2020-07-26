import 'package:cuti_flutter_mobile/screens/requestList/requestListScreen.dart';
import 'package:flutter/material.dart';

class RequestNotification extends StatelessWidget {
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
                  Text(
                    '2',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RequestListScreen(),
                    ),
                  );
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
