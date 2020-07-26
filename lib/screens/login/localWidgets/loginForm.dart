import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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

  void login(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.mail,
              ),
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              TextFormField(
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
            height: 15.0,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                login(context);
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
