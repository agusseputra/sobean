class Penjual {
    Penjual({
        required this.idPenjual,
        required this.nama,
        required this.nik,
        required this.alamat,
        required this.createdAt,
        required this.updatedAt,
        required this.telp,
        required this.idAnggotaTani,
        required this.idPengguna,
        required this.idKelompokTani,
        required this.status,
        required this.noKartu,
        required this.idDesa,
        required this.namaKelompok,
        required this.namaDesa,
        required this.foto
    });

    int idPenjual;
    String nama;
    String nik;
    String alamat;
    String createdAt;
    String updatedAt;
    String telp;
    int idAnggotaTani;
    int idPengguna;
    int idKelompokTani;
    String status;
    String noKartu;
    int idDesa;
    String namaKelompok;
    String namaDesa;
    String foto;

    factory Penjual.fromJson(Map<String, dynamic> json) => Penjual(
        idPenjual: json["id_penjual"] as int,
        nama: json["nama"]==null?'':json["nama"] as String,
        nik: json["nik"]==null?'':json["nik"] as String,
        alamat: json["alamat"]==null?'':json["alamat"] as String,
        createdAt: json["created_at"] ==null?'': json["created_at"] as String,
        updatedAt: json["updated_at"] == null ? '' : json["updated_at"] as String,
        telp: json["telp"] == null ? '' : json["telp"] as String,
        idAnggotaTani: json["id_anggota_tani"] == null ? 0 : json["id_anggota_tani"] as int,
        idPengguna: json["id_pengguna"] == null ? 0 : json["id_pengguna"] as int,
        idKelompokTani: json["id_kelompok_tani"] == null ? 0 : json["id_kelompok_tani"] as int,
        status: json["status"] == null ? '' : json["status"] as String,
        noKartu: json["no_kartu"] == null ? '' :  json["no_kartu"] as String,
        idDesa: json["id_desa"] == null ? 0 : json["id_desa"] as int,
        namaKelompok: json["nama_kelompok"]  == null ? '' : json["nama_kelompok"] as String,
        namaDesa: json["nama_desa"]  == null ? '' : json["nama_desa"] as String,
        foto: json["foto"]  == null ? 'https://png.pngtree.com/png-vector/20190704/ourlarge/pngtree-businessman-user-avatar-free-vector-png-image_1538405.jpg' : "http://192.168.100.128/siprotani/files/petani/"+json["foto"] as String,
    );
    static List<Penjual> fromJsonList(List list) {
    return list.map((item) => Penjual.fromJson(item)).toList();
  }
  String userAsString() {
    return '${this.nama} ${this.namaKelompok}';
  }
}
