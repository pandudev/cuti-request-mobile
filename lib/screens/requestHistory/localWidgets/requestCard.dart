import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
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
                '28 Juli 2020, 10.00 WIB',
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
                          ': 123423423',
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
                          ': Abdul Kadir',
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
                          'Tanggal Cuti',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          ': 31 Juli 2020 - 5 Agustus 2020',
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
                          'Jenis Cuti',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          ': Cuti Tahunan',
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
                          ': 5 Hari',
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
                          ': Izin berobat ke luar negeri',
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
                          ': MENUNGGU KONFIRMASI',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.orangeAccent),
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
