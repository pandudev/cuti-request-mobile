import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:cuti_flutter_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm>
    with Validation {
  final formKey = GlobalKey<FormState>();

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void changePassword() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      PenggunaState _penggunaState =
          Provider.of<PenggunaState>(context, listen: false);

      try {
        String _returnString = await _penggunaState.changePassword(
            _oldPasswordController.text, _newPasswordController.text);

        if (_returnString == 'success') {
          _oldPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();

          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Ganti password berhasil',
              ),
              backgroundColor: Colors.green,
              duration: Duration(
                seconds: 2,
              ),
            ),
          );
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Password lama salah!',
              ),
              duration: Duration(
                seconds: 2,
              ),
            ),
          );
        }
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Wrap(
        runSpacing: 10,
        children: <Widget>[
          TextFormField(
            validator: validatePassword,
            controller: _oldPasswordController,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Password Lama',
            ),
          ),
          TextFormField(
            validator: validatePassword,
            controller: _newPasswordController,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Password Baru',
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value != _newPasswordController.text) {
                return 'Password harus sama';
              }
              return null;
            },
            controller: _confirmPasswordController,
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
                changePassword();
              },
              elevation: 2,
              child: Text(
                'UBAH PASSWORD',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
