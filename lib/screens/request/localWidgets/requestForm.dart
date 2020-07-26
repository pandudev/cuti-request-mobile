import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';

class RequestForm extends StatefulWidget {
  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  TextEditingController mulaiCutiController = TextEditingController();
  TextEditingController selesaiCutiController = TextEditingController();

  List<String> jenisCuti = ["Cuti Sakit", "Cuti Izin", "Melahirkan"];

  String _jenisCuti = "Cuti Sakit";
  DateTime _selectedMulaiCuti = DateTime.now();
  DateTime _selectedSelesaiCuti = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            items: jenisCuti
                .map(
                  (String value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) {},
          ),
          TextFormField(
            controller: mulaiCutiController,
            showCursor: false,
            readOnly: true,
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              DateTime newDateTime = await showRoundedDatePicker(
                context: context,
                initialDate: _selectedMulaiCuti,
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 1),
                borderRadius: 16,
              );
              if (newDateTime != null) {
                mulaiCutiController.text =
                    DateFormat('dd MMMM yyyy', 'id').format(newDateTime);

                setState(() {
                  _selectedMulaiCuti = newDateTime;
                  _selectedSelesaiCuti = newDateTime;
                });

                selesaiCutiController.text = DateFormat('dd MMMM yyyy', 'id')
                    .format(_selectedSelesaiCuti);
              }
            },
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Tanggal Mulai Cuti',
            ),
          ),
          TextFormField(
            controller: selesaiCutiController,
            showCursor: false,
            readOnly: true,
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              DateTime newDateTime = await showRoundedDatePicker(
                context: context,
                initialDate: _selectedSelesaiCuti,
                firstDate: _selectedMulaiCuti,
                lastDate: DateTime(DateTime.now().year + 1),
                borderRadius: 16,
              );
              if (newDateTime != null) {
                selesaiCutiController.text =
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
                (context) {};
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
