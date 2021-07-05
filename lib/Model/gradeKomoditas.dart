class GradeKomoditas {
    GradeKomoditas({
        required this.idGradeKomoditas,
        required this.idKomoditas,
        required this.namaGrade,
        required this.keterangan,
        required this.status,
        required this.gambar,
        required this.updatedAt,
        required this.createdAt,
        required this.namaKomoditas,
    });

    int idGradeKomoditas;
    int idKomoditas;
    String namaGrade;
    String keterangan;
    String status;
    String gambar;
    String updatedAt;
    String createdAt;
    String namaKomoditas;

    factory GradeKomoditas.fromJson(Map<String, dynamic> json) => GradeKomoditas(
        idGradeKomoditas: json["id_grade_komoditas"] as int,
        idKomoditas: json["id_komoditas"] as int,
        namaGrade: json["nama_grade"]==null?'': json["nama_grade"] as String,
        keterangan: json["keterangan"] == null ? '' : json["keterangan"] as String,
        status: json["status"]==null?'': json["status"] as String,
        gambar: json["gambar"]==null?'':json["gambar"] as String,
        updatedAt: json["updated_at"] == null ? '' : json["updated_at"] as String,
        createdAt: json["created_at"] == null ? '' : json["created_at"] as String,
        namaKomoditas: json["nama_komoditas"]==null?'':json["nama_komoditas"] as String,
    );

    // Map<String, dynamic> toJson() => {
    //     "id_grade_komoditas": idGradeKomoditas,
    //     "id_komoditas": idKomoditas,
    //     "nama_grade": namaGrade,
    //     "keterangan": keterangan == null ? null : keterangan,
    //     "status": statusValues.reverse[status],
    //     "gambar": gambar,
    //     "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    //     "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    //     "nama_komoditas": namaKomoditas,
    // };
}