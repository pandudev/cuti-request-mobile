import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:cuti_flutter_mobile/screens/requestDetail/requestDetailScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestListCard extends StatefulWidget {
  final dynamic data;
  final int index;
  RequestListCard(this.data, this.index);

  @override
  _RequestListCardState createState() => _RequestListCardState();
}

class _RequestListCardState extends State<RequestListCard> {
  Pengguna _pengguna = Pengguna();

  void getPengguna() async {
    FirebaseDatabase.instance
        .reference()
        .child('pengguna')
        .child(widget.data['penggunaId'])
        .once()
        .then((DataSnapshot snapshot) => {
              setState(() {
                _pengguna.uid = snapshot.key;
                _pengguna.nip = snapshot.value['nip'];
                _pengguna.nama = snapshot.value['nama'];
              })
            });
  }

  @override
  void initState() {
    super.initState();
    getPengguna();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if (widget.index != 0) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Gagal lihat pengajuan. Mohon lihat pengajuan pertama!',
              ),
              duration: Duration(
                seconds: 2,
              ),
            ));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    RequestDetailScreen(widget.data, _pengguna),
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat('dd MMMM yyyy, hh:mm', 'id').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.data['tanggalPengajuan'])) +
                    ' WIB',
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
                _pengguna.nama != null
                    ? _pengguna.nip + " - " + _pengguna.nama
                    : '',
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
