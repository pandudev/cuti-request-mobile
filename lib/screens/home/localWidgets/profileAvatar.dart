import 'dart:async';

import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  ProfileAvatar(this._pengguna);

  final Pengguna _pengguna;

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  String photoUrl = "";
  dynamic imageFile;

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(12.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (picture == null) {
      return;
    } else {
      this.setState(() {
        imageFile = picture;
      });
      upload();
    }
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return;
    } else {
      this.setState(() {
        imageFile = picture;
      });
      upload();
    }
    Navigator.of(context).pop();
  }

  Future<void> getPhotoUrl() async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('pengguna')
        .child(widget._pengguna.uid);
    try {
      String url = await ref.getDownloadURL();
      setState(() {
        photoUrl = url;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> upload() async {
    String filename = widget._pengguna.uid;
    StorageReference ref =
        FirebaseStorage.instance.ref().child('pengguna').child(filename);
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) async {
      if (event.type == StorageTaskEventType.success) {
        var downloadUrl = await event.snapshot.ref.getDownloadURL();

        setState(() {
          photoUrl = downloadUrl;
        });
      }
    });

    await uploadTask.onComplete;
    streamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    getPhotoUrl();
  }

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
            backgroundImage: photoUrl == ""
                ? AssetImage('assets/images/user.png')
                : NetworkImage(photoUrl),
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
              onPressed: () {
                _showSelectionDialog(context);
              },
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
