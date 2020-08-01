import 'package:cuti_flutter_mobile/models/pengajuanModel.dart';
import 'package:firebase_database/firebase_database.dart';

class PengajuanService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<String> createPengajuan(Pengajuan pengajuan) async {
    String retVal = "error";

    try {
      await _database
          .reference()
          .child('pengajuan')
          .push()
          .set(pengajuan.toJson());
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  // DataSnapshot getPengajuan(String uid) {
  //   DataSnapshot retVal;

  //   try {
  //     _database
  //         .reference()
  //         .child('pengajuan')
  //         .child(now.year.toString())
  //         .once()
  //         .then((DataSnapshot snapshot) => {retVal = snapshot});

  //     print(retVal);
  //   } catch (e) {
  //     print(e);
  //   }

  //   return retVal;
  // }
}
