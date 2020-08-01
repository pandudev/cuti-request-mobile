import 'package:cuti_flutter_mobile/models/penggunaModel.dart';
import 'package:firebase_database/firebase_database.dart';

class PenggunaService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<Pengguna> getPengguna(String uid) async {
    Pengguna retVal = Pengguna();

    try {
      await _database
          .reference()
          .child('pengguna')
          .child(uid)
          .once()
          .then((DataSnapshot snapshot) => {
                retVal.uid = uid,
                retVal.nip = snapshot.value['nip'],
                retVal.nama = snapshot.value['nama'],
                retVal.jenisKelamin = snapshot.value['jenisKelamin'],
                retVal.telepon = snapshot.value['telepon'],
                retVal.email = snapshot.value['email'],
                retVal.jabatan = snapshot.value['jabatan'],
                retVal.role = snapshot.value['role'],
              });
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
