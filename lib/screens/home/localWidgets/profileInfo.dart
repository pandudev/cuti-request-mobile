import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  ProfileInfo(this._pengguna);

  final Pengguna _pengguna;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 5,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  'NIP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ': ' + _pengguna.nip.toString(),
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
                child: Text(
                  'Jabatan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ': ' + _pengguna.jabatan.toString(),
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
                child: Text(
                  'Jenis Kelamin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ': ' + _pengguna.jenisKelamin.toString(),
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
                child: Text(
                  'No. Telp',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ': ' + _pengguna.telepon.toString(),
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
                child: Text(
                  'Cuti Tahunan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ': 12 Hari',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  'Cuti Melahirkan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  ': 90 Hari',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
