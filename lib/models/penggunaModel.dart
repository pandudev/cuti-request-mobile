import 'package:firebase_database/firebase_database.dart';

class Pengguna {
  String uid;
  String nip;
  String nama;
  String jenisKelamin;
  String telepon;
  String email;
  String jabatan;
  String role;

  Pengguna(
      {this.uid,
      this.nip,
      this.nama,
      this.jenisKelamin,
      this.telepon,
      this.email,
      this.jabatan,
      this.role});

  Pengguna.fromSnapshot(DataSnapshot snapshot) {
    uid = snapshot.key;
    nip = snapshot.value['nip'];
    nama = snapshot.value['nama'];
    jenisKelamin = snapshot.value['jenisKelamin'];
    telepon = snapshot.value['telepon'];
    email = snapshot.value['email'];
    jabatan = snapshot.value['jabatan'];
    role = snapshot.value['role'];
  }
}
