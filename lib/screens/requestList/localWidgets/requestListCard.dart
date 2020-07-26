import 'package:cuti_flutter_mobile/screens/requestDetail/requestDetailScreen.dart';
import 'package:flutter/material.dart';

class RequestListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => RequestDetailScreen(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '28 Juli 2020, 10.00 WIB',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Nama Pegawai',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
