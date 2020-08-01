import 'package:firebase_database/firebase_database.dart';

class Pengajuan {
  String key;
  String penggunaId;
  int tanggalPengajuan;
  int tanggalMulaiCuti;
  int tanggalSelesaiCuti;
  String jenisCuti;
  String keterangan;
  String statusCuti;
  String tahunCuti;

  Pengajuan(
      {this.key,
      this.penggunaId,
      this.tanggalPengajuan,
      this.tanggalMulaiCuti,
      this.tanggalSelesaiCuti,
      this.jenisCuti,
      this.keterangan,
      this.statusCuti,
      this.tahunCuti});

  Pengajuan.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    penggunaId = snapshot.value['penggunaId'];
    tanggalPengajuan = snapshot.value['tanggalPengajuan'];
    tanggalMulaiCuti = snapshot.value['tanggalMulaiCuti'];
    tanggalSelesaiCuti = snapshot.value['tanggalSelesaiCuti'];
    jenisCuti = snapshot.value['jenisCuti'];
    keterangan = snapshot.value['keterangan'];
    statusCuti = snapshot.value['statusCuti'];
    tahunCuti = snapshot.value['tahunCuti'];
  }

  toJson() {
    return {
      "penggunaId": penggunaId,
      "tanggalPengajuan": tanggalPengajuan,
      "tanggalMulaiCuti": tanggalMulaiCuti,
      "tanggalSelesaiCuti": tanggalSelesaiCuti,
      "jenisCuti": jenisCuti,
      "keterangan": keterangan,
      "statusCuti": statusCuti,
      "tahunCuti": tahunCuti,
    };
  }
}
