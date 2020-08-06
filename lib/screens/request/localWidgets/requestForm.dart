import 'package:cuti_flutter_mobile/models/pengajuanModel.dart';
import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:cuti_flutter_mobile/screens/requestHistory/requestHistoryScreen.dart';
import 'package:cuti_flutter_mobile/services/pengajuanService.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:cuti_flutter_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestForm extends StatefulWidget {
  RequestForm(this._cutiHamil, this._cutiTahun);
  final String _cutiHamil;
  final String _cutiTahun;
  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> with Validation {
  final formKey = GlobalKey<FormState>();
  Pengajuan _pengajuan = Pengajuan();
  Pengguna _pengguna = Pengguna();

  TextEditingController _mulaiCutiController = TextEditingController();
  TextEditingController _selesaiCutiController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();

  List<String> jenisCuti = ["Cuti Tahunan"];

  String _jenisCuti = "Cuti Tahunan";
  DateTime _selectedMulaiCuti = DateTime.now().add(Duration(days: 1));
  DateTime _selectedSelesaiCuti = DateTime.now().add(Duration(days: 2));

  void submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      _pengajuan.tanggalPengajuan = DateTime.now().millisecondsSinceEpoch;
      _pengajuan.tanggalMulaiCuti = _selectedMulaiCuti.millisecondsSinceEpoch;
      _pengajuan.tanggalSelesaiCuti =
          _selectedSelesaiCuti.millisecondsSinceEpoch;
      _pengajuan.statusCuti = "menunggu konfirmasi";
      _pengajuan.keterangan = _keteranganController.text.toLowerCase();
      _pengajuan.jenisCuti = _jenisCuti.toLowerCase();
      _pengajuan.tahunCuti = DateTime.now().year.toString();

      var dif = _selectedSelesaiCuti.difference(_selectedMulaiCuti).inDays;
      bool canCuti = false;

      if (_jenisCuti == "Cuti Tahunan") {
        if (dif > int.parse(widget._cutiTahun)) {
          canCuti = false;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Sisa cuti tahunan anda tidak cukup!',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 2,
            ),
          ));
        } else {
          canCuti = true;
        }
      } else {
        if (dif > int.parse(widget._cutiHamil)) {
          canCuti = false;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Sisa cuti melahirkan anda tidak cukup!',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 2,
            ),
          ));
        } else {
          canCuti = true;
        }
      }

      if (canCuti) {
        var _returnString =
            await PengajuanService().createPengajuan(_pengajuan);
        if (_returnString == "success") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RequestHistoryScreen(),
            ),
          );
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Pengajuan cuti gagal!',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 2,
            ),
          ));
        }
      }
    }
  }

  void setJenisCuti() async {
    if (_pengguna.jenisKelamin == 'laki-laki') {
      setState(() {
        jenisCuti = ["Cuti Tahunan"];
      });
    } else {
      setState(() {
        jenisCuti = ["Cuti Tahunan", "Cuti Melahirkan"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    PenggunaState _penggunaState = Provider.of<PenggunaState>(
      context,
      listen: false,
    );

    setState(() {
      _pengajuan.penggunaId = _penggunaState.getPengguna.uid;
      _pengguna = _penggunaState.getPengguna;
      _mulaiCutiController.text =
          DateFormat('dd MMMM yyyy', 'id').format(_selectedMulaiCuti);
      _selesaiCutiController.text =
          DateFormat('dd MMMM yyyy', 'id').format(_selectedSelesaiCuti);
    });

    setJenisCuti();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Wrap(
        runSpacing: 10,
        children: <Widget>[
          DropdownButtonFormField(
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Jenis Cuti',
            ),
            isExpanded: true,
            value: _jenisCuti,
            items: jenisCuti.length > 0
                ? jenisCuti
                    .map(
                      (String value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList()
                : null,
            onChanged: (value) {
              setState(() {
                _jenisCuti = value;
              });
            },
          ),
          TextFormField(
            validator: validateDate,
            controller: _mulaiCutiController,
            showCursor: false,
            readOnly: true,
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              DateTime newDateTime = await showRoundedDatePicker(
                  context: context,
                  initialDate: _selectedMulaiCuti,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                  borderRadius: 16);
              if (newDateTime != null) {
                _mulaiCutiController.text =
                    DateFormat('dd MMMM yyyy', 'id').format(newDateTime);

                setState(() {
                  _selectedMulaiCuti = newDateTime;
                  _selectedSelesaiCuti = newDateTime.add(Duration(days: 1));
                  _selesaiCutiController.text = DateFormat('dd MMMM yyyy', 'id')
                      .format(_selectedSelesaiCuti);
                });
              }
            },
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Tanggal Mulai Cuti',
            ),
          ),
          TextFormField(
            validator: validateDate,
            controller: _selesaiCutiController,
            showCursor: false,
            readOnly: true,
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              DateTime newDateTime = await showRoundedDatePicker(
                context: context,
                initialDate: _selectedSelesaiCuti,
                firstDate: _selectedMulaiCuti.add(Duration(days: 1)),
                lastDate: DateTime(DateTime.now().year + 1),
                borderRadius: 16,
              );
              if (newDateTime != null) {
                _selesaiCutiController.text =
                    DateFormat('dd MMMM yyyy', 'id').format(newDateTime);

                setState(() {
                  _selectedSelesaiCuti = newDateTime;
                });
              }
            },
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Tanggal Selesai Cuti',
            ),
          ),
          TextFormField(
            validator: validateString,
            controller: _keteranganController,
            keyboardType: TextInputType.text,
            maxLines: 3,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Keterangan',
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                submit();
              },
              elevation: 2,
              child: Text(
                'AJUKAN CUTI',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
