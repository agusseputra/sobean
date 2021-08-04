class Kelompok {
    Kelompok({
        required this.idKelompokTani,
        required this.idDesa,
        required this.namaKelompok,
        required this.status,
        required this.idKecamatan,
        required this.kodeDesa,
        required this.namaDesa,
        required this.jmlAnggota,
    });

    int idKelompokTani;
    int idDesa;
    String namaKelompok;
    String status;
    String idKecamatan;
    String kodeDesa;
    String namaDesa;
    String jmlAnggota;

    factory Kelompok.fromJson(Map<String, dynamic> json) => Kelompok(
        idKelompokTani: json["id_kelompok_tani"] as int,
        idDesa: json["id_desa"] as int,
        namaKelompok: json["nama_kelompok"]==null?'':json["nama_kelompok"].toString(),
        status: json["status"]==null?'':json["status"].toString(),
        idKecamatan: json["id_kecamatan"]==null?'':json["id_kecamatan"].toString(),
        kodeDesa: json["kode_desa"]==null?'':json["kode_desa"].toString(),
        namaDesa: json["nama_desa"]==null?'':json["nama_desa"].toString(),
        jmlAnggota: json["jml_anggota"]==null?'':json["jml_anggota"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id_kelompok_tani": idKelompokTani,
        "id_desa": idDesa,
        "nama_kelompok": namaKelompok,
        "status": status,
        "id_kecamatan": idKecamatan,
        "kode_desa": kodeDesa,
        "nama_desa": namaDesa,
        "jml_anggota": jmlAnggota,
    };
}
