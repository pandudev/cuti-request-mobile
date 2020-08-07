import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestAdminCard extends StatefulWidget {
  final dynamic data;
  RequestAdminCard(this.data);

  @override
  _RequestAdminCardState createState() => _RequestAdminCardState();
}

class _RequestAdminCardState extends State<RequestAdminCard> {
  Pengguna _pengguna = Pengguna();

  int getDifferenceWithoutWeekends(DateTime startDate, DateTime endDate) {
    int nbDays = 0;
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday != DateTime.sunday) {
        nbDays += 1;
      }
    }
    return nbDays;
  }

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
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                runSpacing: 5,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          'NIP',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          _pengguna.nip != null
                              ? ': ' + _pengguna.nip.toString()
                              : ': ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Nama',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          _pengguna.nama != null
                              ? ': ' + _pengguna.nama.toString()
                              : ': ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Lama Cuti',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          ': ' +
                              getDifferenceWithoutWeekends(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          widget.data['tanggalMulaiCuti']),
                                      DateTime.fromMillisecondsSinceEpoch(
                                          widget.data['tanggalSelesaiCuti']))
                                  .toString() +
                              " hari",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Keterangan',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          ': ' + widget.data['keterangan'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          ': ' +
                              widget.data['statusCuti']
                                  .toString()
                                  .toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: (widget.data['statusCuti'].toString() ==
                                    'ditolak'
                                ? Theme.of(context).accentColor
                                : Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
