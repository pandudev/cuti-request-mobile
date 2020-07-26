import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/user.jpg'),
            radius: 65,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt,
              ),
              iconSize: 25,
              color: Colors.blue[900],
            ),
          ),
        )
      ],
    );
  }
}
