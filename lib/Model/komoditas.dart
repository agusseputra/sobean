class Komoditas {
    Komoditas({
        required this.idGradeKomoditas,
        required this.namaGrade,
        required this.keterangan,
        required this.status,
        required this.gambar,
    });

    int idGradeKomoditas;
    String namaGrade;
    String keterangan;
    String status;
    String gambar;

    factory Komoditas.fromJson(Map<String, dynamic> json) => Komoditas(
        idGradeKomoditas: json["id_grade_komoditas"] as int,
        namaGrade: json["nama_grade"] == null ? '' :json["nama_grade"] as String,
        keterangan: json["keterangan"] == null ? '' : json["keterangan"] as String,
        status: json["status"]== null ? '' :json["status"] as String,
        gambar: json["gambar"] == null ? '' :json["gambar"] as String,
    );
}