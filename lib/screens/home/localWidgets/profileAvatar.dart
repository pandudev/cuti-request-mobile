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
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }

    String filename = widget._pengguna.uid;
    StorageReference ref =
        FirebaseStorage.instance.ref().child('pengguna').child(filename);
    StorageUploadTask uploadTask = ref.putFile(image);
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
            backgroundImage: photoUrl == "" ? null : NetworkImage(photoUrl),
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
                upload();
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
