import 'package:cuti_flutter_mobile/screens/request/requestScreen.dart';
import 'package:cuti_flutter_mobile/screens/requestHistory/localWidgets/requestCard.dart';
import 'package:cuti_flutter_mobile/widgets/customDrawer.dart';
import 'package:flutter/material.dart';

class RequestHistoryScreen extends StatelessWidget {
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
      drawer: CustomDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              RequestCard(),
              RequestCard(),
              RequestCard(),
              RequestCard(),
              RequestCard(),
            ],
          ))
        ],
      ),
    );
  }
}
