import 'package:cuti_flutter_mobile/screens/home/homeScreen.dart';
import 'package:cuti_flutter_mobile/states/penggunaState.dart';
import 'package:cuti_flutter_mobile/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with Validation {
  final formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool hidePassword = true;
  IconData passwordIcon = Icons.visibility;

  void togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
      if (hidePassword) {
        passwordIcon = Icons.visibility;
      } else {
        passwordIcon = Icons.visibility_off;
      }
    });
  }

  void login(String email, String password, BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      PenggunaState _penggunaState =
          Provider.of<PenggunaState>(context, listen: false);

      try {
        String _returnString = await _penggunaState.signIn(email, password);
        if (_returnString == 'success') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'Login gagal!',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 2,
            ),
          ));
        }
      } catch (e) {
        print(e);
      }
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
            validator: validateEmail,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.mail,
              ),
              hintText: 'Email',
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              TextFormField(
                validator: validatePassword,
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(passwordIcon),
                onPressed: () {
                  togglePassword();
                },
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                login(_emailController.text.trim(), _passwordController.text,
                    context);
              },
              elevation: 2,
              child: Text(
                'LOGIN',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
