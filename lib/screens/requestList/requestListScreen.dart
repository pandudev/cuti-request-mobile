import 'package:cuti_flutter_mobile/screens/requestList/localWidgets/requestListCard.dart';
import 'package:flutter/material.dart';

class RequestListScreen extends StatelessWidget {
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
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Jumlah : 2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RequestListCard(),
                    RequestListCard(),
                    RequestListCard(),
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
