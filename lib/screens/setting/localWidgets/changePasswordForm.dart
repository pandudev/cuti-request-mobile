import 'package:flutter/material.dart';

class ChangePasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      children: <Widget>[
        TextFormField(
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Password Lama',
          ),
        ),
        TextFormField(
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Password Baru',
          ),
        ),
        TextFormField(
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Ulangi Password',
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
              'UBAH PASSWORD',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
